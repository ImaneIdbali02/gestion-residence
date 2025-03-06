package com.imane.residence.gestion_residence.controllers;

import com.imane.residence.gestion_residence.service.serviceInterfaces.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/notifications")
@RequiredArgsConstructor
public class NotificationController {
    private final NotificationService notificationService;

    @PostMapping("/rappel-paiement/{etudiantId}")
    public ResponseEntity<Void> envoyerRappelPaiement(@PathVariable Long etudiantId) {
        notificationService.envoyerRappelPaiement(etudiantId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/maintenance/{maintenanceId}")
    public ResponseEntity<Void> notifierMaintenanceUpdated(@PathVariable Long maintenanceId) {
        notificationService.notifierMaintenanceUpdated(maintenanceId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/attribution-chambre/{etudiantId}/{chambreId}")
    public ResponseEntity<Void> notifierAttributionChambre(
            @PathVariable Long etudiantId,
            @PathVariable Long chambreId) {
        notificationService.notifierAttributionChambre(etudiantId, chambreId);
        return ResponseEntity.ok().build();
    }
}
