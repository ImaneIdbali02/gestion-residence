document.addEventListener('DOMContentLoaded', () => {
    const paymentsTable = document.getElementById('payments-table').getElementsByTagName('tbody')[0];
    const paymentModal = document.getElementById('payment-modal');
    const paymentForm = document.getElementById('payment-form');
    const addPaymentBtn = document.getElementById('add-payment-btn');
    const closeModal = document.querySelector('.close');

    // Fonction pour récupérer et afficher les paiements
    const fetchPayments = async () => {
        try {
            const response = await fetch('/api/paiements');
            if (!response.ok) throw new Error(`Erreur HTTP: ${response.status} - ${response.statusText}`);

            const payments = await response.json();
            paymentsTable.innerHTML = '';

            payments.forEach(payment => {
                const row = paymentsTable.insertRow();
                row.innerHTML = `
        <td>${payment.id}</td>
        <td>${payment.numeroEtudiant}</td>
        <td>${payment.montant} DH</td>
        <td>${payment.moisConcerne}</td>
        <td>${payment.statut}</td>
        <td>${payment.methodePaiement}</td>
        <td>
            <button onclick="editPayment(${payment.id})">✏️</button>
            <button onclick="deletePayment(${payment.id})">🗑️</button>
            <button onclick="generateInvoice(${payment.id}, '${payment.numeroEtudiant}', ${payment.montant}, '${payment.moisConcerne}', '${payment.methodePaiement}')">🧾 Télécharger Facture</button>
        </td>
       
    `;

            });

        } catch (error) {
            console.error("Erreur lors du chargement des paiements:", error);
            alert("Impossible de charger les paiements");
        }
    };

    // Ouvrir le modal pour ajouter/modifier un paiement
    const openModal = (payment = null) => {
        if (payment) {
            document.getElementById('payment-id').value = payment.id;
            document.getElementById('numero-etudiant').value = payment.numeroEtudiant;
            document.getElementById('montant').value = payment.montant;
            document.getElementById('mois-concerne').value = payment.moisConcerne;
            document.getElementById('statut').value = payment.statut;
            document.getElementById('methode-paiement').value = payment.methodePaiement;
        } else {
            paymentForm.reset();
            document.getElementById('payment-id').value = '';
        }
        paymentModal.style.display = 'block';
    };

    // Fermer le modal
    closeModal.onclick = () => {
        paymentModal.style.display = 'none';
        paymentForm.reset();
    };

    async function generateInvoice(id, numeroEtudiant, montant, moisConcerne, methodePaiement) {
        try {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            doc.setFontSize(18);
            doc.text("Facture de Paiement", 20, 20);

            doc.setFontSize(12);
            doc.text(`Numéro de l'étudiant : ${numeroEtudiant}`, 20, 40);
            doc.text(`ID Paiement : ${id}`, 20, 50);
            doc.text(`Montant : ${montant} DH`, 20, 60);
            doc.text(`Mois concerné : ${moisConcerne}`, 20, 70);
            doc.text(`Méthode de paiement : ${methodePaiement}`, 20, 80);

            doc.text("Merci pour votre paiement.", 20, 100);

            // Générer et télécharger le PDF
            doc.save(`facture_${numeroEtudiant}_${moisConcerne}.pdf`);
        } catch (error) {
            console.error("Erreur lors de la génération de la facture:", error);
            alert("Échec de la génération de la facture");
        }
    }
    window.generateInvoice = generateInvoice;

    window.onclick = (event) => {
        if (event.target === paymentModal) {
            paymentModal.style.display = 'none';
            paymentForm.reset();
        }
    };

    // Gestion de la soumission du formulaire
    paymentForm.onsubmit = async (e) => {
        e.preventDefault();

        const getValue = id => {
            const element = document.getElementById(id);
            if (!element) throw new Error(`Element ${id} non trouvé`);
            return element.value;
        };

        const paymentData = {
            id: getValue('payment-id') || null,  // Récupérer l'ID si existant
            numeroEtudiant: getValue('numero-etudiant'),
            montant: parseFloat(getValue('montant')),
            moisConcerne: getValue('mois-concerne'),
            statut: getValue('statut'),
            methodePaiement: getValue('methode-paiement'),
        };

        try {
            const method = paymentData.id ? 'PUT' : 'POST';
            const url = paymentData.id ? `/api/paiements/${paymentData.id}` : '/api/paiements';

            await fetch(url, {
                method: method,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(paymentData),
            });

            paymentModal.style.display = 'none';
            await fetchPayments();
        } catch (error) {
            console.error('Erreur:', error);
            alert("Erreur lors de l'enregistrement");
        }
    };

    // Édition d'un paiement
    window.editPayment = async (id) => {
        try {
            const response = await fetch(`/api/paiements/${id}`);
            if (!response.ok) throw new Error("Erreur lors de la récupération du paiement");

            const payment = await response.json();
            openModal(payment);
        } catch (error) {
            console.error("Erreur:", error);
            alert("Impossible de récupérer les détails du paiement");
        }
    };

    // Suppression d'un paiement
    window.deletePayment = async (id) => {
        if (!confirm("Voulez-vous vraiment supprimer ce paiement ?")) return;

        try {
            const response = await fetch(`/api/paiements/${id}`, { method: 'DELETE' });
            if (!response.ok) throw new Error("Erreur lors de la suppression");

            await fetchPayments();
        } catch (error) {
            console.error("Erreur:", error);
            alert("Échec de la suppression du paiement");
        }
    };

    // Bouton d'ajout de paiement
    addPaymentBtn.onclick = () => openModal();

    // Charger les paiements au démarrage
    fetchPayments();
});
