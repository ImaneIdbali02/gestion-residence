package com.imane.residence.gestion_residence.service.serviceImp;

import com.imane.residence.gestion_residence.models.dto.*;
import com.imane.residence.gestion_residence.models.entities.Chamber;
import com.imane.residence.gestion_residence.models.entities.Etudiant;
import com.imane.residence.gestion_residence.models.enums.TypeRecherche;
import com.imane.residence.gestion_residence.repositories.ChamberRepo;
import com.imane.residence.gestion_residence.repositories.EtudiantRepo;
import com.imane.residence.gestion_residence.repositories.MaintenanceRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.RechercheService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;
import java.util.Map;
import java.util.HashMap;

@Service
@RequiredArgsConstructor
public class RechercheServiceImp implements RechercheService {
    private final ChamberRepo chambreRepository;
    private final EtudiantRepo etudiantRepository;
    private final MaintenanceRepo maintenanceRepository;
    private final ModelMapper mapper;

    private ResultatRechercheDTO convertToChambreResultat(Chamber chambre) {
        ResultatRechercheDTO resultat = new ResultatRechercheDTO();
        resultat.setId(chambre.getId());
        resultat.setTitre("Chambre " + chambre.getNumeroChambre());
        resultat.setDescription("Type: " + chambre.getType() + ", Statut: " + chambre.getStatut());
        resultat.setType(TypeRecherche.CHAMBRE);

        // Attributs spécifiques aux chambres
        Map<String, Object> attributs = new HashMap<>();
        attributs.put("numero", chambre.getNumeroChambre());
        attributs.put("type", chambre.getType());
        attributs.put("statut", chambre.getStatut());
        resultat.setAttributsSpecifiques(attributs);

        return resultat;
    }

    private ResultatRechercheDTO convertToEtudiantResultat(Etudiant etudiant) {
        ResultatRechercheDTO resultat = new ResultatRechercheDTO();
        resultat.setId(etudiant.getId());
        resultat.setTitre(etudiant.getUtilisateur().getName() + " " + etudiant.getUtilisateur().getPrenom());
        resultat.setDescription("Statut: " + etudiant.getStatut());
        resultat.setType(TypeRecherche.ETUDIANT);

        // Attributs spécifiques aux étudiants
        Map<String, Object> attributs = new HashMap<>();
        attributs.put("nom", etudiant.getUtilisateur().getName());
        attributs.put("prenom", etudiant.getUtilisateur().getPrenom());
        attributs.put("email", etudiant.getUtilisateur().getEmail());
        attributs.put("dateDebutSejour", etudiant.getDateDebutSejour());
        attributs.put("dateFinSejour", etudiant.getDateFinSejour());
        attributs.put("statut", etudiant.getStatut());
        resultat.setAttributsSpecifiques(attributs);

        return resultat;
    }
    @Override
    public List<ResultatRechercheDTO> rechercher(String terme, TypeRecherche type) {
        switch (type) {
            case CHAMBRE:
                return chambreRepository.rechercher(terme).stream()
                        .map(this::convertToChambreResultat)
                        .collect(Collectors.toList());
            case ETUDIANT:
                return etudiantRepository.rechercher(terme).stream()
                        .map(this::convertToEtudiantResultat)
                        .collect(Collectors.toList());
            default:
                throw new IllegalArgumentException("Type de recherche non supporté");
        }
    }

    @Override
    public List<ChamberDTO> rechercheAvanceeChambre(CritereRechercheChambre criteres) {
        return chambreRepository.rechercheAvancee(
                        criteres.getType(),
                        criteres.getStatut(),
                        criteres.getLoyerMin(),
                        criteres.getLoyerMax()
                ).stream()
                .map(chambre -> mapper.map(chambre, ChamberDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<EtudiantDTO> rechercheAvanceeEtudiant(CritereRechercheEtudiant criteres) {
        return etudiantRepository.rechercheAvancee(
                        criteres.getStatut(),
                        criteres.getDateDebutSejour(),
                        criteres.getDateFinSejour()
                ).stream()
                .map(etudiant -> mapper.map(etudiant, EtudiantDTO.class))
                .collect(Collectors.toList());
    }
}


