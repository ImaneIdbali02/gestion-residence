package com.imane.residence.gestion_residence.service.serviceImp;
import com.imane.residence.gestion_residence.models.dto.ChamberDTO;
import com.imane.residence.gestion_residence.models.entities.Chamber;
import com.imane.residence.gestion_residence.models.enums.StatusChamber;
import com.imane.residence.gestion_residence.models.enums.Typechamber;
import org.modelmapper.ModelMapper;
import com.imane.residence.gestion_residence.repositories.ChamberRepo;
import com.imane.residence.gestion_residence.service.serviceInterfaces.Chamberservice;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;

@Configuration
@Service
@RequiredArgsConstructor
public class ChamberserviceImp implements Chamberservice {
    private final ChamberRepo chambreRepository;
    private final ModelMapper mapper;
    private static final Logger log = LoggerFactory.getLogger(ChamberserviceImp.class);
    @Override
    public void changerStatutChambre(Long id, StatusChamber statut) {
        Chamber chambre = chambreRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Chambre non trouvée"));

        // Vérifier si le changement de statut est possible
        if (chambre.getStatut() == StatusChamber.OCCUPEE &&
                statut != StatusChamber.MAINTENANCE) {
            throw new RuntimeException("Impossible de changer le statut d'une chambre occupée");
        }

        chambre.setStatut(statut);
        chambreRepository.save(chambre);
    }

    @Override
    public void deleteChambre(Long id) {
        if (!chambreRepository.existsById(id)) {
            throw new RuntimeException("Chambre non trouvée");
        }
        chambreRepository.deleteById(id);
    }

    @Override
    public ChamberDTO createChambre(ChamberDTO chambreDTO) {
        Chamber chambre = mapper.map(chambreDTO, Chamber.class);
        chambre = chambreRepository.save(chambre);
        return mapper.map(chambre, ChamberDTO.class);
    }

    @Override
    public ChamberDTO getChambreById(Long id){
        return chambreRepository.findById(id)
        .map(Chamber -> mapper.map(Chamber, ChamberDTO.class))
        .orElseThrow(() -> new RuntimeException("Chambre non trouvée"));
    }

    @Override
    @Transactional
    public ChamberDTO updateChambre(Long id, ChamberDTO chambreDTO) {
        try {
            Chamber existing = chambreRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Chambre non trouvée"));

            // Vérification supplémentaire : numéro de chambre déjà utilisé
            if (!existing.getNumeroChambre().equals(chambreDTO.getNumeroChambre())) {
                chambreRepository.findByNumeroChambre(chambreDTO.getNumeroChambre())
                        .ifPresent(chambre -> {
                            throw new RuntimeException("Le numéro de chambre est déjà utilisé");
                        });
            }

            // Configurez le mapping pour ignorer l'id si ce n'est pas déjà fait globalement
            mapper.typeMap(ChamberDTO.class, Chamber.class)
                    .addMappings(mapper -> mapper.skip(Chamber::setId));

            // Mapper les champs sans écraser l'id existant
            mapper.map(chambreDTO, existing);
            existing = chambreRepository.save(existing);
            return mapper.map(existing, ChamberDTO.class);
        } catch (Exception e) {
            log.error("Erreur lors de la mise à jour de la chambre", e);
            throw e; // Rejette l'exception pour qu'elle soit capturée par le contrôleur
        }
    }



    @Override
    public List<ChamberDTO> getAllChambres(){
        return chambreRepository.findAll().stream()
                .map(Chamber-> mapper.map(Chamber, ChamberDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<ChamberDTO> getChambresByStatut(StatusChamber statut){
        return chambreRepository.findByStatut(statut).stream()
                .map(Chamber-> mapper.map(Chamber, ChamberDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<ChamberDTO> getChambresByType(Typechamber type){
        return chambreRepository.findByType(type).stream()
                .map(Chamber-> mapper.map(Chamber, ChamberDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<ChamberDTO> getChambresByLoyerMaximum(double maxLoyer){
        return chambreRepository.findByLoyerMaximum(maxLoyer).stream()
                .map(Chamber-> mapper.map(Chamber, ChamberDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public boolean verifierDisponibilite(Long chambreId){
        return chambreRepository.findById(chambreId)
                .map(chambre -> chambre.getStatut() == StatusChamber.DISPONIBLE)
                .orElseThrow(() -> new RuntimeException("Chambre non trouvée"));

    }

    @Override
    public ChamberDTO getChambreByNum(String num) {
        return chambreRepository.findByNumeroChambre(num) // Ensure method is defined in ChamberRepo
                .map(Chamber -> mapper.map(Chamber, ChamberDTO.class))
                .orElseThrow(() -> new RuntimeException("Chambre non trouvée"));

    }

     @Override
     public List<ChamberDTO> getAvailableRoomsByType (Typechamber Type){
            return chambreRepository.findDisponiblesByType(Type).stream()
                    .map(chamber -> mapper.map(chamber, ChamberDTO.class))
                    .collect(Collectors.toList());


        }


    @Override
    public long getNombreChambreParStatut(StatusChamber statut) {
        return chambreRepository.countByStatut(statut);
    }

    @Override
    public List<ChamberDTO> rechercheAvanceeChambres(Typechamber type, StatusChamber statut, Double loyerMin, Double loyerMax) {
        return chambreRepository.rechercheAvancee(type, statut, loyerMin, loyerMax).stream()
                .map(chambre -> mapper.map(chambre, ChamberDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<ChamberDTO> rechercherChambres(String terme) {
        return chambreRepository.rechercher(terme).stream()
                .map(chambre -> mapper.map(chambre, ChamberDTO.class))
                .collect(Collectors.toList());
    }

}


