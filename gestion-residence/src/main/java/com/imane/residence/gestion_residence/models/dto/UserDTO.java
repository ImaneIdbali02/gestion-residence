package com.imane.residence.gestion_residence.models.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.imane.residence.gestion_residence.models.enums.Role;
import jakarta.validation.constraints.NotBlank;
import lombok.Builder;
import lombok.Data;

@Data

public class UserDTO {
    private Long id;
    private String name;
    private String prenom;
    private String email;
    private String telephone;
    private Role role;
    private String password;

}
