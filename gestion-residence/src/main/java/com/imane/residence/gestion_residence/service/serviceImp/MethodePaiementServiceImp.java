package com.imane.residence.gestion_residence.service.serviceImp;

import com.imane.residence.gestion_residence.models.dto.MethodePaiementDTO;
import com.imane.residence.gestion_residence.models.enums.TypeMethodePaiement;
import com.imane.residence.gestion_residence.models.entities.MethodePaiement;
import com.imane.residence.gestion_residence.repositories.MethodePaiementRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.MethodePaiementService;

import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MethodePaiementServiceImp implements MethodePaiementService{
    private final MethodePaiementRepo methodePaiementRepository;
    private final ModelMapper mapper;

    @Override
    public MethodePaiementDTO createMethodePaiement(MethodePaiementDTO dto) {
        // Vérifier si une méthode similaire existe déjà
        if (methodePaiementRepository.findByNomAndType(dto.getNom(), dto.getType()).isPresent()) {
            throw new RuntimeException("Cette méthode de paiement existe déjà");
        }

        MethodePaiement methodePaiement = mapper.map(dto, MethodePaiement.class);
        methodePaiement = methodePaiementRepository.save(methodePaiement);
        return mapper.map(methodePaiement, MethodePaiementDTO.class);
    }

    @Override
    public MethodePaiementDTO getMethodePaiementById(Long id) {
        return methodePaiementRepository.findById(id)
                .map(method -> mapper.map(method, MethodePaiementDTO.class))
                .orElseThrow(() -> new RuntimeException("Méthode de paiement non trouvée"));
    }

    @Override
    public List<MethodePaiementDTO> getAllMethodesPaiement() {
        return methodePaiementRepository.findAll().stream()
                .map(method -> mapper.map(method, MethodePaiementDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<MethodePaiementDTO> getMethodesPaiementActives() {
        return methodePaiementRepository.findByActifTrue().stream()
                .map(method -> mapper.map(method, MethodePaiementDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<MethodePaiementDTO> getMethodesPaiementParType(TypeMethodePaiement type) {
        return methodePaiementRepository.findByType(type).stream()
                .map(method -> mapper.map(method, MethodePaiementDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public MethodePaiementDTO updateMethodePaiement(Long id, MethodePaiementDTO dto) {
        MethodePaiement methodePaiement = methodePaiementRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Méthode de paiement non trouvée"));

        mapper.map(dto, methodePaiement);
        methodePaiement = methodePaiementRepository.save(methodePaiement);
        return mapper.map(methodePaiement, MethodePaiementDTO.class);
    }

    @Override
    public void deleteMethodePaiement(Long id) {
        if (!methodePaiementRepository.existsById(id)) {
            throw new RuntimeException("Méthode de paiement non trouvée");
        }
        methodePaiementRepository.deleteById(id);
    }

    @Override
    public void activerMethodePaiement(Long id) {
        MethodePaiement methodePaiement = methodePaiementRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Méthode de paiement non trouvée"));
        methodePaiement.setActif(true);
        methodePaiementRepository.save(methodePaiement);
    }

    @Override
    public void desactiverMethodePaiement(Long id) {
        MethodePaiement methodePaiement = methodePaiementRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Méthode de paiement non trouvée"));
        methodePaiement.setActif(false);
        methodePaiementRepository.save(methodePaiement);
    }

    @Override
    public boolean validateMethodePaiement(TypeMethodePaiement type, String details) {
        switch (type) {
            case CARTE_BANCAIRE:
                return validateCardDetails(details);
            case VIREMENT_BANCAIRE:
                return validateBankDetails(details);

            case ESPECES:
                return true; // Pas de validation spécifique pour les espèces
            default:
                return false;
        }
    }

    private boolean validateCardDetails(String cardDetails) {
        // Implémenter la validation des cartes bancaires
        // Vérification du format, algorithme de Luhn, etc.
        return true;
    }

    private boolean validateBankDetails(String bankDetails) {
        // Implémenter la validation des coordonnées bancaires
        // Vérification IBAN, BIC, etc.
        return true;
    }




}

