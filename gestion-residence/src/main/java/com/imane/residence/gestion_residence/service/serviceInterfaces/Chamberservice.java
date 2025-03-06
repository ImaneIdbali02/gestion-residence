package com.imane.residence.gestion_residence.service.serviceInterfaces;

import com.imane.residence.gestion_residence.models.dto.ChamberDTO;
import com.imane.residence.gestion_residence.models.entities.Chamber;
import com.imane.residence.gestion_residence.models.enums.StatusChamber;
import com.imane.residence.gestion_residence.models.enums.Typechamber;
import org.springframework.stereotype.Service;

import java.util.List;

public interface Chamberservice {
    ChamberDTO createChambre(ChamberDTO chambreDTO);
    ChamberDTO getChambreById(Long id);
    ChamberDTO getChambreByNum(String num);
    ChamberDTO updateChambre(Long id, ChamberDTO chambreDTO);
    void deleteChambre(Long id);
    List<ChamberDTO> getAllChambres();
    List<ChamberDTO> getChambresByStatut(StatusChamber statut);
    List<ChamberDTO> getChambresByType(Typechamber type);
    void changerStatutChambre(Long id, StatusChamber statut);
    List<ChamberDTO> getChambresByLoyerMaximum(double maxLoyer);
    boolean verifierDisponibilite(Long chambreId);
    List<ChamberDTO> getAvailableRoomsByType (Typechamber Type);
    long getNombreChambreParStatut(StatusChamber statut);
    List<ChamberDTO> rechercheAvanceeChambres(Typechamber type, StatusChamber statut, Double loyerMin, Double loyerMax);
    List<ChamberDTO> rechercherChambres(String terme);


}
