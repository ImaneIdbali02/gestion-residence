
// --- Sidebar Toggle ---
const toggleBtn = document.getElementById('toggle-btn');
if (toggleBtn) {
    toggleBtn.addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.querySelector('.main-content');

        if (sidebar.style.width === "250px") {
            sidebar.style.width = "60px";
            mainContent.style.marginLeft = "60px";
        } else {
            sidebar.style.width = "250px";
            mainContent.style.marginLeft = "250px";
        }
    });
}
// --- Graphique des paiements ---
if (document.getElementById('chart')) {
    const ctx = document.getElementById('chart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai'],
            datasets: [{
                label: 'Paiements en DH',
                data: [5000, 7000, 8000, 6000, 9000],
                backgroundColor: '#e74c3c'
            }]
        }
    });

}
// URL de base de l'API
const API_BASE_URL = '/api/chambres'; // Utilise le chemin relatif

// Éléments du DOM
const roomTableBody = document.getElementById('room-table-body');
const roomForm = document.getElementById('room-form');
const modal = document.getElementById('room-modal');
const addRoomBtn = document.getElementById('add-room-btn');
const closeBtn = document.querySelector('.close-btn');

// Ouvrir le modal pour ajouter une chambre
addRoomBtn.addEventListener('click', () => {
    modal.style.display = 'block';
    document.getElementById('modal-title').textContent = 'Ajouter une Chambre';
    roomForm.reset();
    delete roomForm.dataset.chambreId; // Supprimer l'ID de la chambre si présent
});

// Fermer le modal
closeBtn.addEventListener('click', () => {
    modal.style.display = 'none';
});

// Fermer le modal si on clique en dehors
window.addEventListener('click', (event) => {
    if (event.target === modal) {
        modal.style.display = 'none';
    }
});

// Récupérer et afficher les chambres au chargement de la page
document.addEventListener('DOMContentLoaded', () => {
    fetchChambres();
});

// Fonction pour récupérer les chambres depuis l'API
function fetchChambres() {
    fetch(API_BASE_URL)
        .then(response => response.json())
        .then(data => {
            roomTableBody.innerHTML = ''; // Vider le tableau avant d'ajouter les nouvelles données
            data.forEach(chambre => {
                const newRow = document.createElement('tr');
                newRow.innerHTML = `
                    <td>${chambre.numeroChambre}</td>
                    <td>${chambre.etage}</td>
                    <td>${chambre.superficie} m²</td>
                    <td>${chambre.type}</td>
                    <td>${chambre.statut}</td>
                    <td>${chambre.loyerMensuel} DH</td>
                    <td>
                        <button class="edit-btn" data-id="${chambre.id}">✏️</button>
                        <button class="delete-btn" data-id="${chambre.id}">🗑️</button>
                    </td>
                `;
                roomTableBody.appendChild(newRow);
            });
        })
        .catch(error => console.error('Erreur lors de la récupération des chambres:', error));
}

// Soumettre le formulaire pour ajouter ou modifier une chambre
roomForm.addEventListener('submit', (event) => {
    event.preventDefault();

    const roomData = {
        numeroChambre: document.getElementById('room-number').value,
        etage: parseInt(document.getElementById('room-floor').value),
        superficie: parseFloat(document.getElementById('room-size').value),
        type: document.getElementById('room-type').value,
        statut: document.getElementById('room-status').value,
        loyerMensuel: parseFloat(document.getElementById('room-rent').value),
        description: document.getElementById('room-description').value,
        equipements: document.getElementById('room-equipments').value.split(',').map(e => e.trim()),
    };

    const chambreId = roomForm.dataset.chambreId;

    if (chambreId) {
        // Mettre à jour une chambre existante
        fetch(`${API_BASE_URL}/${chambreId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(roomData),
        })
            .then(response => response.json())
            .then(data => {
                fetchChambres(); // Rafraîchir la liste des chambres
                modal.style.display = 'none';
            })
            .catch(error => console.error('Erreur lors de la modification de la chambre:', error));
    } else {
        // Ajouter une nouvelle chambre
        fetch(API_BASE_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(roomData),
        })
            .then(response => response.json())
            .then(data => {
                fetchChambres(); // Rafraîchir la liste des chambres
                modal.style.display = 'none';
            })
            .catch(error => console.error('Erreur lors de l\'ajout de la chambre:', error));
    }
});

// Supprimer une chambre
document.addEventListener('click', (event) => {
    if (event.target.classList.contains('delete-btn')) {
        const chambreId = event.target.dataset.id;

        if (confirm('Êtes-vous sûr de vouloir supprimer cette chambre ?')) {
            fetch(`${API_BASE_URL}/${chambreId}`, {
                method: 'DELETE',
            })
                .then(response => {
                    if (response.ok) {
                        fetchChambres(); // Rafraîchir la liste des chambres
                    }
                })
                .catch(error => console.error('Erreur lors de la suppression de la chambre:', error));
        }
    }
});

// Modifier une chambre
document.addEventListener('click', (event) => {
    if (event.target.classList.contains('edit-btn')) {
        const chambreId = event.target.dataset.id;

        fetch(`${API_BASE_URL}/${chambreId}`)
            .then(response => response.json())
            .then(chambre => {
                // Remplir le formulaire avec les données de la chambre
                document.getElementById('room-number').value = chambre.numeroChambre;
                document.getElementById('room-floor').value = chambre.etage;
                document.getElementById('room-size').value = chambre.superficie;
                document.getElementById('room-type').value = chambre.type;
                document.getElementById('room-status').value = chambre.statut;
                document.getElementById('room-rent').value = chambre.loyerMensuel;
                document.getElementById('room-description').value = chambre.description;
                document.getElementById('room-equipments').value = chambre.equipements ? chambre.equipements.join(', ') : '';

                // Ouvrir le modal
                modal.style.display = 'block';
                document.getElementById('modal-title').textContent = 'Modifier la Chambre';
                roomForm.dataset.chambreId = chambreId;
            })
            .catch(error => console.error('Erreur lors de la récupération de la chambre:', error));
    }
});