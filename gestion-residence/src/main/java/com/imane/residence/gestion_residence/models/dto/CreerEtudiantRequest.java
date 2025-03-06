package com.imane.residence.gestion_residence.models.dto;

import com.imane.residence.gestion_residence.models.enums.Typechamber;
import lombok.Data;

@Data
public class CreerEtudiantRequest {
    private EtudiantDTO etudiantDTO;
    private Long chambres;
    private Typechamber typeChambre;

}

