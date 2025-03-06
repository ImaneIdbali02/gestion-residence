package com.imane.residence.gestion_residence.models.dto;

import com.imane.residence.gestion_residence.models.enums.StatutMaintenance;
import com.imane.residence.gestion_residence.models.enums.TypeMaintenance;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DemandeMaintenanceDTO {
    private Long id;
    private String numeroChambre;
    private LocalDateTime dateCreation;
    private String description;
    private TypeMaintenance type;
    private StatutMaintenance statut;
    private int tempsResolution;  // en jours
    private String commentaire;
}
