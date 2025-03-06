package com.imane.residence.gestion_residence.controllers;

import com.imane.residence.gestion_residence.models.dto.PaiementDTO;
import com.imane.residence.gestion_residence.models.entities.Paiement;
import com.imane.residence.gestion_residence.service.serviceInterfaces.PaiementService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.YearMonth;
import java.util.List;

@RestController
@RequestMapping("/api/paiements")
@RequiredArgsConstructor
public class PaiementController {
    private final PaiementService paiementService;

    @PostMapping
    public ResponseEntity<PaiementDTO> createPaiement(@Valid @RequestBody PaiementDTO paiementDTO) {
        PaiementDTO createdPaiement = paiementService.createPaiement(paiementDTO);
        return new ResponseEntity<>(createdPaiement, HttpStatus.CREATED);
    }

    @ExceptionHandler(EntityNotFoundException.class)
    public ResponseEntity<String> handleEntityNotFound(EntityNotFoundException ex) {
        return new ResponseEntity<>(ex.getMessage(), HttpStatus.NOT_FOUND);
    }

    @GetMapping("/{id}")
    public ResponseEntity<PaiementDTO> getPaiement(@PathVariable Long id) {
        return ResponseEntity.ok(paiementService.getPaiementById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<PaiementDTO> updatePaiement(@PathVariable Long id, @RequestBody PaiementDTO paiementDTO) {
        return ResponseEntity.ok(paiementService.updatePaiement(id, paiementDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePaiement(@PathVariable Long id) {
        paiementService.deletePaiement(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping
    public ResponseEntity<List<PaiementDTO>> getAllPaiements() {
        return ResponseEntity.ok(paiementService.getAllPaiements());

    }

    @GetMapping("/etudiant/{etudiantId}")
    public ResponseEntity<List<PaiementDTO>> getPaiementsByEtudiant(@PathVariable Long etudiantId) {
        return ResponseEntity.ok(paiementService.getPaiementsByEtudiant(etudiantId));
    }

    @GetMapping("/etudiant/{etudiantId}/mois-payes")
    public ResponseEntity<List<YearMonth>> getMoisPayesParEtudiant(@PathVariable Long etudiantId) {
        return ResponseEntity.ok(paiementService.getMoisPayesParEtudiant(etudiantId));
    }

    @GetMapping("/etudiant/{etudiantId}/montant-du")
    public ResponseEntity<Double> calculerMontantDu(@PathVariable Long etudiantId) {
        return ResponseEntity.ok(paiementService.calculerMontantDu(etudiantId));
    }

    @GetMapping("/etudiant/{etudiantId}/verification")
    public ResponseEntity<Boolean> verifierPaiementMois(
            @PathVariable Long etudiantId,
            @RequestParam YearMonth mois) {
        return ResponseEntity.ok(paiementService.verifierPaiementMois(etudiantId, mois));
    }

    @PostMapping("/{id}/facture")
    public ResponseEntity<Void> genererFacture(@PathVariable Long id) {
        paiementService.genererFacture(id);
        return ResponseEntity.ok().build();
    }
}
