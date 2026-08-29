<?php
$page_title = "Gestion des Notes";
require_once '../config/database.php';
include '../includes/header.php';

// Traitement des messages
$message = '';
$error = '';

// Récupérer tous les groupes pour afficher les boutons
$groupes = [];
$result = $conn->query("SELECT DISTINCT nom_groupe FROM Groupe");
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $groupes[] = $row['nom_groupe'];
    }
}

// Groupe sélectionné (filtrage)
$groupe_filtre = isset($_GET['groupe']) ? $_GET['groupe'] : '';

// Récupérer les notes (avec filtrage par groupe si besoin)
$notes = [];
$query = "
    SELECT n.id_note, s.nom AS stagiaire_nom, s.prenom AS stagiaire_prenom, 
           m.nom_module, f.nom AS formateur_nom, f.prenom AS formateur_prenom,
           n.note1, n.note2, n.note3, n.EFM, n.Moyenne, n.date_creation, n.date_modification,
           g.nom_groupe
    FROM Note n
    JOIN Stagiaire s ON n.id_stagiaire = s.id_stagiaire
    JOIN Groupe g ON s.id_groupe = g.id_groupe
    JOIN Module m ON n.id_module = m.id_module
    JOIN Formateur f ON n.id_formateur = f.id_formateur
";

if ($groupe_filtre) {
    $query .= " WHERE g.nom_groupe = '" . $conn->real_escape_string($groupe_filtre) . "'";
}

$query .= " ORDER BY n.date_modification DESC";

$result = $conn->query($query);
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $notes[] = $row;
    }
}

$conn->close();
?>

<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">Gestion des Notes</h1>

    <?php if (!empty($message)): ?>
        <div class="alert alert-success"><?php echo $message; ?></div>
    <?php endif; ?>
    
    <?php if (!empty($error)): ?>
        <div class="alert alert-danger"><?php echo $error; ?></div>
    <?php endif; ?>

    <!-- Boutons de groupes -->
    <div class="mb-4">
        <a href="notes.php" class="btn btn-secondary btn-sm <?php if (!$groupe_filtre) echo 'active'; ?>">Tous les groupes</a>
        <?php foreach ($groupes as $groupe): ?>
            <a href="notes.php?groupe=<?php echo urlencode($groupe); ?>" 
               class="btn btn-primary btn-sm <?php if ($groupe_filtre == $groupe) echo 'active'; ?>">
                <?php echo htmlspecialchars($groupe); ?>
            </a>
        <?php endforeach; ?>
    </div>

    <!-- Tableau des notes -->
    <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <h6 class="m-0 font-weight-bold text-success">Liste des Notes</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Groupe</th>
                            <th>Stagiaire</th>
                            <th>Module</th>
                            <th>Formateur</th>
                            <th>Note 1</th>
                            <th>Note 2</th>
                            <th>Note 3</th>
                            <th>EFM</th>
                            <th>Moyenne</th>
                            <th>Date de modification</th>
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
                                    <td><?php echo htmlspecialchars($note['nom_groupe']); ?></td>
                                    <td><?php echo htmlspecialchars($note['stagiaire_prenom'] . ' ' . $note['stagiaire_nom']); ?></td>
                                    <td><?php echo htmlspecialchars($note['nom_module']); ?></td>
                                    <td><?php echo htmlspecialchars($note['formateur_prenom'] . ' ' . $note['formateur_nom']); ?></td>
                                    <td><?php echo htmlspecialchars($note['note1']); ?></td>
                                    <td><?php echo htmlspecialchars($note['note2']); ?></td>
                                    <td><?php echo htmlspecialchars($note['note3']); ?></td>
                                    <td><?php echo htmlspecialchars($note['EFM']); ?></td>
                                    <td><?php echo htmlspecialchars($note['Moyenne']); ?></td>
                                    <td>
                                        <?php 
                                            echo $note['date_modification'] 
                                                ? date('d/m/Y H:i', strtotime($note['date_modification'])) 
                                                : '<em>Jamais modifiée</em>'; 
                                        ?>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<?php include '../includes/footer.php'; ?>
