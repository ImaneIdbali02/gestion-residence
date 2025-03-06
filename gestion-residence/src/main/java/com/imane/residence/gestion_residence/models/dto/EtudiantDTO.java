package com.imane.residence.gestion_residence.models.dto;

import com.imane.residence.gestion_residence.models.entities.Chamber;
import com.imane.residence.gestion_residence.models.entities.Paiement;
import com.imane.residence.gestion_residence.models.enums.StatutEtudiant;
import com.imane.residence.gestion_residence.models.enums.StatutPaiement;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Data
public class EtudiantDTO {

    private Long id;
    private UserDTO utilisateur;
    private String numeroEtudiant;
    private String etablissement;
    private String niveauEtudes;

    @NotNull(message= "Date de début est obligatoire")
    private LocalDate dateDebutSejour;

    private LocalDate dateFinSejour;
    private StatutEtudiant statut;
    private Chamber chambres;
    @Enumerated(EnumType.STRING)
    private StatutPaiement statutPaiement = StatutPaiement.EN_ATTENTE;
}
