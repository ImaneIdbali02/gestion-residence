package com.imane.residence.gestion_residence.repositories;

import com.imane.residence.gestion_residence.models.entities.Etudiant;
import com.imane.residence.gestion_residence.models.entities.Utilisateur;
import com.imane.residence.gestion_residence.models.enums.StatutEtudiant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.time.LocalDateTime;
import java.util.Optional;

public interface EtudiantRepo extends JpaRepository<Etudiant, Long> {
    Optional<Etudiant> findByUtilisateur_Id(Long utilisateurId);
    Optional<Etudiant> findByUtilisateur(Utilisateur utilisateur);

    Optional<Etudiant> findByNumeroEtudiant(String numeroEtudiant);
    List<Etudiant> findByStatut(StatutEtudiant statut);
    List<Etudiant> findByEtablissement(String etablissement);

    @Query("SELECT e FROM Etudiant e WHERE e.dateFinSejour <= :date")
    List<Etudiant> findByDateFinSejourBefore(@Param("date") LocalDateTime date);

    @Query("SELECT e FROM Etudiant e WHERE e.chambres.id = :chambreId")
    List<Etudiant> findByChambreId(@Param("chambreId") Long chambreId);

    @Query("SELECT e FROM Etudiant e " +
            "WHERE (:statut IS NULL OR e.statut = :statut) " +
            "AND (:dateDebut IS NULL OR e.dateDebutSejour >= :dateDebut) " +
            "AND (:dateFin IS NULL OR e.dateFinSejour <= :dateFin)")
    List<Etudiant> rechercheAvancee(
            @Param("statut") StatutEtudiant statut,
            @Param("dateDebut") LocalDate dateDebut,
            @Param("dateFin") LocalDate dateFin
    );

    @Query("SELECT e FROM Etudiant e WHERE " +
            "LOWER(e.utilisateur.name) LIKE LOWER(CONCAT('%', :terme, '%')) OR " +
            "LOWER(e.utilisateur.prenom) LIKE LOWER(CONCAT('%', :terme, '%')) OR " +
            "LOWER(e.utilisateur.email) LIKE LOWER(CONCAT('%', :terme, '%'))")
    List<Etudiant> rechercher(@Param("terme") String terme);

    @Query("SELECT e FROM Etudiant e WHERE e.chambres IS NULL")
    List<Etudiant> findSansChambre();

    boolean existsByNumeroEtudiant(String numeroEtudiant);
}
