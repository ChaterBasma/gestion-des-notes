<?php
$page_title = "Tableau de bord Formateur";
require_once '../config/database.php';
include '../includes/header.php';

// Récupérer l'ID du formateur connecté
$formateur_id = $_SESSION['user_id'];

// Récupérer les statistiques
$stats = [
    'stagiaires' => 0,
    'modules' => 0,
    'notes' => 0,
    'groupes' => 0
];

// Nombre de groupes associés à ce formateur
$stmt = $conn->prepare("
    SELECT COUNT(DISTINCT id_groupe) as count
    FROM formateur_groupe
    WHERE id_formateur = ?
");
$stmt->bind_param("i", $formateur_id);
$stmt->execute();
$result = $stmt->get_result();
if ($result) {
    $stats['groupes'] = $result->fetch_assoc()['count'];
}
$stmt->close();

// Nombre de stagiaires associés à ce formateur via les groupes
$stmt = $conn->prepare("
    SELECT COUNT(DISTINCT s.id_stagiaire) as count
    FROM Stagiaire s
    JOIN formateur_groupe fg ON s.id_Groupe = fg.id_groupe
    WHERE fg.id_formateur = ?
");
$stmt->bind_param("i", $formateur_id);
$stmt->execute();
$result = $stmt->get_result();
if ($result) {
    $stats['stagiaires'] = $result->fetch_assoc()['count'];
}
$stmt->close();

// Nombre de modules enseignés par ce formateur
$stmt = $conn->prepare("
    SELECT COUNT(DISTINCT id_module) as count
    FROM Module_Filiere_Formateur
    WHERE id_formateur = ?
");
$stmt->bind_param("i", $formateur_id);
$stmt->execute();
$result = $stmt->get_result();
if ($result) {
    $stats['modules'] = $result->fetch_assoc()['count'];
}
$stmt->close();

// Nombre de notes saisies par ce formateur
$stmt = $conn->prepare("
    SELECT COUNT(*) as count
    FROM Note
    WHERE id_formateur = ?
");
$stmt->bind_param("i", $formateur_id);
$stmt->execute();
$result = $stmt->get_result();
if ($result) {
    $stats['notes'] = $result->fetch_assoc()['count'];
}
$stmt->close();

// Récupérer les dernières notes ajoutées par ce formateur
$recent_notes = [];
$stmt = $conn->prepare("
    SELECT n.id_note, s.nom as stagiaire_nom, s.prenom as stagiaire_prenom, 
           m.nom_module, n.Moyenne, n.date_creation
    FROM Note n
    JOIN Stagiaire s ON n.id_stagiaire = s.id_stagiaire
    JOIN Module m ON n.id_module = m.id_module
    WHERE n.id_formateur = ?
    ORDER BY n.date_creation DESC
    LIMIT 5
");
$stmt->bind_param("i", $formateur_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $recent_notes[] = $row;
    }
}
$stmt->close();

// Récupérer les groupes du formateur
$groupes = [];
$stmt = $conn->prepare("
    SELECT g.id_Groupe, g.nom_Groupe, COUNT(s.id_stagiaire) as nb_stagiaires
    FROM formateur_groupe fg
    JOIN Groupe g ON fg.id_groupe = g.id_Groupe
    LEFT JOIN Stagiaire s ON g.id_Groupe = s.id_Groupe
    WHERE fg.id_formateur = ?
    GROUP BY g.id_Groupe
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
    <h1 class="h3 mb-4 text-gray-800">Tableau de bord Formateur</h1>
    
    <!-- Statistiques -->
    <div class="row">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Mes Groupes</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $stats['groupes']; ?></div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-users fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Mes Stagiaires</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $stats['stagiaires']; ?></div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-user-graduate fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Mes Modules</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $stats['modules']; ?></div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-book fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Notes Saisies</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $stats['notes']; ?></div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Mes groupes -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-success">Mes Groupes</h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>Groupe</th>
                                    <th>Nombre de stagiaires</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($groupes)): ?>
                                    <tr>
                                        <td colspan="3" class="text-center">Aucun groupe trouvé</td>
                                    </tr>
                                <?php else: ?>
                                    <?php foreach ($groupes as $groupe): ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($groupe['nom_Groupe']); ?></td>
                                            <td><?php echo $groupe['nb_stagiaires']; ?></td>
                                            <td>
                                                <a href="stagiaires.php?groupe=<?php echo $groupe['id_Groupe']; ?>" class="btn btn-sm btn-success">
                                                    <i class="fas fa-users"></i> Voir les stagiaires
                                                </a>
                                                <a href="notes.php?groupe=<?php echo $groupe['id_Groupe']; ?>" class="btn btn-sm btn-info">
                                                    <i class="fas fa-clipboard-list"></i> Gérer les notes
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
        </div>
    </div>
    
    <!-- Dernières notes -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-success">Dernières notes ajoutées</h6>
                    <a href="notes.php" class="btn btn-success btn-sm">
                        <i class="fas fa-clipboard-list"></i> Gérer les notes
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>Stagiaire</th>
                                    <th>Module</th>
                                    <th>Moyenne</th>
                                    <th>Date d'ajout</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($recent_notes)): ?>
                                    <tr>
                                        <td colspan="4" class="text-center">Aucune note trouvée</td>
                                    </tr>
                                <?php else: ?>
                                    <?php foreach ($recent_notes as $note): ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($note['stagiaire_prenom'] . ' ' . $note['stagiaire_nom']); ?></td>
                                            <td><?php echo htmlspecialchars($note['nom_module']); ?></td>
                                            <td><?php echo htmlspecialchars($note['Moyenne']); ?></td>
                                            <td><?php echo date('d/m/Y H:i', strtotime($note['date_creation'])); ?></td>
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
