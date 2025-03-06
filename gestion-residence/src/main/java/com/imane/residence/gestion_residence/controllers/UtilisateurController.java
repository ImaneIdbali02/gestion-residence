package com.imane.residence.gestion_residence.controllers;

import com.imane.residence.gestion_residence.exceptions.InvalidDataException;
import com.imane.residence.gestion_residence.exceptions.UserNotFoundException;
import com.imane.residence.gestion_residence.models.dto.PasswordResetDTO;
import com.imane.residence.gestion_residence.models.dto.UserDTO;
import com.imane.residence.gestion_residence.models.dto.loginDTO;
import com.imane.residence.gestion_residence.models.dto.registerDTO;
import com.imane.residence.gestion_residence.models.enums.Role;
import com.imane.residence.gestion_residence.repositories.UtilisateurRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.UtilisateurService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/api/utilisateurs")
@RequiredArgsConstructor

public class UtilisateurController {

    private final UtilisateurService utilisateurService;
    private final ModelMapper mapper;
    private static final Logger log = LoggerFactory.getLogger(UtilisateurController.class);

    @PostMapping("/register")
    public ResponseEntity<UserDTO> register(@RequestBody registerDTO registerDTO) {
        return ResponseEntity.ok(utilisateurService.register(registerDTO));
    }



        @GetMapping("/votre-chambre")
    public String votreChambre(HttpServletRequest request) {
        UserDTO user = (UserDTO) request.getSession().getAttribute("user");
        if (user == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Please login first");
        }
        return "votre-chambre";
    }


    @GetMapping("/{id}")
    public ResponseEntity<UserDTO> getUserById(@PathVariable Long id) {
        return ResponseEntity.ok(utilisateurService.getUserById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<UserDTO> updateUser(@PathVariable Long id, @RequestBody UserDTO userDTO) {
        return ResponseEntity.ok(utilisateurService.updateUser(id, userDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        utilisateurService.deleteUser(id);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}/activate")
    public ResponseEntity<Void> activateUser(@PathVariable Long id) {
        utilisateurService.activateUser(id);
        return ResponseEntity.ok().build();
    }

    @PatchMapping("/{id}/deactivate")
    public ResponseEntity<Void> deactivateUser(@PathVariable Long id) {
        utilisateurService.deactivateUser(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping
    public ResponseEntity<List<UserDTO>> getAllUsers() {
        return ResponseEntity.ok(utilisateurService.getAllUsers());
    }

    @GetMapping("/role/{role}")
    public ResponseEntity<List<UserDTO>> getUsersByRole(@PathVariable Role role) {
        return ResponseEntity.ok(utilisateurService.getUsersByRole(role));
    }

    @PostMapping("/reset-password")
    public ResponseEntity<Boolean> resetPassword(@RequestBody PasswordResetDTO resetDTO) {
        try {
            utilisateurService.resetPassword(resetDTO);
            return ResponseEntity.ok(true);
        } catch (UserNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        } catch (InvalidDataException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(false);
        }
    }

    @PostMapping("/{id}/change-password")
    public ResponseEntity<Boolean> changePassword(
            @PathVariable Long id,
            @RequestParam String oldPassword,
            @RequestParam String newPassword) {
        return ResponseEntity.ok(utilisateurService.changePassword(id, oldPassword, newPassword));
    }
}

