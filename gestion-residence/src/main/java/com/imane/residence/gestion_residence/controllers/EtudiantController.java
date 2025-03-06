package com.imane.residence.gestion_residence.controllers;


import com.imane.residence.gestion_residence.models.dto.EtudiantDTO;
import com.imane.residence.gestion_residence.models.entities.Etudiant;
import com.imane.residence.gestion_residence.models.enums.StatutEtudiant;
import com.imane.residence.gestion_residence.models.enums.StatutPaiement;
import com.imane.residence.gestion_residence.service.serviceInterfaces.EtudiantService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.springframework.data.jpa.domain.AbstractPersistable_.id;

@RestController
@RequestMapping("/api/etudiants")
@RequiredArgsConstructor
public class EtudiantController {
    private final EtudiantService etudiantService;
    private static final Logger log = LoggerFactory.getLogger(EtudiantController.class);





    @GetMapping("/{id}")
    public ResponseEntity<EtudiantDTO> getEtudiant(@PathVariable Long id) {
        return ResponseEntity.ok(etudiantService.getEtudiantById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<EtudiantDTO> updateEtudiant(@PathVariable Long id, @RequestBody EtudiantDTO etudiantDTO) {
        return ResponseEntity.ok(etudiantService.updateEtudiant(id, etudiantDTO));
    }



    @GetMapping
    public ResponseEntity<List<EtudiantDTO>> getAllEtudiants() {
        return ResponseEntity.ok(etudiantService.getAllEtudiants());
    }

    @GetMapping("/statut/{statut}")
    public ResponseEntity<List<EtudiantDTO>> getEtudiantsByStatut(@PathVariable StatutEtudiant statut) {
        return ResponseEntity.ok(etudiantService.getEtudiantsByStatut(statut));
    }



    @GetMapping("/{id}/paiements/verification")
    public ResponseEntity<Boolean> verifierPaiementsMensualites(@PathVariable Long id) {
        return ResponseEntity.ok(etudiantService.verifierPaiementsMensualites(id));
    }

    @GetMapping("/fin-sejour")
    public ResponseEntity<List<EtudiantDTO>> getEtudiantsFinSejour(@RequestParam LocalDateTime date) {
        return ResponseEntity.ok(etudiantService.getEtudiantsFinSejour(date));
    }

    @GetMapping("/{numeroEtudiant}")
    public ResponseEntity<Long> getEtudiantIdByNumero(@PathVariable String numeroEtudiant) {
        Optional<Etudiant> etudiant = etudiantService.getEtudiantByNumero(numeroEtudiant);
        // Retourne uniquement l'ID de l'étudiant
        return etudiant.map(value -> ResponseEntity.ok(value.getId())).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PutMapping("/{numeroEtudiant}")
    public ResponseEntity<Etudiant> updateStatutPaiement(
            @PathVariable String numeroEtudiant,
            @RequestBody StatutPaiement statutPaiement) {
        Etudiant etudiant = etudiantService.updateStatutPaiement(numeroEtudiant, statutPaiement);
        if (etudiant != null) {
            return ResponseEntity.ok(etudiant); // Retourner l'étudiant mis à jour
        }
        return ResponseEntity.notFound().build(); // Retourner 404 si l'étudiant n'est pas trouvé
    }
}
