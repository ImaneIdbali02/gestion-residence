package com.imane.residence.gestion_residence.service.serviceInterfaces;

import com.imane.residence.gestion_residence.models.dto.*;
import com.imane.residence.gestion_residence.models.enums.Role;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

public interface UtilisateurService {

    UserDTO register(registerDTO registerDTO);
    //public String login(loginDTO loginDTO);

    public UserDTO getUserById(Long id);
    UserDTO updateUser(Long id, UserDTO userDTO);
    void deleteUser(Long id);
    void activateUser(Long id);
    void deactivateUser(Long id);
    List<UserDTO> getAllUsers();
    List<UserDTO> getUsersByRole(Role role);
    String generateOTP();
    void initiatePasswordReset(String email);
    boolean verifyOTP(String email, String otp);
    void resetPassword(PasswordResetDTO resetDTO);
    boolean changePassword(Long userId, String oldPassword, String newPassword);
    List<UserDTO> rechercherUtilisateurs(String terme);

}
