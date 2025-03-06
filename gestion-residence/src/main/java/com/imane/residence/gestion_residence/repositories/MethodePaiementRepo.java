package com.imane.residence.gestion_residence.repositories;

import com.imane.residence.gestion_residence.models.entities.MethodePaiement;
import com.imane.residence.gestion_residence.models.enums.TypeMethodePaiement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MethodePaiementRepo extends JpaRepository<MethodePaiement, Long> {
    List<MethodePaiement> findByActifTrue();
    List<MethodePaiement> findByType(TypeMethodePaiement type);
    Optional<MethodePaiement> findByNomAndType(String nom, TypeMethodePaiement type);
}
