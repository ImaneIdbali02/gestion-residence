package com.imane.residence.gestion_residence.models.entities;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.imane.residence.gestion_residence.models.enums.StatutPaiement;
import com.imane.residence.gestion_residence.models.enums.TypeMethodePaiement;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;
import java.time.LocalDateTime;
import java.time.YearMonth;


@Entity
@Data
@Table(name="paiements")
public class Paiement {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="etudiant_id")
    @NotNull(message = "L'étudiant est obligatoire")
    private Etudiant etudiant;

    private String numeroEtudiant;

    @Positive(message = "Le montant doit être positif")
    private double montant;

    @NotNull(message = "La date de paiement est obligatoire")
    private LocalDateTime datePaiement = LocalDateTime.now();

    @NotNull(message = "Le mois concerné est obligatoire")
    @JsonFormat(pattern = "yyyy-MM")
    private YearMonth moisConcerne;

    @Enumerated(EnumType.STRING)
    private StatutPaiement statut = StatutPaiement.EN_ATTENTE;

    @Enumerated(EnumType.STRING)
    private TypeMethodePaiement methodePaiement;









}



