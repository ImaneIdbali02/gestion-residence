package com.imane.residence.gestion_residence.models.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class BilanFinancier {
    private double totalDu;
    private double totalPaye;
    private double tauxRecouvrement;

    public double getTauxRecouvrement() {
        return totalDu == 0 ? 0 : (totalPaye / totalDu) * 100;
    }
}
