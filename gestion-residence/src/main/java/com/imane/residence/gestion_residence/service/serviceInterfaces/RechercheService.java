package com.imane.residence.gestion_residence.service.serviceInterfaces;

import com.imane.residence.gestion_residence.models.dto.*;
import com.imane.residence.gestion_residence.models.enums.TypeRecherche;
import org.springframework.stereotype.Service;

import java.util.List;


public interface RechercheService {
    public List<ResultatRechercheDTO> rechercher(String terme, TypeRecherche type);
    public List<ChamberDTO> rechercheAvanceeChambre(CritereRechercheChambre criteres);
    public List<EtudiantDTO> rechercheAvanceeEtudiant(CritereRechercheEtudiant criteres);

}
