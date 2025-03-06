package com.imane.residence.gestion_residence.repositories;

import com.imane.residence.gestion_residence.models.entities.Maintenance;
import com.imane.residence.gestion_residence.models.entities.PersonnelMaintenance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MaintenancePersoRepo extends JpaRepository<PersonnelMaintenance, Long> {
    List<PersonnelMaintenance> findBySpecialite(String specialite);
    List<PersonnelMaintenance> findByZoneTravail(String zoneTravail);

    @Query("SELECT p FROM PersonnelMaintenance p WHERE SIZE(p.tachesAssignees) < :maxTaches")
    List<PersonnelMaintenance> findAvailablePersonnel(@Param("maxTaches") int maxTaches);

    @Query("SELECT COUNT(t) FROM PersonnelMaintenance p " +
            "JOIN p.tachesAssignees t " +
            "WHERE p.id = :personnelId AND t.statut = 'EN_COURS'")
    int countTachesEnCours(@Param("personnelId") Long personnelId);

    @Query("SELECT m FROM Maintenance m WHERE m.chambres.id = :chambreId")
    List<Maintenance> findByChambre(@Param("chambreId") Long chambreId);
}
