<?php
$page_title = "Mes Stagiaires";
require_once '../config/database.php';
include '../includes/header.php';

// Récupérer l'ID du formateur connecté
$formateur_id = $_SESSION['user_id'];

// Filtrer par groupe si spécifié
$groupe_id = isset($_GET['groupe']) ? intval($_GET['groupe']) : null;

// Récupérer les stagiaires associés à ce formateur via les groupes
$stagiaires = [];
$query = "
    SELECT s.id_stagiaire, s.nom, s.prenom, s.genre, s.date_naissance, s.annee_etude, 
           s.email, f.nom_filiere, g.nom_Groupe
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

$query .= " ORDER BY s.nom, s.prenom";
$stmt->execute();
$result = $stmt->get_result();

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $stagiaires[] = $row;
    }
}
$stmt->close();

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
    <h1 class="h3 mb-4 text-gray-800">Mes Stagiaires</h1>
    
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
                    <a href="stagiaires.php" class="btn btn-secondary ml-2">Réinitialiser</a>
                <?php endif; ?>
            </form>
        </div>
    </div>
    
    <!-- Liste des stagiaires -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-success">Liste des Stagiaires</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Genre</th>
                            <th>Date de naissance</th>
                            <th>Année d'étude</th>
                            <th>Email</th>
                            <th>Filière</th>
                            <th>Groupe</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($stagiaires)): ?>
                            <tr>
                                <td colspan="9" class="text-center">Aucun stagiaire trouvé</td>
                            </tr>
                        <?php else: ?>
                            <?php foreach ($stagiaires as $stagiaire): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($stagiaire['nom']); ?></td>
                                    <td><?php echo htmlspecialchars($stagiaire['prenom']); ?></td>
                                    <td><?php echo $stagiaire['genre'] === 'M' ? 'Masculin' : 'Féminin'; ?></td>
                                    <td><?php echo date('d/m/Y', strtotime($stagiaire['date_naissance'])); ?></td>
                                    <td><?php echo htmlspecialchars($stagiaire['annee_etude']); ?></td>
                                    <td><?php echo htmlspecialchars($stagiaire['email']); ?></td>
                                    <td><?php echo htmlspecialchars($stagiaire['nom_filiere']); ?></td>
                                    <td><?php echo htmlspecialchars($stagiaire['nom_Groupe']); ?></td>
                                    <td>
                                        <a href="notes.php?stagiaire=<?php echo $stagiaire['id_stagiaire']; ?>" class="btn btn-sm btn-primary">
                                            <i class="fas fa-clipboard-list"></i> Notes
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

<?php include '../includes/footer.php'; ?>
