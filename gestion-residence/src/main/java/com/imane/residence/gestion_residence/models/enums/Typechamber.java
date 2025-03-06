package com.imane.residence.gestion_residence.models.enums;

public enum Typechamber {
    SIMPLE("Simple"),
    DOUBLE("Double"),
    STUDIO("Studio");
    private final String label;
    Typechamber(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

}
