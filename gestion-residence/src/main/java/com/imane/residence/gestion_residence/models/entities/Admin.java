package com.imane.residence.gestion_residence.models.entities;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Entity
@Data
@Table(name="admins")
public class Admin {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name="utilisateur_id",unique=true)
    private Utilisateur utilisateur;

    private String service;
    private String fonction;
    private LocalDate dateDebut;
    private String numeroTelephoneProfessionnel;


}
