package com.imane.residence.gestion_residence.service.serviceImp;

import com.imane.residence.gestion_residence.exceptions.ResourceNotFoundException;
import com.imane.residence.gestion_residence.models.dto.EtudiantDTO;
import com.imane.residence.gestion_residence.models.entities.Etudiant;
import com.imane.residence.gestion_residence.models.enums.StatutEtudiant;
import com.imane.residence.gestion_residence.models.enums.StatutPaiement;
import com.imane.residence.gestion_residence.repositories.ChamberRepo;
import com.imane.residence.gestion_residence.repositories.EtudiantRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.EtudiantService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class EtudiantserviceImp implements EtudiantService {

    private final EtudiantRepo etudiantRepository;
    private final ChamberRepo chambreRepository;
    private final ModelMapper mapper;



    @Override
    public EtudiantDTO getEtudiantById(Long id) {
        Etudiant etudiant = etudiantRepository.findByUtilisateur_Id(id)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Étudiant non trouvé pour l'utilisateur avec l'ID: " + id));
        return mapper.map(etudiant, EtudiantDTO.class);
    }

    @Override
    public Optional<Etudiant> getEtudiantByNumero(String numeroEtudiant) {
        return etudiantRepository.findByNumeroEtudiant(numeroEtudiant);
    }

    @Override
    public EtudiantDTO updateEtudiant(Long id, EtudiantDTO etudiantDTO) {
        Etudiant etudiant = etudiantRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Étudiant non trouvé"));

        mapper.map(etudiantDTO, etudiant);
        etudiant = etudiantRepository.save(etudiant);
        return mapper.map(etudiant, EtudiantDTO.class);
    }



    @Override
    public List<EtudiantDTO> getAllEtudiants() {
        return etudiantRepository.findAll().stream()
                .map(etudiant -> mapper.map(etudiant, EtudiantDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<EtudiantDTO> getEtudiantsByStatut(StatutEtudiant statut) {
        return etudiantRepository.findByStatut(statut).stream()
                .map(etudiant -> mapper.map(etudiant, EtudiantDTO.class))
                .collect(Collectors.toList());
    }


    @Override
    public Etudiant updateStatutPaiement(String numeroEtudiant, StatutPaiement statutPaiement) {
        Etudiant etudiant = etudiantRepository.findByNumeroEtudiant(numeroEtudiant).orElse(null);
        if (etudiant != null) {
            etudiant.setStatutPaiement(statutPaiement);
            return etudiantRepository.save(etudiant); // Sauvegarder les modifications dans la base
        }
        return null;
    }

    @Override
    public boolean verifierPaiementsMensualites(Long etudiantId) {
        // Implémenter la logique de vérification des paiements
        return true;
    }

    @Override
    public List<EtudiantDTO> getEtudiantsFinSejour(LocalDateTime date) {
        return etudiantRepository.findByDateFinSejourBefore(date).stream()//à revoir (concernant la date)
                .map(etudiant -> mapper.map(etudiant, EtudiantDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<EtudiantDTO> getEtudiantsSansChambre() {
        return etudiantRepository.findSansChambre().stream()
                .map(etudiant -> mapper.map(etudiant, EtudiantDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<EtudiantDTO> rechercheAvanceeEtudiants(StatutEtudiant statut, LocalDate dateDebut, LocalDate dateFin) {
        return etudiantRepository.rechercheAvancee(statut, dateDebut, dateFin).stream()
                .map(etudiant -> mapper.map(etudiant, EtudiantDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<EtudiantDTO> rechercherEtudiants(String terme) {
        return etudiantRepository.rechercher(terme).stream()
                .map(etudiant -> mapper.map(etudiant, EtudiantDTO.class))
                .collect(Collectors.toList());
    }







}