package com.imane.residence.gestion_residence.service.serviceImp;

import com.imane.residence.gestion_residence.models.dto.BilanFinancier;
import com.imane.residence.gestion_residence.models.dto.PaiementDTO;
import com.imane.residence.gestion_residence.models.entities.Etudiant;
import com.imane.residence.gestion_residence.models.entities.Paiement;
import com.imane.residence.gestion_residence.models.enums.StatutPaiement;
import com.imane.residence.gestion_residence.repositories.EtudiantRepo;
import com.imane.residence.gestion_residence.repositories.paiementRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.PaiementService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PaiementserviceImp implements PaiementService {
    private final paiementRepo paiementRepository;
    private final EtudiantRepo etudiantRepository;
    private final ModelMapper mapper;


    @Override
    public PaiementDTO createPaiement(PaiementDTO paiementDTO) {
        // Trouver l'étudiant par son numéro
        Etudiant etudiant = etudiantRepository.findByNumeroEtudiant(paiementDTO.getNumeroEtudiant())
                .orElseThrow(() -> new EntityNotFoundException("Étudiant non trouvé avec le numéro: " + paiementDTO.getNumeroEtudiant()));

        // Conversion DTO -> Entité
        Paiement paiement = mapper.map(paiementDTO, Paiement.class);
        paiement.setEtudiant(etudiant);
        paiement.setDatePaiement(LocalDateTime.now());
        etudiant.setStatutPaiement(StatutPaiement.PAYEE);

        // Sauvegarde
        Paiement savedPaiement = paiementRepository.save(paiement);

        // Conversion Entité -> DTO
        return mapper.map(savedPaiement, PaiementDTO.class);
    }


    @Override
    public PaiementDTO getPaiementById(Long id) {
        return paiementRepository.findById(id)
                .map(Paiement -> mapper.map(Paiement, PaiementDTO.class))
                .orElseThrow(() -> new RuntimeException("Paiement non trouvé"));
    }

    @Override
    public PaiementDTO updatePaiement(Long id, PaiementDTO paiementDTO) {
        Paiement paiement = paiementRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Paiement non trouvé"));

        mapper.map(paiementDTO, paiement);
        paiement = paiementRepository.save(paiement);
        return mapper.map(paiement, PaiementDTO.class);
    }

    @Override
    public void deletePaiement(Long id) {
        if (!paiementRepository.existsById(id)) {
            throw new RuntimeException("Paiement non trouvé");
        }
        paiementRepository.deleteById(id);
    }

    @Override
    public List<PaiementDTO> getAllPaiements() {
        List<Paiement> paiements = paiementRepository.findAllWithEtudiant();
        return paiements.stream()
                .map(paiement -> mapper.map(paiement, PaiementDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<PaiementDTO> getPaiementsByEtudiant(Long etudiantId) {
        return paiementRepository.findByEtudiantId(etudiantId).stream()
                .map(Paiement -> mapper.map(Paiement, PaiementDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<YearMonth> getMoisPayesParEtudiant(Long etudiantId) {
        return paiementRepository.findMoisPayesParEtudiant(etudiantId);
    }

    @Override
    public double calculerMontantDu(Long etudiantId) {
        Etudiant etudiant = etudiantRepository.findById(etudiantId)
                .orElseThrow(() -> new RuntimeException("Étudiant non trouvé"));

        if (etudiant.getChambres() == null) {
            return 0.0;
        }

        long moisSejour = ChronoUnit.MONTHS.between(
                etudiant.getDateDebutSejour().withDayOfMonth(1),
                LocalDate.now().withDayOfMonth(1)
        );

        List<YearMonth> moisPayes = paiementRepository.findMoisPayesParEtudiant(etudiantId);

        return etudiant.getChambres().getLoyerMensuel() * (moisSejour - moisPayes.size());
    }

    @Override
    public boolean verifierPaiementMois(Long etudiantId, YearMonth mois) {
        List<Paiement> paiements = paiementRepository.findByEtudiantAndMois(etudiantId, mois);
        return !paiements.isEmpty() && paiements.stream()
                .anyMatch(p -> p.getStatut() == StatutPaiement.PAYEE);
    }

    @Override
    public void genererFacture(Long paiementId) {
        Paiement paiement = paiementRepository.findById(paiementId)
                .orElseThrow(() -> new RuntimeException("Paiement non trouvé"));

        // Logique pour générer la facture
        // Par exemple: créer un PDF, envoyer par email, etc.
    }

    @Override
    public BilanFinancier getBilanFinancier(LocalDate date) {
        return BilanFinancier.builder()
                .totalDu(paiementRepository.calculerTotalDu(date))
                .totalPaye(paiementRepository.calculerTotalPaye(date))
                .build();
    }








}
