package com.imane.residence.gestion_residence.models.dto;

import com.imane.residence.gestion_residence.models.enums.StatusChamber;
import com.imane.residence.gestion_residence.models.enums.Typechamber;
import lombok.Data;

@Data
public class CritereRechercheChambre {
    private Typechamber type;
    private StatusChamber statut;
    private Double loyerMin;
    private Double loyerMax;
}
