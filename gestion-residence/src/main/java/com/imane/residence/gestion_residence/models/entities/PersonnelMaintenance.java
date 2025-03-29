package com.imane.residence.gestion_residence.models.entities;

import com.imane.residence.gestion_residence.models.enums.StatutDisponibilite;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "personnel_maintenance")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PersonelMaintenance {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String nom;

    @Column(nullable = false)
    private String prenom;

    private String specialite;

    private String telephone;

    private String email;

    @Enumerated(EnumType.STRING)
    private StatutDisponibilite disponibilite = StatutDisponibilite.DISPONIBLE;

    @OneToMany(mappedBy = "technicien")
    private List<Maintenance> tachesAssignees = new ArrayList<>();


}
