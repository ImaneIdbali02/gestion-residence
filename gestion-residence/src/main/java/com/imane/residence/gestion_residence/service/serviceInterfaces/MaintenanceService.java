package com.imane.residence.gestion_residence.service.serviceInterfaces;

import com.imane.residence.gestion_residence.models.dto.MaintenanceDTO;
import com.imane.residence.gestion_residence.models.entities.StatistiqueMaintenance;
import com.imane.residence.gestion_residence.models.enums.StatutMaintenance;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

public interface MaintenanceService {
    MaintenanceDTO createMaintenance(MaintenanceDTO maintenanceDTO);
    MaintenanceDTO getMaintenanceById(Long id);
    MaintenanceDTO updateMaintenance(Long id, MaintenanceDTO maintenanceDTO);
    void deleteMaintenance(Long id);
    List<MaintenanceDTO> getAllMaintenances();
    List<MaintenanceDTO> getMaintenancesByStatut(StatutMaintenance statut);
    void assignerTache(Long maintenanceId, Long personnelId);
    void changerStatut(Long id, StatutMaintenance statut);
    List<MaintenanceDTO> getTachesUrgentes();
    List<MaintenanceDTO> getTachesParPersonnel(Long personnelId);
    List<MaintenanceDTO> getMaintenanceParPeriode(LocalDate debut, LocalDate fin);
    List<MaintenanceDTO> getMaintenanceParChambre(Long chambreId);
    StatistiqueMaintenance getMaintenanceStats();
}
