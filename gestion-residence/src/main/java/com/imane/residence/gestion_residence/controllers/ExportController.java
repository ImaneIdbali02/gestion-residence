package com.imane.residence.gestion_residence.controllers;

import com.imane.residence.gestion_residence.models.enums.FormatExport;
import com.imane.residence.gestion_residence.service.serviceInterfaces.ExportService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

@RestController
@RequestMapping("/api/export")
@RequiredArgsConstructor
public class ExportController {
    {/* private final ExportService exportService;

    @GetMapping("/residents")
    public ResponseEntity<byte[]> exporterListeResidents(@RequestParam FormatExport format) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(getMediaType(format));
        headers.setContentDispositionFormData("filename", "residents." + format.toString().toLowerCase());

        return ResponseEntity.ok()
                .headers(headers)
                .body(exportService.exporterListeResidents(format));
    }

    @GetMapping("/statistiques")
    public ResponseEntity<byte[]> exporterStatistiques(@RequestParam FormatExport format) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(getMediaType(format));
        headers.setContentDispositionFormData("filename", "statistiques." + format.toString().toLowerCase());

        return ResponseEntity.ok()
                .headers(headers)
                .body(exportService.exporterStatistiques(format));
    }

    @GetMapping("/maintenance")
    public ResponseEntity<byte[]> exporterHistoriqueMaintenance(
            @RequestParam LocalDate debut,
            @RequestParam LocalDate fin) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDispositionFormData("filename", "maintenance.pdf");

        return ResponseEntity.ok()
                .headers(headers)
                .body(exportService.exporterHistoriqueMaintenance(debut, fin));
    }

    private MediaType getMediaType(FormatExport format) {
        return format == FormatExport.PDF ? MediaType.APPLICATION_PDF :
                MediaType.APPLICATION_OCTET_STREAM;
    }  */}
}
