**Gestion de Résidences Étudiantes**

## Description:
Ce projet est une application web permettant de gérer les résidences étudiantes. Il permet aux administrateurs de suivre les chambres, les résidants, les paiements, les requêtes de maintenance et de générer des rapports.

## Technologies Utilisées:
- **Java 21**
- **Spring Boot 3.4.1** (Spring MVC, Spring Security, Spring Data JPA, Spring Batch)
- **Thymeleaf** pour le rendu des pages web
- **MySQL** et **H2 Database** pour la gestion des données
- **Lombok** pour réduire le boilerplate
- **Apache POI** et **iTextPDF** pour la gestion des documents

## Fonctionnalités Principales
- Gestion des utilisateurs (administrateurs et résidents)
- Authentification et autorisation avec Spring Security
- Gestion des chambres et réservations
- Suivi des paiements et génération de factures
- Gestion des requêtes de maintenance
- Exportation des données en PDF et Excel

## Installation et Exécution
1. **Cloner le projet :**
   ```bash
   git clone https://github.com/ImaneIdbali02/gestion-residence.git
   cd gestion-residence
   ```

2. **Configurer la base de données :**
   - Modifier `application.properties` pour définir la connexion à MySQL ou utiliser H2.

3. **Construire et exécuter l'application :**
   ```bash
   mvn clean install
   mvn spring-boot:run
   ```

4. **Accéder à l'application :**
   - URL de l'application : `http://localhost:8080`

## Auteurs
- **Imane Idbali** 

## Licence
Ce projet est sous licence libre. Vous pouvez le modifier et le redistribuer selon vos besoins.

