package com.imane.residence.gestion_residence.models.dto;

import com.imane.residence.gestion_residence.models.enums.TypeMethodePaiement;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MethodePaiementDTO {
    private Long id;
    private TypeMethodePaiement type;
    private String nom;
    private String description;
    private boolean actif;
    private String fournisseur;
    private String informationsBancaires;
    private String operateur;
}
