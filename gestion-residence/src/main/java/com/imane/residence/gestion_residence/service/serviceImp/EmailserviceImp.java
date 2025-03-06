package com.imane.residence.gestion_residence.service.serviceImp;

import com.imane.residence.gestion_residence.service.serviceInterfaces.EmailService;
import org.springframework.beans.factory.annotation.Value;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class EmailserviceImp implements EmailService {
    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;

    public void sendOTP(String to, String otp, String nom) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(to);
            message.setSubject("Code de réinitialisation de mot de passe");
            message.setText(String.format(
                    "Bonjour %s,\n\n" +
                            "Voici votre code de réinitialisation : %s\n" +
                            "Ce code est valable pendant 15 minutes.\n\n" +
                            "Si vous n'avez pas demandé cette réinitialisation, ignorez cet email.",
                    nom, otp
            ));

            mailSender.send(message);
            log.info("Email OTP envoyé à : {}", to);
        } catch (Exception e) {
            log.error("Erreur lors de l'envoi de l'email: {}", e.getMessage());
            throw new RuntimeException("Erreur lors de l'envoi de l'email", e);
        }
    }
}

