package com.imane.residence.gestion_residence.service.serviceInterfaces;

import com.imane.residence.gestion_residence.models.dto.MethodePaiementDTO;
import com.imane.residence.gestion_residence.models.enums.TypeMethodePaiement;
import org.springframework.stereotype.Service;

import java.util.List;

public interface MethodePaiementService {

        MethodePaiementDTO createMethodePaiement(MethodePaiementDTO dto);
        MethodePaiementDTO getMethodePaiementById(Long id);
        List<MethodePaiementDTO> getAllMethodesPaiement();
        List<MethodePaiementDTO> getMethodesPaiementActives();
        List<MethodePaiementDTO> getMethodesPaiementParType(TypeMethodePaiement type);
        MethodePaiementDTO updateMethodePaiement(Long id, MethodePaiementDTO dto);
        void deleteMethodePaiement(Long id);
        void activerMethodePaiement(Long id);
        void desactiverMethodePaiement(Long id);
        boolean validateMethodePaiement(TypeMethodePaiement type, String details);

}
