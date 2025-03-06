// Configuration de base
const ADMIN_API_URL = '/api/admin';
const ETUDIANT_API_URL = '/api/etudiants';
const CHAMBRES_API_URL = '/api/chambres';

// Éléments du DOM
const residentTableBody = document.getElementById('resident-table-body');
const residentForm = document.getElementById('resident-form');
const modal = document.getElementById('resident-modal');
const addResidentBtn = document.getElementById('add-resident-btn');
const closeBtn = document.querySelector('.close-btn');
const statusFilter = document.getElementById('status-filter');
const toggleBtn = document.getElementById('toggle-btn');

// Initialisation
document.addEventListener('DOMContentLoaded', () => {
    loadResidents();
    loadAvailableRooms();
    initializeEventListeners();
});

// Initialisation des écouteurs d'événements
function initializeEventListeners() {
    // Modal
    addResidentBtn.addEventListener('click', openAddModal);
    closeBtn.addEventListener('click', closeModal);
    window.addEventListener('click', closeModalOnOutsideClick);

    // Formulaire
    residentForm.addEventListener('submit', handleFormSubmit);

    // Filtres
    statusFilter.addEventListener('change', handleStatusFilter);

    // Sidebar
    toggleBtn.addEventListener('click', toggleSidebar);
}

// Charger les résidents (filtrage par statut si renseigné)
function loadResidents(status = '') {
    let url = ETUDIANT_API_URL;
    if (status) url += `?statut=${status}`;

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Erreur lors du chargement des résidents');
            }
            return response.json();
        })
        .then(residents => {
            console.log("Liste des résidents reçue:", residents);
            residentTableBody.innerHTML = '';
            residents.forEach(renderResidentRow);
        })
        .catch(error => {
            console.error('Erreur:', error);
            alert('Une erreur est survenue lors du chargement des résidents');
        });

}

// Rendu d'un résident dans le tableau
// Dans renderResidentRow()
function renderResidentRow(resident) {
    const row = document.createElement('tr');
    row.innerHTML = `
        <td>${resident.utilisateur.name}</td>
        <td>${resident.utilisateur.prenom}</td>
        <td>${resident.utilisateur.email}</td>
        <td>${resident.chambres?.numeroChambre || 'Non assigné'}</td>
        <td>
            <span class="status-badge ${resident.statut.toLowerCase()}">
                ${resident.statut}
            </span>
        </td>
        <td>
             <span class="payment-badge ${resident.statutPaiement.toLowerCase()}">
              ${resident.statutPaiement}
             </span>
        </td>

        <td>
            <button class="btn-liberer" type="button">🚪 Libérer</button>
            <button class="btn-supprimer" type="button">🗑️</button>
            <button class="btn-edit" type="button">modifier </button>
        </td>
    `;

    // Ajout des écouteurs d’événements
    const libererBtn = row.querySelector('.btn-liberer');
    libererBtn.addEventListener('click', () => libererChambre(resident.id));

    const supprimerBtn = row.querySelector('.btn-supprimer');
    supprimerBtn.addEventListener('click', () => deleteResident(resident.id));

    const modifierBtn = row.querySelector('.btn-edit');
    modifierBtn.addEventListener('click', () => editResident(resident.id));


    residentTableBody.appendChild(row);
}


// Charger les chambres disponibles (celles dont le statut est DISPONIBLE)
function loadAvailableRooms() {
    fetch(`${CHAMBRES_API_URL}?statut=DISPONIBLE`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Erreur lors du chargement des chambres');
            }
            return response.json();
        })
        .then(rooms => {
            const roomSelect = document.getElementById('room');
            roomSelect.innerHTML = '<option value="">Sélectionner une chambre</option>';
            rooms.forEach(room => {
                roomSelect.innerHTML += `
                    <option value="${room.id}">
                        Chambre ${room.numeroChambre} - ${room.type}
                    </option>
                `;
            });
        })
        .catch(error => {
            console.error('Erreur:', error);
            alert('Une erreur est survenue lors du chargement des chambres');
        });
}

// Gestion du formulaire de création/modification d'un résident
async function handleFormSubmit(e) {
    e.preventDefault();

    const formData = {
        etudiantDTO: {
            utilisateur: {
                prenom: document.getElementById('first-name').value,
                name: document.getElementById('last-name').value,
                email: document.getElementById('email').value,
                telephone: document.getElementById('phone').value,
                password: document.getElementById('password').value
            },
            statut: document.getElementById('status').value,
            numeroEtudiant: document.getElementById('numero-etudiant').value,
            etablissement: document.getElementById('etablissement').value,
            niveauEtudes: document.getElementById('niveau-etudes').value,
            dateDebutSejour: document.getElementById('date-debut').value,
            dateFinSejour: document.getElementById('date-fin').value || null
        },
        chambreId: document.getElementById('room').value,
        typeChambre: document.getElementById('room-type').value
    };

    try {
        const response = await fetch(`${ADMIN_API_URL}/creer-et-assigner`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(formData)
        });

        if (response.ok) {
            await loadResidents();
            closeModal();
        } else {
            const errorText = await response.text();
            throw new Error(`Erreur lors de la sauvegarde : ${errorText}`);
        }
    } catch (error) {
        console.error('Erreur:', error);
        alert(error.message);
    }
}

// Libérer une chambre pour un étudiant
async function libererChambre(etudiantId) {
    console.log("libererChambre appelée avec l'id:", etudiantId);
        if (confirm('Êtes-vous sûr de vouloir libérer cette chambre ?')) {
            try {
                const response = await fetch(`${ADMIN_API_URL}/liberer-chambre?etudiantId=${etudiantId}`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' }
                });

                if (response.ok) {
                    await loadResidents();
                    alert("Chambre libérée avec succès !");
                } else {
                    const errorText = await response.text(); // Lire le message d'erreur
                    alert(`Erreur: ${errorText}`);
                }
            } catch (error) {
                console.error('Erreur:', error);
                alert('Une erreur est survenue lors de la libération de la chambre');
            }
        }

}

// Chargement des données d'un résident dans le formulaire pour modification
async function editResident(id) {
    try {
        const response = await fetch(`${ETUDIANT_API_URL}/${id}`);
        const resident = await response.json();

        // Remplir le formulaire avec les données récupérées
        document.getElementById('first-name').value = resident.utilisateur.prenom;
        document.getElementById('last-name').value = resident.utilisateur.name;
        document.getElementById('email').value = resident.utilisateur.email;
        document.getElementById('phone').value = resident.utilisateur.telephone;
        // Pour la modification, le mot de passe peut rester vide ou être géré séparément
        document.getElementById('password').value = "";
        document.getElementById('status').value = resident.statut;
        document.getElementById('numero-etudiant').value = resident.numeroEtudiant;
        document.getElementById('etablissement').value = resident.etablissement;
        document.getElementById('niveau-etudes').value = resident.niveauEtudes;
        document.getElementById('date-debut').value = resident.dateDebutSejour;
        document.getElementById('date-fin').value = resident.dateFinSejour || "";

        // Charger les chambres disponibles pour la sélection
        await loadAvailableRooms();

        // Si le résident possède une chambre assignée, la sélectionner dans le formulaire
        if (resident.chambreId) {
            document.getElementById('room').value = resident.chambreId.id;
        }

        // Enregistrer l'ID du résident dans le dataset du formulaire pour signaler un mode édition
        residentForm.dataset.residentId = id;
        openModal('Modifier un Résident');
    } catch (error) {
        console.error('Erreur lors de la modification:', error);
        alert('Une erreur est survenue lors du chargement des données');
    }
}

// Suppression d'un résident
async function deleteResident(id) {
    if (confirm('Êtes-vous sûr de vouloir supprimer ce résident ?')) {
        try {
            // Correction de l'URL
            const url = `${ADMIN_API_URL}/etudiants/${id}`;
            const response = await fetch(url, {
                method: 'DELETE'
            });
            if (response.ok) {
                await loadResidents();
            } else {
                const errorText = await response.text();
                throw new Error(errorText);
            }
        } catch (error) {
            console.error('Erreur:', error);
            alert(error.message);
        }
    }
}


// Fonctions utilitaires pour gérer le modal et la sidebar
function openAddModal() {
    residentForm.reset();
    delete residentForm.dataset.residentId;
    openModal('Ajouter un Résident');
}

function openModal(title) {
    document.getElementById('modal-title').textContent = title;
    modal.style.display = 'block';
}

function closeModal() {
    modal.style.display = 'none';
    residentForm.reset();
}

function closeModalOnOutsideClick(e) {
    if (e.target === modal) {
        closeModal();
    }
}

function handleStatusFilter(e) {
    loadResidents(e.target.value);
}

function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    sidebar.classList.toggle('collapsed');
}


