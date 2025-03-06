package com.imane.residence.gestion_residence.models.entities;

import com.imane.residence.gestion_residence.models.enums.Role;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "Utilisateur" )
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message="Le nom est obligatoire")
    private String name;

    @NotBlank(message="Le prenom est obligatoire")
    private String prenom;

    @Email(message="L'email est invalide")
    @NotBlank(message="L'email est obligatoire")
    @Column(unique = true)
    private String email;

    @NotBlank(message="Le mot de passe est obligatoire")
    private String password;


    @Enumerated(EnumType.STRING)
    @Column(name = "role", columnDefinition = "ENUM('ADMIN', 'ETUDIANT', 'Maintenance')")
    private Role role;

    private String telephone;

    private LocalDateTime dateCreation=LocalDateTime.now();

    private boolean actif=true;

    @Column(name = "reset_otp")
    private String resetOTP;

    @Column(name = "reset_otp_expiry")
    private LocalDateTime resetOTPExpiry;

}
