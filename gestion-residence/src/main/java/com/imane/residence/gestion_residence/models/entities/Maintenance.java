package com.imane.residence.gestion_residence.models.entities;

import com.imane.residence.gestion_residence.models.enums.MaintenancePriorite;
import com.imane.residence.gestion_residence.models.enums.StatutMaintenance;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;


import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "maintenances")
public class Maintenance{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @OneToOne
    @JoinColumn(name = "etudiant_id", unique=true)
    private Etudiant etudiant ;

    @ManyToOne
    @JoinColumn(name = "chambres_id")
    @NotNull(message = "La chambre est obligatoire")
    private Chamber chambres;

    @NotBlank(message = "La description est obligatoire")
    private String description;

    @NotNull(message = "La date de signalement est obligatoire")
    private LocalDateTime dateSignalement = LocalDateTime.now();

    private LocalDateTime dateResolution;

    @Enumerated(EnumType.STRING)
    private MaintenancePriorite priorite = MaintenancePriorite.NORMALE;

    @Enumerated(EnumType.STRING)
    private StatutMaintenance statut = StatutMaintenance.EN_ATTENTE;

    @ManyToOne
    @JoinColumn(name = "signale_par_id")
    private Utilisateur signaleParId;

    @ManyToOne
    @JoinColumn(name = "assigne_a_id")
    private PersonnelMaintenance assigneA;

    private String commentaires;

    private LocalDate dateCreation;

}
