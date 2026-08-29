<?php
$page_title = "Tableau de bord Admin";
require_once '../config/database.php';
include '../includes/header.php';

// Récupérer les statistiques
$stats = [
    'formateurs' => 0,
    'stagiaires' => 0,
    'modules' => 0,
    'notes' => 0
];

// Nombre de formateurs
$result = $conn->query("SELECT COUNT(*) as count FROM Formateur");
if ($result) {
    $stats['formateurs'] = $result->fetch_assoc()['count'];
}

// Nombre de stagiaires
$result = $conn->query("SELECT COUNT(*) as count FROM Stagiaire");
if ($result) {
    $stats['stagiaires'] = $result->fetch_assoc()['count'];
}

// Nombre de modules
$result = $conn->query("SELECT COUNT(*) as count FROM Module");
if ($result) {
    $stats['modules'] = $result->fetch_assoc()['count'];
}

// Nombre de notes
$result = $conn->query("SELECT COUNT(*) as count FROM Note");
if ($result) {
    $stats['notes'] = $result->fetch_assoc()['count'];
}

// Récupérer les dernières notes ajoutées
$recent_notes = [];
$result = $conn->query("
    SELECT n.id_note, s.nom as stagiaire_nom, s.prenom as stagiaire_prenom, 
           m.nom_module, n.Moyenne, n.date_creation
    FROM Note n
    JOIN Stagiaire s ON n.id_stagiaire = s.id_stagiaire
    JOIN Module m ON n.id_module = m.id_module
    ORDER BY n.date_creation DESC
    LIMIT 5
");

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $recent_notes[] = $row;
    }
}

$conn->close();


?>

<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">Tableau de bord Administrateur</h1>
    
    <!-- Statistiques -->
    <div class="row">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Formateurs</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $stats['formateurs']; ?></div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-chalkboard-teacher fa-2x text-gray-300"></i>
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
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Stagiaires</div>
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
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Modules</div>
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
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Notes</div>
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
    
    <!-- Dernières notes -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-success">Dernières notes ajoutées</h6>
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
