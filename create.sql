
    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chamber_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chamber_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FK3jpu1xgvistdt8egxa6okmxps 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKoi8m2pif8p8i6we14dofmvb52 
       foreign key (chamber_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        adresse varchar(255) not null,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        adresse varchar(255) not null,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        email varchar(255),
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','ETUDIANT','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    create table admins (
        date_debut date,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        fonction varchar(255),
        numero_telephone_professionnel varchar(255),
        service varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table chamber_equipements (
        chamber_id bigint not null,
        equipements varchar(255)
    ) engine=InnoDB;

    create table chambres (
        etage integer not null,
        loyer_mensuel float(53),
        superficie float(53) not null,
        id bigint not null auto_increment,
        description varchar(255),
        numero_chambre varchar(255) not null,
        statut enum ('DISPONIBLE','MAINTENANCE','OCCUPEE','RESERVEE') not null,
        type enum ('DOUBLE','SIMPLE','STUDIO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table etudiant (
        date_debut_sejour date not null,
        date_fin_sejour date,
        chambres_id bigint,
        id bigint not null auto_increment,
        utilisateur_id bigint,
        etablissement varchar(255),
        niveau_etudes varchar(255),
        numero_etudiant varchar(255) not null,
        statut enum ('ACTIF','ANCIEN','INACTIF'),
        primary key (id)
    ) engine=InnoDB;

    create table maintenances (
        date_creation date,
        assigne_a_id bigint,
        chambres_id bigint not null,
        date_resolution datetime(6),
        date_signalement datetime(6) not null,
        etudiant_id bigint,
        id bigint not null auto_increment,
        signale_par_id bigint,
        commentaires varchar(255),
        description varchar(255) not null,
        priorite enum ('BASSE','HAUTE','NORMALE','URGENTE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_COURS','TERMINEE'),
        primary key (id)
    ) engine=InnoDB;

    create table methode_paiement (
        actif bit not null,
        id bigint not null auto_increment,
        description varchar(255),
        fournisseur varchar(255),
        informations_bancaires varchar(255),
        nom varchar(255) not null,
        type enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        primary key (id)
    ) engine=InnoDB;

    create table paiements (
        montant float(53) not null,
        date_paiement datetime(6) not null,
        etudiant_id bigint not null,
        id bigint not null auto_increment,
        reference varchar(255),
        mois_concerne varbinary(255) not null,
        methode_paiement enum ('CARTE_BANCAIRE','ESPECES','VIREMENT_BANCAIRE'),
        statut enum ('ANNULEE','EN_ATTENTE','EN_RETARD','PAYEE'),
        primary key (id)
    ) engine=InnoDB;

    create table personnel_maintenance (
        id bigint not null auto_increment,
        utilisateur_id bigint,
        numero_telephone_professionnel varchar(255),
        specialite varchar(255),
        zone_travail varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table utilisateur (
        actif bit not null,
        date_creation datetime(6),
        id bigint not null auto_increment,
        reset_otp_expiry datetime(6),
        email varchar(255) not null,
        name varchar(255) not null,
        password varchar(255) not null,
        prenom varchar(255) not null,
        reset_otp varchar(255),
        telephone varchar(255),
        role enum ('ADMIN','Etudiant','Maintenance'),
        primary key (id)
    ) engine=InnoDB;

    alter table admins 
       add constraint UKb91gg1tloq6xgmqv907u5p2wd unique (utilisateur_id);

    alter table chambres 
       add constraint UK7m69nvvw81tss9qwaijm5ad8b unique (numero_chambre);

    alter table etudiant 
       add constraint UK5f5gp12dpncbvi9ugxey26g52 unique (utilisateur_id);

    alter table etudiant 
       add constraint UKrrlvbi78hs4m4ltg9of8dwyd4 unique (numero_etudiant);

    alter table maintenances 
       add constraint UKg4oxb7vv26f0vw4ovvarnh3c unique (etudiant_id);

    alter table personnel_maintenance 
       add constraint UK9fp064u4p0a2jcd0kqmmdkei8 unique (utilisateur_id);

    alter table utilisateur 
       add constraint UKrma38wvnqfaf66vvmi57c71lo unique (email);

    alter table admins 
       add constraint FKm2b7stdwq7xo7wdw942t4daqx 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table chamber_equipements 
       add constraint FKfjjkeug7m4cftt2oumur6jfe6 
       foreign key (chamber_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKduss9kh2s3mj8w15b9ppwjs3o 
       foreign key (chambres_id) 
       references chambres (id);

    alter table etudiant 
       add constraint FKk1k5fhsjak7v0uk031i5geqj9 
       foreign key (utilisateur_id) 
       references utilisateur (id);

    alter table maintenances 
       add constraint FKs57a6i64pp2n5u42l8gkxin2q 
       foreign key (assigne_a_id) 
       references personnel_maintenance (id);

    alter table maintenances 
       add constraint FKpoowe4f7maqirp7apgcrtwiu6 
       foreign key (chambres_id) 
       references chambres (id);

    alter table maintenances 
       add constraint FK6r1dfnsj66xi5b8q70x6xhc0l 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table maintenances 
       add constraint FK7xd7sn3ijjqllxdqs80q64j8p 
       foreign key (signale_par_id) 
       references utilisateur (id);

    alter table paiements 
       add constraint FKhg46t5ar63mn4d6a30ey6hf2h 
       foreign key (etudiant_id) 
       references etudiant (id);

    alter table personnel_maintenance 
       add constraint FKk7jva8mjy03w50qmfy27footg 
       foreign key (utilisateur_id) 
       references utilisateur (id);
