package com.imane.residence.gestion_residence.repositories;

import com.imane.residence.gestion_residence.models.entities.Maintenance;
import com.imane.residence.gestion_residence.models.enums.MaintenancePriorite;
import com.imane.residence.gestion_residence.models.enums.StatutMaintenance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface MaintenanceRepo extends JpaRepository<Maintenance, Long> {
    List<Maintenance> findByChambresId(Long chambreId);
    List<Maintenance> findByStatut(StatutMaintenance statut);
    List<Maintenance> findByPriorite(MaintenancePriorite priorite);
    List<Maintenance> findByAssigneAId(Long personnelId);
    List<Maintenance> findByDateCreationBetween(LocalDate debut, LocalDate fin);
    long countByStatut(StatutMaintenance statut);
    long countByPriorite(MaintenancePriorite priorite);

    @Query("SELECT m FROM Maintenance m WHERE m.statut = 'EN_ATTENTE' ORDER BY m.priorite DESC")
    List<Maintenance> findTasksEnAttente();

    @Query("SELECT m FROM Maintenance m WHERE m.assigneA.id = :personnelId AND m.statut != 'TERMINE'")
    List<Maintenance> findTachesEnCoursParPersonnel(@Param("personnelId") Long personnelId);

    @Query("SELECT m FROM Maintenance m WHERE m.chambres.id = :chambreId")
    List<Maintenance> findByChambre(@Param("chambreId") Long chambreId);
}
