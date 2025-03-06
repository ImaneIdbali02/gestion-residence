package com.imane.residence.gestion_residence.models.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.imane.residence.gestion_residence.models.enums.StatutPaiement;
import com.imane.residence.gestion_residence.models.enums.TypeMethodePaiement;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.YearMonth;


@Data
@NoArgsConstructor
public class PaiementDTO {
    private Long id;
    private String numeroEtudiant;
    private double montant;
    private LocalDateTime datePaiement;
    @JsonFormat(pattern = "yyyy-MM")
    private YearMonth moisConcerne;
    private StatutPaiement statut;
    private TypeMethodePaiement methodePaiement ;


}

