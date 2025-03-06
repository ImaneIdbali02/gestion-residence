package com.imane.residence.gestion_residence.models.dto;

import com.imane.residence.gestion_residence.models.enums.StatutMaintenance;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class MaintenanceDTO {
    private Long id;
    private ChamberDTO chamber;
    private String description;
    private LocalDateTime dateSignalement;
    private LocalDateTime dateResolution;
    //private PrioriteMaintenance priorite;
    private StatutMaintenance statut;
    private UserDTO signalePar;
    private String commentaires;
    private LocalDate dateCreation;
}
