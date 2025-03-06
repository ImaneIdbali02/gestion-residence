package com.imane.residence.gestion_residence.service.serviceInterfaces;

import org.springframework.stereotype.Service;


public interface NotificationService {
    public void envoyerRappelPaiement(Long etudiantId);
    public void notifierMaintenanceUpdated(Long maintenanceId);
    public void notifierAttributionChambre(Long etudiantId, Long chambreId);
}