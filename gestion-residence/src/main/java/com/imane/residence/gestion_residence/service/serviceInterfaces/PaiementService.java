package com.imane.residence.gestion_residence.service.serviceInterfaces;

import com.imane.residence.gestion_residence.models.dto.BilanFinancier;
import com.imane.residence.gestion_residence.models.dto.PaiementDTO;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

public interface PaiementService {
    PaiementDTO createPaiement(PaiementDTO paiementDTO);
    PaiementDTO getPaiementById(Long id);
    PaiementDTO updatePaiement(Long id, PaiementDTO paiementDTO);
    void deletePaiement(Long id);
    List<PaiementDTO> getAllPaiements();
    List<PaiementDTO> getPaiementsByEtudiant(Long etudiantId);
    List<YearMonth> getMoisPayesParEtudiant(Long etudiantId);
    double calculerMontantDu(Long etudiantId);
    boolean verifierPaiementMois(Long etudiantId, YearMonth mois);
    void genererFacture(Long paiementId);
    BilanFinancier getBilanFinancier(LocalDate date);
}