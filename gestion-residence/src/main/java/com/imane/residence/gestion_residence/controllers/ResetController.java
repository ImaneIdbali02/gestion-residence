package com.imane.residence.gestion_residence.controllers;


import com.imane.residence.gestion_residence.models.dto.ApiResponse;
import com.imane.residence.gestion_residence.service.serviceInterfaces.UtilisateurService;
import jakarta.validation.constraints.Email;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.imane.residence.gestion_residence.models.dto.PasswordResetDTO;


@RestController
@RequestMapping("/api/auth")
@Slf4j
@RequiredArgsConstructor
public class ResetController {

    private UtilisateurService utilisateurService;


    @PostMapping("/forgot-password")
    public ResponseEntity<?> forgotPassword(@RequestParam @Email String email) {
        try {
            utilisateurService.initiatePasswordReset(email);
            return ResponseEntity.ok(new ApiResponse(true,
                    "Un code de réinitialisation a été envoyé à votre email"));
        } catch (Exception e) {
            log.error("Erreur lors de la demande de réinitialisation: {}", e.getMessage());
            return ResponseEntity.badRequest()
                    .body(new ApiResponse(false, "Erreur lors de l'envoi du code"));
        }
    }

    @PostMapping("/verify-otp")
    public ResponseEntity<?> verifyOTP(@RequestParam String email,
                                       @RequestParam String otp) {
        try {
            boolean isValid = utilisateurService.verifyOTP(email, otp);
            return ResponseEntity.ok(new ApiResponse(isValid, "Code OTP valide"));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse(false, e.getMessage()));
        }
    }

    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody PasswordResetDTO resetDTO) {
        try {
            utilisateurService.resetPassword(resetDTO);
            return ResponseEntity.ok(new ApiResponse(true,
                    "Mot de passe réinitialisé avec succès"));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse(false, e.getMessage()));
        }
    }
}
