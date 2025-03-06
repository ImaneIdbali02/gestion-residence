package com.imane.residence.gestion_residence.service.serviceInterfaces;

import org.springframework.stereotype.Service;


public interface EmailService {
    void sendOTP(String to, String otp, String nom);
}