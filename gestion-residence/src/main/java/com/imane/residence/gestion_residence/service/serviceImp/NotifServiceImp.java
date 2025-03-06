package com.imane.residence.gestion_residence.service.serviceImp;

import com.imane.residence.gestion_residence.models.entities.Chamber;
import com.imane.residence.gestion_residence.models.entities.Etudiant;
import com.imane.residence.gestion_residence.models.entities.Maintenance;
import com.imane.residence.gestion_residence.models.entities.Utilisateur;
import com.imane.residence.gestion_residence.repositories.ChamberRepo;
import com.imane.residence.gestion_residence.repositories.EtudiantRepo;
import com.imane.residence.gestion_residence.repositories.MaintenanceRepo;
import com.imane.residence.gestion_residence.repositories.UtilisateurRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import java.time.*;
import java.util.*;

@Service
@RequiredArgsConstructor
public class NotifServiceImp implements NotificationService {
    private final JavaMailSender emailSender;
    private final EtudiantRepo etudiantRepository;
    private final UtilisateurRepo UtilisateurRepository;
    private final MaintenanceRepo maintenanceRepository;
    private final ChamberRepo chambreRepository;

    @Override
    public void envoyerRappelPaiement(Long etudiantId) {
        Etudiant etudiant = etudiantRepository.findById(etudiantId)
                .orElseThrow(() -> new RuntimeException("Étudiant non trouvé"));

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(etudiant.getUtilisateur().getEmail());
        message.setSubject("Rappel de paiement - Résidence étudiante");
        message.setText("Cher(e) " + etudiant.getUtilisateur().getName() + ",\n\n" +
                "Nous vous rappelons que votre paiement est en attente.\n" +
                "Montant dû : " + etudiant.getChambres().getLoyerMensuel() + "€\n\n" +
                "Cordialement");

        emailSender.send(message);
    }

    @Override
    public void notifierMaintenanceUpdated(Long maintenanceId) {
        Maintenance maintenance = maintenanceRepository.findById(maintenanceId)
                .orElseThrow(() -> new RuntimeException("Maintenance non trouvée"));

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(maintenance.getEtudiant().getUtilisateur().getEmail());
        message.setSubject("Mise à jour de votre demande de maintenance");
        message.setText("Le statut de votre demande a été mis à jour : " +
                maintenance.getStatut().toString());

        emailSender.send(message);
    }

    @Override
    public void notifierAttributionChambre(Long etudiantId, Long chambreId) {
        Etudiant etudiant = etudiantRepository.findById(etudiantId)
                .orElseThrow(() -> new RuntimeException("Étudiant non trouvé"));
        Chamber chambre = chambreRepository.findById(chambreId)
                .orElseThrow(() -> new RuntimeException("Chambre non trouvée"));

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(etudiant.getUtilisateur().getEmail());
        message.setSubject("Attribution de chambre - Résidence étudiante");
        message.setText("Votre chambre n°" + chambre.getNumeroChambre() + " vous a été attribuée.");

        emailSender.send(message);
    }
}



