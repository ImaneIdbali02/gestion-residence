package com.imane.residence.gestion_residence.controllers;

import com.imane.residence.gestion_residence.models.dto.MaintenanceDTO;
import com.imane.residence.gestion_residence.models.enums.StatutMaintenance;
import com.imane.residence.gestion_residence.service.serviceInterfaces.MaintenanceService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/maintenance")
@RequiredArgsConstructor
public class MaintenanceController {
    private final MaintenanceService maintenanceService;

    @PostMapping
    public ResponseEntity<MaintenanceDTO> createMaintenance(@RequestBody MaintenanceDTO maintenanceDTO) {
        return ResponseEntity.ok(maintenanceService.createMaintenance(maintenanceDTO));
    }

    @GetMapping("/{id}")
    public ResponseEntity<MaintenanceDTO> getMaintenance(@PathVariable Long id) {
        return ResponseEntity.ok(maintenanceService.getMaintenanceById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<MaintenanceDTO> updateMaintenance(@PathVariable Long id, @RequestBody MaintenanceDTO maintenanceDTO) {
        return ResponseEntity.ok(maintenanceService.updateMaintenance(id, maintenanceDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMaintenance(@PathVariable Long id) {
        maintenanceService.deleteMaintenance(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping
    public ResponseEntity<List<MaintenanceDTO>> getAllMaintenances() {
        return ResponseEntity.ok(maintenanceService.getAllMaintenances());
    }

    @GetMapping("/statut/{statut}")
    public ResponseEntity<List<MaintenanceDTO>> getMaintenancesByStatut(@PathVariable StatutMaintenance statut) {
        return ResponseEntity.ok(maintenanceService.getMaintenancesByStatut(statut));
    }

    @PostMapping("/{maintenanceId}/personnel/{personnelId}")
    public ResponseEntity<Void> assignerTache(@PathVariable Long maintenanceId, @PathVariable Long personnelId) {
        maintenanceService.assignerTache(maintenanceId, personnelId);
        return ResponseEntity.ok().build();
    }

    @PatchMapping("/{id}/statut")
    public ResponseEntity<Void> changerStatut(@PathVariable Long id, @RequestParam StatutMaintenance statut) {
        maintenanceService.changerStatut(id, statut);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/urgentes")
    public ResponseEntity<List<MaintenanceDTO>> getTachesUrgentes() {
        return ResponseEntity.ok(maintenanceService.getTachesUrgentes());
    }

    @GetMapping("/personnel/{personnelId}")
    public ResponseEntity<List<MaintenanceDTO>> getTachesParPersonnel(@PathVariable Long personnelId) {
        return ResponseEntity.ok(maintenanceService.getTachesParPersonnel(personnelId));
    }
}

