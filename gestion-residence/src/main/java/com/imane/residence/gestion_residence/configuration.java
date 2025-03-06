package com.imane.residence.gestion_residence;

import com.imane.residence.gestion_residence.models.dto.PaiementDTO;
import com.imane.residence.gestion_residence.models.entities.Paiement;
import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Configuration;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;


@Configuration
public class configuration {
    @Value("${modelmapper.strict-matching:true}")
    private boolean strictMatching;


    @Configuration
    public class ModelMapperConfig { // Renommez la classe pour suivre les conventions

        @Bean
        public ModelMapper modelMapper() {
            ModelMapper modelMapper = new ModelMapper();

            // 1. Appliquez la stratégie de matching strict
            modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);

            // 2. Ajoutez les mappings personnalisés
            modelMapper.typeMap(Paiement.class, PaiementDTO.class)
                    .addMappings(mapper -> {
                        mapper.map(src -> src.getEtudiant().getNumeroEtudiant(), PaiementDTO::setNumeroEtudiant);
                        mapper.map(Paiement::getMethodePaiement, PaiementDTO::setMethodePaiement);
                    });

            return modelMapper;
        }
    }
}
