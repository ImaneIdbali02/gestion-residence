package com.imane.residence.gestion_residence.service.serviceInterfaces;

import org.springframework.stereotype.Service;
import com.imane.residence.gestion_residence.models.enums.FormatExport;

import java.time.LocalDate;


public interface ExportService {
    public byte[] exporterListeResidents(FormatExport format);
    public byte[] exporterStatistiques(FormatExport format);
    public byte[] exporterHistoriqueMaintenance(LocalDate debut, LocalDate fin);
}
