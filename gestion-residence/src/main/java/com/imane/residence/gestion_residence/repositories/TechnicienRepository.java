package com.imane.residence.gestion_residence.repositories;

import com.imane.residence.gestion_residence.models.entities.PersonnelMaintenance;
import com.imane.residence.gestion_residence.models.enums.StatutDisponibilite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TechnicienRepository extends JpaRepository<PersonnelMaintenance, Long> {
    List<PersonnelMaintenance> findByDisponibilite(StatutDisponibilite disponibilite);

    @Query("SELECT p FROM PersonnelMaintenance p WHERE SIZE(p.tachesAssignees) < 5 AND p.disponibilite = 'DISPONIBLE'")
    List<PersonnelMaintenance> findAvailableTechniciens();

    @Query("SELECT p FROM PersonnelMaintenance p WHERE p.specialite = :specialite AND p.disponibilite = 'DISPONIBLE'")
    List<PersonnelMaintenance> findBySpecialiteAndAvailable(@Param("specialite") String specialite);
}
