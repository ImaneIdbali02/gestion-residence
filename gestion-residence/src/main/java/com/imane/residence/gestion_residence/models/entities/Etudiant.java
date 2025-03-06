package com.imane.residence.gestion_residence.models.entities;

import com.imane.residence.gestion_residence.models.enums.StatutEtudiant;
import com.imane.residence.gestion_residence.models.enums.StatutPaiement;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "etudiant")

public class Etudiant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;



    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "utilisateur_id", unique=true)
    private Utilisateur utilisateur;

    @NotBlank(message = "Le numéro étudiant est obligatoire")
    @Column(unique=true)
    private String numeroEtudiant;

    @ManyToOne
    @JoinColumn(name="chambres_id")
    private Chamber chambres;

    private String etablissement;

    private String niveauEtudes;

    @NotNull(message= "Date de début est obligatoire")
    private LocalDate dateDebutSejour;



    private LocalDate dateFinSejour;

    @Enumerated(EnumType.STRING)
    private StatutEtudiant statut = StatutEtudiant.ACTIF;

    @Enumerated(EnumType.STRING)
    private StatutPaiement statutPaiement = StatutPaiement.EN_ATTENTE;




}
