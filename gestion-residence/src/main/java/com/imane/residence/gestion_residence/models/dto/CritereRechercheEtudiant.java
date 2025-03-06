package com.imane.residence.gestion_residence.models.dto;

import com.imane.residence.gestion_residence.models.enums.StatutEtudiant;
import lombok.Data;

import java.time.LocalDate;

@Data
public class CritereRechercheEtudiant {
    private StatutEtudiant statut;
    private LocalDate dateDebutSejour;
    private LocalDate dateFinSejour;
    private String numeroEtudiant;
    private String etablissement;
    private String niveauEtudes;
    private String nom;
    private String prenom;
}
