package com.imane.residence.gestion_residence.models.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StatistiquesDTO {
    private String type;
    private int valeur;
    private double pourcentage;
}
