<?php
$page_title = "Mes Notes";
require_once '../config/database.php';
include '../includes/header.php';

// Récupérer l'ID du stagiaire connecté
$stagiaire_id = $_SESSION['user_id'];

// Récupérer toutes les notes du stagiaire
$notes = [];
$stmt = $conn->prepare("
    SELECT n.id_note, m.nom_module, f.nom as formateur_nom, f.prenom as formateur_prenom,
           n.note1, n.note2, n.note3, n.EFM, n.Moyenne, n.date_creation, n.date_modification
    FROM Note n
    JOIN Module m ON n.id_module = m.id_module
    JOIN Formateur f ON n.id_formateur = f.id_formateur
    WHERE n.id_stagiaire = ?
    ORDER BY m.nom_module
");
$stmt->bind_param("i", $stagiaire_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $notes[] = $row;
    }
}
$stmt->close();

// Calculer la moyenne générale
$moyenne_generale = 0;
$total_modules = count($notes);

if ($total_modules > 0) {
    $sum = 0;
    foreach ($notes as $note) {
        $sum += $note['Moyenne'];
    }
    $moyenne_generale = round($sum / $total_modules, 2);
}

$conn->close();
?>

<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">Mes Notes</h1>
    
    <!-- Moyenne générale -->
    <div class="row mb-4">
        <div class="col-xl-6 col-md-6">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Moyenne générale</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $moyenne_generale; ?>/20</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-chart-line fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-6 col-md-6">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Modules évalués</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $total_modules; ?></div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-book fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Liste des notes -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-success">Détail de mes notes</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
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
                                <td colspan="8" class="text-center">Aucune note trouvée</td>
                            </tr>
                        <?php else: ?>
                            <?php foreach ($notes as $note): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($note['nom_module']); ?></td>
                                    <td><?php echo htmlspecialchars($note['formateur_prenom'] . ' ' . $note['formateur_nom']); ?></td>
                                    <td><?php echo htmlspecialchars($note['note1']); ?></td>
                                    <td><?php echo htmlspecialchars($note['note2']); ?></td>
                                    <td><?php echo htmlspecialchars($note['note3']); ?></td>
                                    <td><?php echo htmlspecialchars($note['EFM']); ?></td>
                                    <td class="font-weight-bold"><?php echo htmlspecialchars($note['Moyenne']); ?></td>
                                    <td><?php echo date('d/m/Y H:i', strtotime($note['date_modification'])); ?></td>
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
