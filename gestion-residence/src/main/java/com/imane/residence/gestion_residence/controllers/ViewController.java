package com.imane.residence.gestion_residence.controllers;

import com.imane.residence.gestion_residence.models.dto.ChamberDTO;
import com.imane.residence.gestion_residence.models.dto.UserDTO;
import com.imane.residence.gestion_residence.models.entities.Etudiant;
import com.imane.residence.gestion_residence.models.entities.Utilisateur;
import com.imane.residence.gestion_residence.repositories.UtilisateurRepo;
import com.imane.residence.gestion_residence.repositories.EtudiantRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.Chamberservice;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/api/viewcontroller")
public class ViewController {

    private final ModelMapper mapper;
    private final UtilisateurRepo utilisateurRepository;
    private final EtudiantRepo EtudiantRepository;
    private final Chamberservice chamberservice;


    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error, Model model) {
        if (error != null) {
            model.addAttribute("errorMessage", "Email ou mot de passe incorrect !");
        }
        return "login";
    }

    @GetMapping("/redirectByRole")
    public String redirectBasedOnRole() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth.getAuthorities().stream()
                .anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/api/viewcontroller/profileAdmin";
        }
        return "redirect:/api/viewcontroller/profileEtudiant";
    }

    @GetMapping("/profileAdmin")
    @PreAuthorize("hasRole('ADMIN')")
    public String adminPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        String email = userDetails.getUsername(); // Récupère l'email

        // Utilise l'instance du repository pour appeler findByEmail
        Utilisateur utilisateur = utilisateurRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Utilisateur non trouvé"));

        // Utilise ModelMapper pour convertir Utilisateur en UserDTO
        UserDTO userDTO = mapper.map(utilisateur, UserDTO.class);
        List<ChamberDTO> chambres = chamberservice.getAllChambres();

        model.addAttribute("user", userDTO);
        model.addAttribute("chambres", chambres);
        return "profileAdmin";
    }


    @GetMapping("/profileEtudiant")
    @PreAuthorize("hasRole('ETUDIANT')") // Sécuriser l'accès
    public String etudiantPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        String email = userDetails.getUsername();

        // Fetch the Utilisateur entity
        Utilisateur utilisateur = utilisateurRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Utilisateur non trouvé"));

        // Fetch the associated Etudiant entity
        Etudiant etudiant = EtudiantRepository.findByUtilisateur(utilisateur)
                .orElseThrow(() -> new RuntimeException("Étudiant non trouvé pour cet utilisateur"));

        // Add the Etudiant object to the model
        model.addAttribute("etudiant", etudiant);
        return "profileEtudiant";
    }

    @GetMapping("/gestion-chambres")
    public String gestionChambres() {
        return "forward:/pages/gestion-chambres.html"; // Redirige vers le fichier statique
    }

    @GetMapping("/gestion-residents")
    public String gestionResidents() {
        return "forward:/pages/gestion-residents.html"; // Redirige vers le fichier statique
    }

    @GetMapping("/gestion-paiement")
    public String gestionPaiement() {
        return "forward:/pages/gestion-paiement.html"; // Redirige vers le fichier statique
    }


}