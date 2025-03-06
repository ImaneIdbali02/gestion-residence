package com.imane.residence.gestion_residence.repositories;

import com.imane.residence.gestion_residence.models.entities.Admin;
import com.imane.residence.gestion_residence.models.entities.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;

public interface AdminRepo extends JpaRepository<Admin, Long> {
    List<Admin> findByService(String service);
    @Query("SELECT a FROM Admin a WHERE a.utilisateur.actif = true")
    List<Admin> findAllActifs();


    Optional<Admin> findByUtilisateur(Utilisateur utilisateur);
        boolean existsByUtilisateur(Utilisateur utilisateur);
    }

