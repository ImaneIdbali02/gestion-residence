package com.imane.residence.gestion_residence.controllers;

import com.imane.residence.gestion_residence.models.dto.ChamberDTO;
import com.imane.residence.gestion_residence.models.enums.StatusChamber;
import com.imane.residence.gestion_residence.models.enums.Typechamber;
import com.imane.residence.gestion_residence.service.serviceInterfaces.Chamberservice;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/chambres")
@RequiredArgsConstructor
public class ChamberController {
    private final Chamberservice chambreService;
    private static final Logger log = LoggerFactory.getLogger(ChamberController.class);

    @PostMapping
    public ResponseEntity<ChamberDTO> createChambre(@Valid @RequestBody ChamberDTO chambreDTO) {
        log.info("Received request to create chamber: {}", chambreDTO);
        return ResponseEntity.ok(chambreService.createChambre(chambreDTO));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ChamberDTO> getChambre(@PathVariable Long id) {
        return ResponseEntity.ok(chambreService.getChambreById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Object> updateChambre(@PathVariable Long id, @RequestBody ChamberDTO chambreDTO) {
        try {
            ChamberDTO updatedChamber = chambreService.updateChambre(id, chambreDTO);
            return ResponseEntity.ok(updatedChamber);
        } catch (Exception e) {
            log.error("Erreur lors de la mise à jour de la chambre ID: {}", id, e);
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
        }
    }




    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteChambre(@PathVariable Long id) {
        chambreService.deleteChambre(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping
    public ResponseEntity<List<ChamberDTO>> getAllChambres() {
        return ResponseEntity.ok(chambreService.getAllChambres());
    }

    @GetMapping("/statut/{statut}")
    public ResponseEntity<List<ChamberDTO>> getChambresByStatut(@PathVariable StatusChamber statut) {
        return ResponseEntity.ok(chambreService.getChambresByStatut(statut));
    }

    @GetMapping("/type/{type}")
    public ResponseEntity<List<ChamberDTO>> getChambresByType(@PathVariable Typechamber type) {
        return ResponseEntity.ok(chambreService.getChambresByType(type));
    }

    @PatchMapping("/{id}/statut")
    public ResponseEntity<Void> changerStatutChambre(@PathVariable Long id, @RequestParam StatusChamber statut) {
        chambreService.changerStatutChambre(id, statut);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/loyer")
    public ResponseEntity<List<ChamberDTO>> getChambresByLoyerMaximum(@RequestParam double maxLoyer) {
        return ResponseEntity.ok(chambreService.getChambresByLoyerMaximum(maxLoyer));
    }

    @GetMapping("/{id}/disponibilite")
    public ResponseEntity<Boolean> verifierDisponibilite(@PathVariable Long id) {
        return ResponseEntity.ok(chambreService.verifierDisponibilite(id));
    }


}
