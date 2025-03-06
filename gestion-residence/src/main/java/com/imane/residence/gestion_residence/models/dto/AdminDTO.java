package com.imane.residence.gestion_residence.models.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;
import java.time.LocalDate;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AdminDTO {
    private UserDTO utilisateur;
    private String service;
    private String fonction;
    private LocalDate dateDebut;
    private String numeroTelephoneProfessionnel;
}

