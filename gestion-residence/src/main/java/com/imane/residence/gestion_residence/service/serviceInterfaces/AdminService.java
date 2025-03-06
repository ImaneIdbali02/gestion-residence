package com.imane.residence.gestion_residence.service.serviceInterfaces;

import com.imane.residence.gestion_residence.models.dto.AdminDTO;
import com.imane.residence.gestion_residence.models.dto.EtudiantDTO;
import com.imane.residence.gestion_residence.models.dto.UserDTO;
import com.imane.residence.gestion_residence.models.enums.Typechamber;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

public interface AdminService {
    public AdminDTO createAdmin(AdminDTO adminDTO);
    public AdminDTO getAdminById(Long id);
    public AdminDTO updateAdmin(Long id, AdminDTO adminDTO);
    public void deleteAdmin(Long id);
    public List<AdminDTO> getAllAdmins();
    public void libererChambre(Long etudiantId);
    public void deleteEtudiant(Long id);
    public EtudiantDTO createEtudiantEtAssignerChambre(EtudiantDTO etudiantDTO, Long chambreId, Typechamber typechamber);
}