package com.imane.residence.gestion_residence.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;


@EnableMethodSecurity
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable()) // À réactiver en production
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(
                                "/api/viewcontroller/login",
                                "/login",
                                "/static/**",
                                "/api/utilisateurs/register",
                                "/api/admin/**",
                                "/api/viewcontroller/gestion-chambres",
                                "/api/viewcontroller/gestion-residents",
                                "/api/viewcontroller/gestion-paiement",// Ajouter cette ligne
                                "/api/chambres/**",
                                "/api/etudiants/**",
                                "/api/paiements/**"
                                // Et cette ligne
                        ).permitAll()
                        .requestMatchers("/api/viewcontroller/redireactByRole").authenticated()
                        .requestMatchers("/api/viewcontroller/profileEtudiant").hasAuthority("ROLE_ETUDIANT")
                        .requestMatchers("/api/viewcontroller/profileAdmin").hasAuthority("ROLE_ADMIN")
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/api/viewcontroller/login") // Page de login
                        .loginProcessingUrl("/login") // Endpoint de traitement du formulaire
                        .usernameParameter("email")
                        .defaultSuccessUrl("/api/viewcontroller/redirectByRole", true) // Redirection après succès
                        .failureUrl("/api/viewcontroller/login?error=true") // Redirection en cas d'échec
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/api/viewcontroller/login")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                )
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                        .invalidSessionUrl("/api/viewcontroller/login") // Corrigé ici
                );

        return http.build();
    }
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // Encoder les mots de passe avec BCrypt
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("http://localhost:63342")); // Autoriser l'origine de l'IDE
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS")); // Autoriser toutes les méthodes HTTP
        configuration.setAllowedHeaders(Arrays.asList("*")); // Autoriser tous les en-têtes
        configuration.setAllowCredentials(true); // Autoriser les cookies
        configuration.setMaxAge(3600L); // Durée de vie des configurations CORS
        configuration.setAllowedHeaders(Arrays.asList("Authorization", "Cache-Control", "Content-Type"));

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration); // Appliquer la configuration CORS à toutes les routes
        return source;
    }
}