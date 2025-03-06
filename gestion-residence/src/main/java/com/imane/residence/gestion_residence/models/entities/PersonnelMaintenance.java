package com.imane.residence.gestion_residence.models.entities;

import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name="personnel_maintenance")
public class PersonnelMaintenance {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "utilisateur_id", unique = true)
    private Utilisateur utilisateur;

    private String specialite;
    private String zoneTravail;
    private String numeroTelephoneProfessionnel;

    @OneToMany(mappedBy = "assigneA")
    private List<Maintenance> tachesAssignees = new ArrayList<Maintenance>();


}
