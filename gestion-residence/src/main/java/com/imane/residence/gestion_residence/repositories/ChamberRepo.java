package com.imane.residence.gestion_residence.repositories;

import com.imane.residence.gestion_residence.models.entities.Chamber;
import com.imane.residence.gestion_residence.models.enums.StatusChamber;
import com.imane.residence.gestion_residence.models.enums.Typechamber;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ChamberRepo extends JpaRepository<Chamber, Long> {
    Optional<Chamber> findByNumeroChambre(String numero);
    List<Chamber> findByStatut(StatusChamber statut);
    List<Chamber> findByType(Typechamber type);
    long countByStatut(StatusChamber statut);

    @Query("SELECT c FROM Chamber c WHERE c.loyerMensuel <= :maxLoyer")
    List<Chamber> findByLoyerMaximum(@Param("maxLoyer") double maxLoyer);

    @Query("SELECT c FROM Chamber c WHERE c.statut = 'DISPONIBLE' AND c.type = :type")
    List<Chamber> findDisponiblesByType(@Param("type") Typechamber typeChamber);

    @Query("SELECT c FROM Chamber c " +
            "WHERE (:type IS NULL OR c.type = :type) " +
            "AND (:statut IS NULL OR c.statut = :statut) " +
            "AND (:loyerMin IS NULL OR c.loyerMensuel >= :loyerMin) " +
            "AND (:loyerMax IS NULL OR c.loyerMensuel <= :loyerMax)")
    List<Chamber> rechercheAvancee(
            @Param("type") Typechamber type,
            @Param("statut") StatusChamber statut,
            @Param("loyerMin") Double loyerMin,
            @Param("loyerMax") Double loyerMax
    );

    @Query("SELECT c FROM Chamber c WHERE " +
            "LOWER(c.numeroChambre) LIKE LOWER(CONCAT('%', :terme, '%'))")
    List<Chamber> rechercherParNumeroChambre(@Param("terme") String terme);

    @Query("SELECT c FROM Chamber c WHERE " +
            "LOWER(c.numeroChambre) LIKE LOWER(CONCAT('%', :terme, '%'))")
    List<Chamber> rechercher(@Param("terme") String terme);



}
