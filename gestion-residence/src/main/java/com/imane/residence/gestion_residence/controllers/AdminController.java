package com.imane.residence.gestion_residence.controllers;

import com.imane.residence.gestion_residence.exceptions.ResourceNotFoundException;
import com.imane.residence.gestion_residence.models.dto.AdminDTO;
import com.imane.residence.gestion_residence.models.dto.CreerEtudiantRequest;
import com.imane.residence.gestion_residence.models.dto.EtudiantDTO;
import com.imane.residence.gestion_residence.models.entities.Admin;
import com.imane.residence.gestion_residence.service.serviceInterfaces.AdminService;
import com.imane.residence.gestion_residence.service.serviceInterfaces.EtudiantService;
import com.imane.residence.gestion_residence.repositories.AdminRepo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;


@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;
    private final EtudiantService etudiantService;
    private static final Logger log = LoggerFactory.getLogger(AdminController.class);


    @PostMapping("/create")
    public ResponseEntity<AdminDTO> createAdmin(@RequestBody AdminDTO adminDTO) {
        AdminDTO createdAdmin = adminService.createAdmin(adminDTO);
        return ResponseEntity.ok(createdAdmin);
    }

    @GetMapping("/{id}")
    public ResponseEntity<AdminDTO> getAdminById(@PathVariable Long id) {
        AdminDTO adminDTO = adminService.getAdminById(id);
        return ResponseEntity.ok(adminDTO);
    }

    @PutMapping("/{id}")
    public ResponseEntity<AdminDTO> updateAdmin(@PathVariable Long id, @RequestBody AdminDTO adminDTO) {
        AdminDTO updatedAdmin = adminService.updateAdmin(id, adminDTO);
        return ResponseEntity.ok(updatedAdmin);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAdmin(@PathVariable Long id) {
        adminService.deleteAdmin(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/all")
    public ResponseEntity<List<AdminDTO>> getAllAdmins() {
        List<AdminDTO> admins = adminService.getAllAdmins();
        return ResponseEntity.ok(admins);
    }

    @PostMapping("/creer-et-assigner")
    public ResponseEntity<EtudiantDTO> creerEtudiantEtAssignerChambre(@RequestBody CreerEtudiantRequest request) {
        // Appel au service pour créer l'étudiant et assigner la chambre.
        EtudiantDTO createdEtudiant = adminService.createEtudiantEtAssignerChambre(
                request.getEtudiantDTO(),
                request.getChambres(),
                request.getTypeChambre()
        );
        return ResponseEntity.ok(createdEtudiant);
    }

    @PostMapping("/liberer-chambre")
    public ResponseEntity<String> libererChambre(@RequestParam Long etudiantId) {
        log.info("Tentative de libération de chambre pour l'étudiant ID: {}", etudiantId);
        try {
            adminService.libererChambre(etudiantId);
            return ResponseEntity.noContent().build();
        } catch (ResourceNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        }
    }

    @DeleteMapping("/etudiants/{id}")
    public ResponseEntity<Void> deleteEtudiant(@PathVariable Long id) {
        adminService.deleteEtudiant(id);
        return ResponseEntity.noContent().build();
    }
}

