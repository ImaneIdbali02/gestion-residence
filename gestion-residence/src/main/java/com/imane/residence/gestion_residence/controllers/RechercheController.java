package com.imane.residence.gestion_residence.controllers;

import com.imane.residence.gestion_residence.models.dto.*;
import com.imane.residence.gestion_residence.models.enums.TypeRecherche;
import com.imane.residence.gestion_residence.service.serviceInterfaces.RechercheService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/recherche")
@RequiredArgsConstructor
public class RechercheController {
    private final RechercheService rechercheService;

    @GetMapping
    public ResponseEntity<List<ResultatRechercheDTO>> rechercher(
            @RequestParam String terme,
            @RequestParam TypeRecherche type) {
        return ResponseEntity.ok(rechercheService.rechercher(terme, type));
    }

    @PostMapping("/chambres")
    public ResponseEntity<List<ChamberDTO>> rechercheAvanceeChambre(
            @RequestBody CritereRechercheChambre criteres) {
        return ResponseEntity.ok(rechercheService.rechercheAvanceeChambre(criteres));
    }

    @PostMapping("/etudiants")
    public ResponseEntity<List<EtudiantDTO>> rechercheAvanceeEtudiant(
            @RequestBody CritereRechercheEtudiant criteres) {
        return ResponseEntity.ok(rechercheService.rechercheAvanceeEtudiant(criteres));
    }
}