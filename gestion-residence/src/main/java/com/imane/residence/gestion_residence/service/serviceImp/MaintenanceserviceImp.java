package com.imane.residence.gestion_residence.service.serviceImp;

import com.imane.residence.gestion_residence.models.dto.MaintenanceDTO;
import com.imane.residence.gestion_residence.models.entities.Maintenance;
import com.imane.residence.gestion_residence.models.entities.PersonnelMaintenance;
import com.imane.residence.gestion_residence.models.entities.StatistiqueMaintenance;
import com.imane.residence.gestion_residence.models.enums.MaintenancePriorite;
import com.imane.residence.gestion_residence.models.enums.StatutMaintenance;
import com.imane.residence.gestion_residence.repositories.ChamberRepo;
import com.imane.residence.gestion_residence.repositories.MaintenancePersoRepo;
import com.imane.residence.gestion_residence.repositories.MaintenanceRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.MaintenanceService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import lombok.Builder;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Builder
@Service
@RequiredArgsConstructor
public class MaintenanceserviceImp implements MaintenanceService {
    private final MaintenanceRepo maintenanceRepository;
    private final MaintenancePersoRepo personnelRepository;
    private final ModelMapper mapper;
    private final ChamberRepo chambreRepository;

    @Override
    public MaintenanceDTO createMaintenance(MaintenanceDTO maintenanceDTO) {
        Maintenance maintenance = mapper.map(maintenanceDTO, Maintenance.class);
        maintenance = maintenanceRepository.save(maintenance);
        return mapper.map(maintenance, MaintenanceDTO.class);
    }

    @Override
    public MaintenanceDTO getMaintenanceById(Long id) {
        return maintenanceRepository.findById(id)
                .map(maintenance -> mapper.map(maintenance, MaintenanceDTO.class))
                .orElseThrow(() -> new RuntimeException("Maintenance non trouvée"));
    }

    @Override
    public MaintenanceDTO updateMaintenance(Long id, MaintenanceDTO maintenanceDTO) {
        Maintenance maintenance = maintenanceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Maintenance non trouvée"));

        mapper.map(maintenanceDTO, maintenance);
        maintenance = maintenanceRepository.save(maintenance);
        return mapper.map(maintenance, MaintenanceDTO.class);
    }

    @Override
    public void deleteMaintenance(Long id) {
        if (!maintenanceRepository.existsById(id)) {
            throw new RuntimeException("Maintenance non trouvée");
        }
        maintenanceRepository.deleteById(id);
    }

    @Override
    public List<MaintenanceDTO> getAllMaintenances() {
        return maintenanceRepository.findAll().stream()
                .map(maintenance -> mapper.map(maintenance, MaintenanceDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<MaintenanceDTO> getMaintenancesByStatut(StatutMaintenance statut) {
        return maintenanceRepository.findByStatut(statut).stream()
                .map(maintenance -> mapper.map(maintenance, MaintenanceDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public void assignerTache(Long maintenanceId, Long personnelId) {
        Maintenance maintenance = maintenanceRepository.findById(maintenanceId)
                .orElseThrow(() -> new RuntimeException("Tâche non trouvée"));

        PersonnelMaintenance personnel = personnelRepository.findById(personnelId)
                .orElseThrow(() -> new RuntimeException("Personnel non trouvé"));

        if (personnel.getTachesAssignees().size() >= 5) {
            throw new RuntimeException("Personnel déjà surchargé");
        }

        maintenance.setAssigneA(personnel);
        maintenance.setStatut(StatutMaintenance.EN_COURS);
        maintenanceRepository.save(maintenance);
    }


    @Override
    public void changerStatut(Long id, StatutMaintenance statut) {
        Maintenance maintenance = maintenanceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Tâche non trouvée"));

        maintenance.setStatut(statut);
        if (statut == StatutMaintenance.TERMINEE || statut == StatutMaintenance.ANNULEE) {
            maintenance.setDateResolution(LocalDateTime.now());
        }
        maintenanceRepository.save(maintenance);
    }

    @Override
    public List<MaintenanceDTO> getTachesUrgentes() {
        return maintenanceRepository.findTasksEnAttente().stream()
                .filter(m -> m.getPriorite() == MaintenancePriorite.URGENTE)
                .map(maintenance -> mapper.map(maintenance, MaintenanceDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<MaintenanceDTO> getTachesParPersonnel(Long personnelId) {
        return maintenanceRepository.findTachesEnCoursParPersonnel(personnelId).stream()
                .map(maintenance -> mapper.map(maintenance, MaintenanceDTO.class))
                .collect(Collectors.toList());
    }


    @Override
    public List<MaintenanceDTO> getMaintenanceParPeriode(LocalDate debut, LocalDate fin) {
        return maintenanceRepository.findByDateCreationBetween(debut, fin).stream()
                .map(maintenance -> mapper.map(maintenance, MaintenanceDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public StatistiqueMaintenance getMaintenanceStats() {
        return StatistiqueMaintenance.builder()
                .nombreEnAttente(maintenanceRepository.countByStatut(StatutMaintenance.EN_ATTENTE))
                .nombreEnCours(maintenanceRepository.countByStatut(StatutMaintenance.EN_COURS))
                .nombreUrgentes(maintenanceRepository.countByPriorite(MaintenancePriorite.URGENTE))
                .build();
    }

    @Override
    public List<MaintenanceDTO> getMaintenanceParChambre(Long chambreId) {
        return maintenanceRepository.findByChambre(chambreId).stream()
                .map(maintenance -> mapper.map(maintenance, MaintenanceDTO.class))
                .collect(Collectors.toList());
    }






}
