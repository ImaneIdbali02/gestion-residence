package com.imane.residence.gestion_residence.models.dto;

import com.imane.residence.gestion_residence.models.enums.TypeRecherche;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResultatRechercheDTO {
    private Long id;
    private String titre;
    private String description;
    private TypeRecherche type;
    private Map<String, Object> attributsSpecifiques;
}


