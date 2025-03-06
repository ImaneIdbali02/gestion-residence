package com.imane.residence.gestion_residence.models.entities;


import com.imane.residence.gestion_residence.models.enums.TypeMethodePaiement;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
  public class MethodePaiement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private TypeMethodePaiement type;

    @Column(nullable = false)
    private String nom;

    private String description;

    @Column(nullable = false)
    private boolean actif = true;

    // Pour cartes bancaires
    private String fournisseur;

    // Pour virements bancaires
    private String informationsBancaires;


}
