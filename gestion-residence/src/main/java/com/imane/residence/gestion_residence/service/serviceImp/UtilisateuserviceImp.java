package com.imane.residence.gestion_residence.service.serviceImp;

import com.imane.residence.gestion_residence.exceptions.*;
import com.imane.residence.gestion_residence.models.dto.*;
import com.imane.residence.gestion_residence.models.entities.Utilisateur;
import com.imane.residence.gestion_residence.models.enums.Role;
import com.imane.residence.gestion_residence.repositories.UtilisateurRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.EmailService;
import com.imane.residence.gestion_residence.service.serviceInterfaces.EtudiantService;
import com.imane.residence.gestion_residence.service.serviceInterfaces.UtilisateurService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;


import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;


import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UtilisateuserviceImp implements UtilisateurService {



    private final UtilisateurRepo utilisateurRepository;
    private final PasswordEncoder passwordEncoder;
    private final ModelMapper mapper;
    private final EmailService emailService;
    private final EtudiantService etudiantService;
    private static final Logger log = LoggerFactory.getLogger(UtilisateuserviceImp.class);


    @Override
    @Transactional  // Ajout de l'annotation Transactional
    public UserDTO register(registerDTO registerDTO) {
        log.info("Début de l'enregistrement pour l'email: {}", registerDTO.getEmail());

        // Vérification de l'email
        if (utilisateurRepository.existsByEmail(registerDTO.getEmail())) {
            log.warn("Tentative d'enregistrement avec un email déjà utilisé: {}", registerDTO.getEmail());
            throw new RuntimeException("Email déjà utilisé");
        }

        try {
            // Mapping et création de l'utilisateur
            Utilisateur utilisateur = mapper.map(registerDTO, Utilisateur.class);
            log.debug("Utilisateur mappé depuis DTO: {}", utilisateur);

            // Encodage du mot de passe
            utilisateur.setPassword(passwordEncoder.encode(registerDTO.getPassword()));

            // Sauvegarde
            utilisateur = utilisateurRepository.save(utilisateur);
            log.info("Utilisateur sauvegardé avec succès, ID: {}", utilisateur.getId());

            return mapper.map(utilisateur, UserDTO.class);
        } catch (Exception e) {
            log.error("Erreur lors de l'enregistrement de l'utilisateur: ", e);
            throw e;
        }
    }



    @Override
    public UserDTO getUserById(Long id){
        return utilisateurRepository.findById(id)
                .map(user -> mapper.map(user, UserDTO.class))
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
    }

    @Override
    public UserDTO updateUser(Long id, UserDTO userDTO){

        Utilisateur utilisateur = utilisateurRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));

        mapper.map(userDTO, utilisateur);
        utilisateur = utilisateurRepository.save(utilisateur);
        return mapper.map(utilisateur, UserDTO.class);
    }

    @Override
    public void deleteUser(Long id){
        if (!utilisateurRepository.existsById(id)) {
            throw new RuntimeException("Utilisateur non trouvé");
        }
        utilisateurRepository.deleteById(id);
    }

    @Override
    public void activateUser(Long id){
        Utilisateur utilisateur = utilisateurRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
        utilisateur.setActif(true);
        utilisateurRepository.save(utilisateur);
    }

    @Override
    public void deactivateUser(Long id){
        Utilisateur utilisateur= utilisateurRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
        utilisateur.setActif(false);
        utilisateurRepository.save(utilisateur);
    }

    @Override
    public List<UserDTO> getAllUsers(){
        return utilisateurRepository.findAll().stream()
                .map(user -> mapper.map(user, UserDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<UserDTO> getUsersByRole(Role role){
        return utilisateurRepository.findByRole(role).stream()
                .map(user -> mapper.map(user, UserDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public String generateOTP() {
        return String.format("%06d", new Random().nextInt(999999));
    }

    @Override
    public void initiatePasswordReset(String email) {
        Utilisateur utilisateur = utilisateurRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("Utilisateur non trouvé"));

        String otp = generateOTP();
        utilisateur.setResetOTP(otp);
        utilisateur.setResetOTPExpiry(LocalDateTime.now().plusMinutes(15));
        utilisateurRepository.save(utilisateur);

        emailService.sendOTP(email, otp, utilisateur.getName());
    }

    @Override
    public boolean verifyOTP(String email, String otp) {
        Utilisateur utilisateur = utilisateurRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("Utilisateur non trouvé"));

        if (!otp.equals(utilisateur.getResetOTP())) {
            throw new BadRequestException("Invalid OTP code");
        }

        if (LocalDateTime.now().isAfter(utilisateur.getResetOTPExpiry())) {
            throw new BadRequestException("Code OTP expiré");
        }

        return true;
    }

    @Override
    public void resetPassword(PasswordResetDTO resetDTO) {
        if (verifyOTP(resetDTO.getEmail(), resetDTO.getOtp())) {
            Utilisateur utilisateur = utilisateurRepository.findByEmail(resetDTO.getEmail())
                    .orElseThrow(() -> new ResourceNotFoundException("Utilisateur non trouvé"));

            utilisateur.setPassword(passwordEncoder.encode(resetDTO.getNewPassword()));
            utilisateur.setResetOTP(null);
            utilisateur.setResetOTPExpiry(null);

            utilisateurRepository.save(utilisateur);
            log.info("Mot de passe réinitialisé pour : {}", resetDTO.getEmail());
        }
        }

    @Override
    public boolean changePassword(Long userId, String oldPassword, String newPassword) {
        Utilisateur utilisateur = utilisateurRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));

        if (!passwordEncoder.matches(oldPassword, utilisateur.getPassword())) {
            throw new RuntimeException("Ancien mot de passe incorrect");
        }

        utilisateur.setPassword(passwordEncoder.encode(newPassword));
        utilisateurRepository.save(utilisateur);
        return true;


    }

    @Override
    public List<UserDTO> rechercherUtilisateurs(String terme) {
        return utilisateurRepository.rechercher(terme).stream()
                .map(user -> mapper.map(user, UserDTO.class))
                .collect(Collectors.toList());
    }









}

