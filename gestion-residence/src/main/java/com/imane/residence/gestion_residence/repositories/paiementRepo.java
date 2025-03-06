package com.imane.residence.gestion_residence.repositories;

import com.imane.residence.gestion_residence.models.entities.Paiement;
import com.imane.residence.gestion_residence.models.enums.StatutPaiement;
import com.imane.residence.gestion_residence.models.enums.TypeMethodePaiement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

public interface paiementRepo extends JpaRepository<Paiement, Long> {
    List<Paiement> findByEtudiantId(Long etudiantId);

    List<Paiement> findByStatut(StatutPaiement statut);

    List<Paiement> findByMethodePaiement(TypeMethodePaiement methodePaiement);

    @Query("SELECT p FROM Paiement p WHERE p.etudiant.id = :etudiantId AND p.moisConcerne = :mois")
    List<Paiement> findByEtudiantAndMois(
            @Param("etudiantId") Long etudiantId,
            @Param("mois") YearMonth mois
    );

    @Query("SELECT DISTINCT p.moisConcerne FROM Paiement p WHERE p.etudiant.id = :etudiantId AND p.statut = 'PAYE'")
    List<YearMonth> findMoisPayesParEtudiant(@Param("etudiantId") Long etudiantId);

    @Query("SELECT SUM(e.chambres.loyerMensuel) FROM Etudiant e " +
            "WHERE e.chambres IS NOT NULL")
    double calculerTotalDu(@Param("date") LocalDate date);

    @Query("SELECT SUM(p.montant) FROM Paiement p " +
            "WHERE p.statut = 'PAYE' AND p.datePaiement <= :date")
    double calculerTotalPaye(@Param("date") LocalDate date);

    @Query("SELECT p FROM Paiement p JOIN FETCH p.etudiant")
    List<Paiement> findAllWithEtudiant();


}
