
<?php
ob_start(); //Gérer l'en-têtes (header()) après l'echo 
include '../includes/header.php';
$page_title = "Gestion des Notes";
require_once '../config/database.php';

// Récupérer l'ID du formateur connecté
$formateur_id = $_SESSION['user_id'];

// Filtrer par groupe si spécifié
$groupe_id = isset($_GET['groupe']) ? intval($_GET['groupe']) : null;

// Traitement des actions
$message = '';
$error = '';

// Supprimer une note
if (isset($_GET['delete']) && is_numeric($_GET['delete'])) {
    $id = $_GET['delete'];
    $stmt = $conn->prepare("DELETE FROM Note WHERE id_note = ? AND id_formateur = ?");
    $stmt->bind_param("ii", $id, $formateur_id);
    
    if ($stmt->execute()) {
        $message = "Note supprimée avec succès";
    } else {
        $error = "Erreur lors de la suppression de la note: " . $conn->error;
    }
    
    $stmt->close();
}


// Récupérer les notes saisies par ce formateur
$notes = [];
$query = "
    SELECT n.id_note, s.nom as stagiaire_nom, s.prenom as stagiaire_prenom, 
           m.nom_module, n.note1, n.note2, n.note3, n.EFM, n.Moyenne, 
           n.date_creation, n.date_modification, g.nom_Groupe
    FROM Note n
    JOIN Stagiaire s ON n.id_stagiaire = s.id_stagiaire
    JOIN Module m ON n.id_module = m.id_module
    JOIN Groupe g ON s.id_Groupe = g.id_Groupe
    JOIN formateur_groupe fg ON g.id_Groupe = fg.id_groupe
    WHERE n.id_formateur = ? AND fg.id_formateur = ?
";

// le filtre de groupe 
if ($groupe_id) {
    $query .= " AND g.id_Groupe = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("iii", $formateur_id, $formateur_id, $groupe_id);
} else {
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ii", $formateur_id, $formateur_id);
}

$stmt->execute();
$result = $stmt->get_result();

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $notes[] = $row;
    }
}
$stmt->close();

// Récupérer les modules
$modules = [];
$stmt = $conn->prepare("
    SELECT id_module, nom_module
    FROM Module
    ORDER BY nom_module
");
$stmt->execute();
$result = $stmt->get_result();

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $modules[] = $row;
    }
}
$stmt->close();

// Récupérer les stagiaires associés à ce formateur via les groupes
$stagiaires = [];
$query = "
    SELECT s.id_stagiaire, s.nom, s.prenom, f.nom_filiere, g.nom_Groupe
    FROM Stagiaire s
    JOIN Filiere f ON s.id_Filiere = f.id_Filiere
    JOIN Groupe g ON s.id_Groupe = g.id_Groupe
    JOIN formateur_groupe fg ON g.id_Groupe = fg.id_groupe
    WHERE fg.id_formateur = ?
";

// Ajouter le filtre de groupe si nécessaire
if ($groupe_id) {
    $query .= " AND g.id_Groupe = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ii", $formateur_id, $groupe_id);
} else {
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $formateur_id);
}

$stmt->execute();
$result = $stmt->get_result();

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $stagiaires[] = $row;
    }
}
$stmt->close();

// Traitement du formulaire d'ajout/modification de note
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $stagiaire_id = $_POST['stagiaire_id'];
    $module_id = $_POST['module_id'];
    $note1 = $_POST['note1'];
    $note2 = $_POST['note2'];
    $note3 = $_POST['note3'];
    $efm = $_POST['efm'];
    
    // Calculer la moyenne (exemple: 50% pour les notes continues, 50% pour l'EFM)
$moyenne_continue = ($note1 + $note2 + $note3) / 3;
$moyenne = ($moyenne_continue * 0.5) + ($efm * 0.5);
$moyenne = round($moyenne, 2);

    
    // Vérifier si une note existe déjà pour ce stagiaire et ce module
    $stmt = $conn->prepare("
        SELECT id_note FROM Note 
        WHERE id_stagiaire = ? AND id_module = ? AND id_formateur = ?
    ");
    $stmt->bind_param("isi", $stagiaire_id, $module_id, $formateur_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        // Mettre à jour la note existante
        $note_id = $result->fetch_assoc()['id_note'];
        $stmt = $conn->prepare("
            UPDATE Note 
            SET note1 = ?, note2 = ?, note3 = ?, EFM = ?, Moyenne = ?
            WHERE id_note = ?
        ");
        $stmt->bind_param("dddddi", $note1, $note2, $note3, $efm, $moyenne, $note_id);
        
        if ($stmt->execute()) {
            $message = "Note mise à jour avec succès";
        } else {
            $error = "Erreur lors de la mise à jour de la note: " . $conn->error;
        }
    } else {
        // Ajouter une nouvelle note
        $stmt = $conn->prepare("
        INSERT INTO Note (id_stagiaire, id_module, id_formateur, note1, note2, note3, EFM, Moyenne)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ");
    $stmt->bind_param("iiidddds", $stagiaire_id, $module_id, $formateur_id, $note1, $note2, $note3, $efm, $moyenne);
    
        
        if ($stmt->execute()) {
            $message = "Note ajoutée avec succès";
        } else {
            $error = "Erreur lors de l'ajout de la note: " . $conn->error;
        }
    }
    
    $stmt->close();
    
    // Rediriger a notes.php
    header("Location: notes.php");
    exit;
}

// Récupérer les groupes du formateur pour le filtre
$groupes = [];
$stmt = $conn->prepare("
    SELECT g.id_Groupe, g.nom_Groupe
    FROM formateur_groupe fg
    JOIN Groupe g ON fg.id_groupe = g.id_Groupe
    WHERE fg.id_formateur = ?
    ORDER BY g.nom_Groupe
");
$stmt->bind_param("i", $formateur_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $groupes[] = $row;
    }
}
$stmt->close();

$conn->close();    
?>

<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">Gestion des Notes</h1>
    
    <?php if (!empty($message) || isset($_GET['success'])): ?>
        <div class="alert alert-success"><?php echo $message ?: "Opération réussie"; ?></div>
    <?php endif; ?>
    
    <?php if (!empty($error)): ?>
        <div class="alert alert-danger"><?php echo $error; ?></div>
    <?php endif; ?>
    
    <!-- Filtre par groupe -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-success">Filtrer par groupe</h6>
        </div>
        <div class="card-body">
            <form method="GET" action="" class="form-inline">
                <div class="form-group mr-3">
                    <select class="form-control" name="groupe">
                        <option value="">Tous les groupes</option>
                        <?php foreach ($groupes as $groupe): ?>
                            <option value="<?php echo $groupe['id_Groupe']; ?>" <?php echo ($groupe_id == $groupe['id_Groupe']) ? 'selected' : ''; ?>>
                                <?php echo htmlspecialchars($groupe['nom_Groupe']); ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div><br>
                <button type="submit" class="btn btn-primary">Filtrer</button>
                <?php if ($groupe_id): ?>
                    <a href="notes.php" class="btn btn-secondary ml-2">Réinitialiser</a>
                <?php endif; ?>
            </form>
        </div>
    </div>
    
    <!-- Formulaire d'ajout/modification de note -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-success">Ajouter/Modifier une note</h6>
        </div>
        <div class="card-body">
            <form method="POST" action="notes.php">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="stagiaire_id">Stagiaire</label>
                        <select class="form-control" id="stagiaire_id" name="stagiaire_id" required>
                            <option value="">Sélectionner un stagiaire</option>
                            <?php foreach ($stagiaires as $stagiaire): ?>
                                <option value="<?php echo $stagiaire['id_stagiaire']; ?>">
                                    <?php echo htmlspecialchars($stagiaire['prenom'] . ' ' . $stagiaire['nom'] . ' (' . $stagiaire['nom_filiere'] . ' - ' . $stagiaire['nom_Groupe'] . ')'); ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label for="module_id">Module</label>
                        <select class="form-control" id="module_id" name="module_id" required>
                            <option value="">Sélectionner un module</option>
                            <?php foreach ($modules as $module): ?>
                                <option value="<?php echo $module['id_module']; ?>">
                                    <?php echo htmlspecialchars($module['nom_module']); ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label for="note1">Note 1</label>
                        <input type="number" class="form-control" id="note1" name="note1" min="0" max="20" step="0.01" required>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label for="note2">Note 2</label>
                        <input type="number" class="form-control" id="note2" name="note2" min="0" max="20" step="0.01" required>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label for="note3">Note 3</label>
                        <input type="number" class="form-control" id="note3" name="note3" min="0" max="20" step="0.01" required>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label for="efm">EFM</label>
                        <input type="number" class="form-control" id="efm" name="efm" min="0" max="20" step="0.01" required>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary">Enregistrer</button>
            </form>
        </div>
    </div>
    
    <!-- Liste des notes -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-success">Liste des Notes</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Stagiaire</th>
                            <th>Groupe</th>
                            <th>Module</th>
                            <th>Note 1</th>
                            <th>Note 2</th>
                            <th>Note 3</th>
                            <th>EFM</th>
                            <th>Moyenne</th>
                            <th>Date de modification</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($notes)): ?>
                            <tr>
                                <td colspan="10" class="text-center">Aucune note trouvée</td>
                            </tr>
                        <?php else: ?>
                            <?php foreach ($notes as $note): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($note['stagiaire_prenom'] . ' ' . $note['stagiaire_nom']); ?></td>
                                    <td><?php echo htmlspecialchars($note['nom_Groupe']); ?></td>
                                    <td><?php echo htmlspecialchars($note['nom_module']); ?></td>
                                    <td><?php echo htmlspecialchars($note['note1']); ?></td>
                                    <td><?php echo htmlspecialchars($note['note2']); ?></td>
                                    <td><?php echo htmlspecialchars($note['note3']); ?></td>
                                    <td><?php echo htmlspecialchars($note['EFM']); ?></td>
                                    <td><?php echo htmlspecialchars($note['Moyenne']); ?></td>
                                    <td><?php echo date('d/m/Y H:i', strtotime($note['date_modification'])); ?></td>
                                    <td>
                                        <button class="btn btn-sm btn-primary edit-note" 
                                                data-id="<?php echo $note['id_note']; ?>"
                                                data-note1="<?php echo $note['note1']; ?>"
                                                data-note2="<?php echo $note['note2']; ?>"
                                                data-note3="<?php echo $note['note3']; ?>"
                                                data-efm="<?php echo $note['EFM']; ?>">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <a href="notes.php<?php echo $groupe_id ? "?groupe=$groupe_id&" : "?"; ?>delete=<?php echo $note['id_note']; ?>" class="btn btn-sm btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette note?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <?php
ob_end_flush(); ?>

</div>

<script>
//  remplir le formulaire lors de l'édition d'une note
document.addEventListener('DOMContentLoaded', function() {
    const editButtons = document.querySelectorAll('.edit-note');
    
    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            const noteId = this.getAttribute('data-id');
            const note1 = this.getAttribute('data-note1');
            const note2 = this.getAttribute('data-note2');
            const note3 = this.getAttribute('data-note3');
            const efm = this.getAttribute('data-efm');
            
            // Remplir le formulaire avec les valeurs existantes
            document.getElementById('note1').value = note1;
            document.getElementById('note2').value = note2;
            document.getElementById('note3').value = note3;
            document.getElementById('efm').value = efm;
            
            // Faire défiler jusqu'au formulaire
            document.querySelector('.card').scrollIntoView({ behavior: 'smooth' });
        });
    });
});
</script>

<?php include '../includes/footer.php'; ?>
