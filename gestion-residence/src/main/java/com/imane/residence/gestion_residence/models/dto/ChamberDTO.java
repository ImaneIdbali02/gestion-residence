package com.imane.residence.gestion_residence.models.dto;



import com.imane.residence.gestion_residence.models.enums.StatusChamber;
import com.imane.residence.gestion_residence.models.enums.Typechamber;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;

import java.util.List;
@Data
public class ChamberDTO {
    private Long id;

    @NotBlank(message="Le numero de chambre est obligatoire")
    private String numeroChambre;

    @NotNull(message = "L'étage est obligatoire")
    private Integer etage;

    @NotNull(message = "La superficie est obligatoire")
    private Double superficie;

    @NotNull(message = "Le type de chambre est obligatoire")
    private Typechamber type;

    @NotNull(message = "Le statut est obligatoire")
    private StatusChamber statut;

    @Positive(message = "Le loyer doit être positif")
    private Double loyerMensuel;

    private String description;
    private List<String> equipements;
}
