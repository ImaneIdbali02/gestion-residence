package com.imane.residence.gestion_residence.service.serviceImp;

import com.imane.residence.gestion_residence.exceptions.PermissionDeniedException;
import com.imane.residence.gestion_residence.models.dto.AdminDTO;
import com.imane.residence.gestion_residence.models.dto.ChamberDTO;
import com.imane.residence.gestion_residence.models.dto.EtudiantDTO;
import com.imane.residence.gestion_residence.models.dto.UserDTO;
import com.imane.residence.gestion_residence.models.entities.Admin;
import com.imane.residence.gestion_residence.models.entities.Chamber;
import com.imane.residence.gestion_residence.models.entities.Etudiant;
import com.imane.residence.gestion_residence.models.entities.Utilisateur;
import com.imane.residence.gestion_residence.models.enums.Role;
import com.imane.residence.gestion_residence.models.enums.StatusChamber;
import com.imane.residence.gestion_residence.models.enums.StatutEtudiant;
import com.imane.residence.gestion_residence.models.enums.Typechamber;
import com.imane.residence.gestion_residence.repositories.AdminRepo;
import com.imane.residence.gestion_residence.repositories.ChamberRepo;
import com.imane.residence.gestion_residence.repositories.EtudiantRepo;
import com.imane.residence.gestion_residence.repositories.UtilisateurRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.AdminService;
import lombok.RequiredArgsConstructor;
import org.apache.catalina.User;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AdminserviceImp implements AdminService {

    private final AdminRepo adminRepository;
    private final UtilisateurRepo utilisateurRepository;
    private final EtudiantRepo etudiantRepository;
    private final ChamberRepo chambreRepository;
    private final ModelMapper mapper;
    private final PasswordEncoder passwordEncoder;
    private static final Logger log = LoggerFactory.getLogger(AdminserviceImp.class);

    public AdminDTO createAdmin(AdminDTO adminDTO) {
        log.info("Début de la création d'un admin");

        // Mapper UtilisateurDTO vers Utilisateur
        Utilisateur utilisateur = mapper.map(adminDTO.getUtilisateur(), Utilisateur.class);
        utilisateur.setPassword(passwordEncoder.encode(utilisateur.getPassword())); // Encoder le mot de passe
        utilisateur.setRole(Role.ADMIN); // Définir le rôle comme ADMIN

        utilisateur = utilisateurRepository.save(utilisateur);

        // Vérifier si l'utilisateur est déjà un admin
        if (adminRepository.existsByUtilisateur(utilisateur)) {
            throw new RuntimeException("Cet utilisateur est déjà un administrateur");
        }

        // Mapper AdminDTO vers Admin
        Admin admin = mapper.map(adminDTO, Admin.class);
        admin.setUtilisateur(utilisateur);

        // Sauvegarder l'utilisateur et l'admin
        admin = adminRepository.save(admin);

        log.info("Admin créé avec succès, ID: {}", admin.getId());
        return mapper.map(admin, AdminDTO.class);
    }

    @Override
    public AdminDTO getAdminById(Long id) {
        return adminRepository.findById(id)
                .map(admin -> mapper.map(admin, AdminDTO.class))
                .orElseThrow(() -> new RuntimeException("Admin non trouvé"));
    }

    @Override
    public AdminDTO updateAdmin(Long id, AdminDTO adminDTO) {
        Admin admin = adminRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Admin non trouvé"));

        adminDTO.setUtilisateur(mapper.map(admin.getUtilisateur(), UserDTO.class));

        mapper.map(adminDTO, admin);
        admin = adminRepository.save(admin);
        return mapper.map(admin, AdminDTO.class);
    }

    @Override
    public void deleteAdmin(Long id) {
        Admin admin = adminRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Admin non trouvé"));

        Utilisateur utilisateur = admin.getUtilisateur();
        utilisateur.setRole(Role.ADMIN);
        utilisateurRepository.save(utilisateur);

        adminRepository.deleteById(id);
        log.info("Admin supprimé avec succès, ID: {}", id);
    }

    @Override
    public List<AdminDTO> getAllAdmins() {
        return adminRepository.findAll().stream()
                .map(admin -> mapper.map(admin, AdminDTO.class))
                .collect(Collectors.toList());
    }



    @Override
    public EtudiantDTO createEtudiantEtAssignerChambre(EtudiantDTO etudiantDTO, Long chambreId, Typechamber typechamber) {
        // 1. Créer l'utilisateur associé
        Utilisateur utilisateur = mapper.map(etudiantDTO.getUtilisateur(), Utilisateur.class);
        utilisateur.setPassword(passwordEncoder.encode(utilisateur.getPassword()));
        utilisateur.setRole(com.imane.residence.gestion_residence.models.enums.Role.ETUDIANT);
        utilisateur = utilisateurRepository.save(utilisateur);

        // 2. Créer l'étudiant
        log.info("Création de l'étudiant");
        Etudiant etudiant = mapper.map(etudiantDTO, Etudiant.class);
        etudiant.setUtilisateur(utilisateur);
        etudiant = etudiantRepository.save(etudiant);
        log.info("Étudiant créé avec succès, ID: {}", etudiant.getId());

        // 3. Assigner la chambre
        log.info("Assignation de chambre pour l'étudiant: {}", etudiant.getId());
        Chamber chambre = chambreRepository.findById(chambreId)
                .orElseThrow(() -> new RuntimeException("Chambre non trouvée"));
        if (etudiant.getChambres() != null) {
            throw new RuntimeException("L'étudiant a déjà une chambre attribuée");
        }
        etudiant.setChambres(chambre);
        chambre.setStatut(StatusChamber.OCCUPEE);
        chambreRepository.save(chambre);
        etudiant = etudiantRepository.save(etudiant);
        log.info("Chambre {} assignée à l'étudiant {}", chambre.getId(), etudiant.getId());

        // 4. Retourner le DTO complet
        EtudiantDTO resultDTO = mapper.map(etudiant, EtudiantDTO.class);
        resultDTO.setUtilisateur(mapper.map(utilisateur, com.imane.residence.gestion_residence.models.dto.UserDTO.class));
        return resultDTO;
    }

    @Override
    public void libererChambre(Long etudiantId) {
        log.info("Libération de chambre pour l'étudiant: {}", etudiantId);

        Etudiant etudiant = etudiantRepository.findById(etudiantId)
                .orElseThrow(() -> new RuntimeException("Étudiant non trouvé"));

        if (etudiant.getChambres() != null) {
            Chamber chambre = etudiant.getChambres();
            chambre.setStatut(StatusChamber.DISPONIBLE);
            chambreRepository.save(chambre);

            etudiant.setChambres(null);
            etudiantRepository.save(etudiant);
        }
    }

    @Override
    public void deleteEtudiant(Long id) {
        if (!etudiantRepository.existsById(id)) {
            throw new RuntimeException("Étudiant non trouvé");
        }
        etudiantRepository.deleteById(id);
    }





}
