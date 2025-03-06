package com.imane.residence.gestion_residence.models.entities;

import com.imane.residence.gestion_residence.models.enums.StatusChamber;
import com.imane.residence.gestion_residence.models.enums.Typechamber;
import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Data
@Table(name="chambres")
public class Chamber {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message="Le numero de chambre est obligatoire")
    @Column(unique = true)
    private String numeroChambre;

    @Min(value = 0, message = "L'étage doit être positif ou zéro")
    private int etage;

    private double superficie;

    @NotNull(message = "Le type de chambre est obligatoire")
    @Enumerated(EnumType.STRING)
    private Typechamber type;

    @NotNull(message = "Le statut est obligatoire")
    @Enumerated(EnumType.STRING)
    private StatusChamber statut;

    @Positive(message = "Le loyer doit être positif")
    private Double loyerMensuel;

    private String description;

    @ElementCollection
    private List<String> equipements = new ArrayList<>();
}
