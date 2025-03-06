package com.imane.residence.gestion_residence.models.entities;
import lombok.Builder;

@Builder
public class StatistiqueMaintenance {
    private long nombreEnAttente;
    private long nombreEnCours;
    private long nombreUrgentes;
}
