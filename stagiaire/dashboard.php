
<?php
$page_title = "Tableau de bord Stagiaire";
require_once '../config/database.php';
include '../includes/header.php';

// Récupérer l'ID du stagiaire connecté
$stagiaire_id = $_SESSION['user_id'];

// Récupérer les informations du stagiaire
$stagiaire = null;
$stmt = $conn->prepare("
    SELECT s.*, f.nom_filiere, g.nom_Groupe
    FROM Stagiaire s
    JOIN Filiere f ON s.id_Filiere = f.id_Filiere
    JOIN Groupe g ON s.id_Groupe = g.id_Groupe
    WHERE s.id_stagiaire = ?
");
$stmt->bind_param("i", $stagiaire_id);//pour lier des variable à la requête SQL préparée, permet de sécuriser les requêtes SQL et d'éviter les attaques par injection SQL
$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows > 0) {
    $stagiaire = $result->fetch_assoc();//récupérer une ligne de résultat d'une requête SQL sous forme de tableau associatif
}
$stmt->close();

// Récupérer les statistiques
$stats = [
    'modules' => 0,
    'moyenne_generale' => 0
];

// Nombre de modules avec des notes
$stmt = $conn->prepare("
    SELECT COUNT(DISTINCT id_module) as count
    FROM Note
    WHERE id_stagiaire = ?
");
$stmt->bind_param("i", $stagiaire_id);
$stmt->execute();
$result = $stmt->get_result();
if ($result) {
    $stats['modules'] = $result->fetch_assoc()['count'];
}
$stmt->close();

// Moyenne générale
$stmt = $conn->prepare("
    SELECT AVG(Moyenne) as moyenne_generale
    FROM Note
    WHERE id_stagiaire = ?
");
$stmt->bind_param("i", $stagiaire_id);
$stmt->execute();
$result = $stmt->get_result();
if ($result) {
    $row = $result->fetch_assoc();
    if ($row['moyenne_generale']) {
        $stats['moyenne_generale'] = round($row['moyenne_generale'], 2);
    } else {
        $stats['moyenne_generale'] = 0;
    }
    
}
$stmt->close();

// Récupérer les dernières notes
$recent_notes = [];
$stmt = $conn->prepare("
    SELECT n.id_note, m.nom_module, f.nom as formateur_nom, f.prenom as formateur_prenom,
           n.note1, n.note2, n.note3, n.EFM, n.Moyenne, n.date_modification
    FROM Note n
    JOIN Module m ON n.id_module = m.id_module
    JOIN Formateur f ON n.id_formateur = f.id_formateur
    WHERE n.id_stagiaire = ?
    ORDER BY n.date_modification DESC
    LIMIT 5
");
$stmt->bind_param("i", $stagiaire_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $recent_notes[] = $row;
    }
}
$stmt->close();

$conn->close();
?>

<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">Tableau de bord Stagiaire</h1>
    
    <!-- Informations du stagiaire -->
    <?php if ($stagiaire): ?>
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-success">Mes informations</h6>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Nom:</strong> <?php echo htmlspecialchars($stagiaire['prenom'] . ' ' . $stagiaire['nom']); ?></p>
                        <p><strong>Email:</strong> <?php echo htmlspecialchars($stagiaire['email']); ?></p>
                        <p><strong>Genre:</strong> <?php echo $stagiaire['genre'] === 'M' ? 'Masculin' : 'Féminin'; ?></p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Filière:</strong> <?php echo htmlspecialchars($stagiaire['nom_filiere']); ?></p>
                        <p><strong>Groupe:</strong> <?php echo htmlspecialchars($stagiaire['nom_Groupe']); ?></p>
                        <p><strong>Année d'étude:</strong> <?php echo htmlspecialchars($stagiaire['annee_etude']); ?></p>
                    </div>
                </div>
            </div>
        </div>
    <?php endif; ?>
    
    <!-- Statistiques -->
    <div class="row">
        <div class="col-xl-6 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Modules évalués</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $stats['modules']; ?></div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-book fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-6 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Moyenne générale</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $stats['moyenne_generale']; ?>/20</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-chart-line fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Dernières notes -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-success">Mes dernières notes</h6>
                    <a href="notes.php" class="btn btn-primary btn-sm">
                        <i class="fas fa-clipboard-list"></i> Voir toutes mes notes
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>Module</th>
                                    <th>Formateur</th>
                                    <th>Note 1</th>
                                    <th>Note 2</th>
                                    <th>Note 3</th>
                                    <th>EFM</th>
                                    <th>Moyenne</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($recent_notes)): ?>
                                    <tr>
                                        <td colspan="7" class="text-center">Aucune note trouvée</td>
                                    </tr>
                                <?php else: ?>
                                    <?php foreach ($recent_notes as $note): ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($note['nom_module']); ?></td>
                                            <td><?php echo htmlspecialchars($note['formateur_prenom'] . ' ' . $note['formateur_nom']); ?></td>
                                            <td><?php echo htmlspecialchars($note['note1']); ?></td>
                                            <td><?php echo htmlspecialchars($note['note2']); ?></td>
                                            <td><?php echo htmlspecialchars($note['note3']); ?></td>
                                            <td><?php echo htmlspecialchars($note['EFM']); ?></td>
                                            <td><?php echo htmlspecialchars($note['Moyenne']); ?></td>
                                        </tr>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '../includes/footer.php'; ?>
