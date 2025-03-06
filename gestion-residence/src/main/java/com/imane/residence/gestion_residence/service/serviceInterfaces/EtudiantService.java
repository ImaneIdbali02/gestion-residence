package com.imane.residence.gestion_residence.service.serviceInterfaces;

import com.imane.residence.gestion_residence.models.dto.EtudiantDTO;
import com.imane.residence.gestion_residence.models.entities.Etudiant;
import com.imane.residence.gestion_residence.models.enums.StatutEtudiant;
import com.imane.residence.gestion_residence.models.enums.StatutPaiement;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface EtudiantService {

    EtudiantDTO getEtudiantById(Long id);
    EtudiantDTO updateEtudiant(Long id, EtudiantDTO etudiantDTO);
    List<EtudiantDTO> getAllEtudiants();
    List<EtudiantDTO> getEtudiantsByStatut(StatutEtudiant statut);
    Etudiant updateStatutPaiement(String numeroEtudiant, StatutPaiement statutPaiement);
    boolean verifierPaiementsMensualites(Long etudiantId);
    List<EtudiantDTO> getEtudiantsFinSejour(LocalDateTime date);
    List<EtudiantDTO> getEtudiantsSansChambre();
    List<EtudiantDTO> rechercheAvanceeEtudiants(StatutEtudiant statut, LocalDate dateDebut, LocalDate dateFin);
    List<EtudiantDTO> rechercherEtudiants(String terme);
    Optional<Etudiant> getEtudiantByNumero(String numeroEtudiant);
}
