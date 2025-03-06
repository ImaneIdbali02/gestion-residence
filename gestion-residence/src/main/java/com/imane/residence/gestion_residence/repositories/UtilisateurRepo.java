package com.imane.residence.gestion_residence.repositories;


import com.imane.residence.gestion_residence.models.entities.Etudiant;
import com.imane.residence.gestion_residence.models.entities.Utilisateur;
import com.imane.residence.gestion_residence.models.enums.Role;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface UtilisateurRepo extends JpaRepository<Utilisateur, Long> {
    Optional<Utilisateur> findByEmail(String Email);
    boolean  existsByEmail(String Email);
    Optional<Utilisateur> findByName(String username);
    List<Utilisateur> findByRole(Role role);
    List<Utilisateur> findByActif(boolean actif);
    @Query("SELECT u FROM Utilisateur u WHERE " +
            "LOWER(u.name) LIKE LOWER(CONCAT('%', :terme, '%')) OR " +
            "LOWER(u.email) LIKE LOWER(CONCAT('%', :terme, '%'))")
    List<Utilisateur> rechercher(@Param("terme") String terme);



    String email(@Email(message="L'email est invalide") @NotBlank(message="L'email est obligatoire") String email);
}

