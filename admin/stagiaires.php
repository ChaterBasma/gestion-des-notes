<?php
$page_title = "Liste des Stagiaires par Groupe";
require_once '../config/database.php';
include '../includes/header.php';

$selectedGroup = isset($_GET['groupe']) ? intval($_GET['groupe']) : 0;

// Récupérer tous les groupes
$groupes = [];
$resGroupes = $conn->query("SELECT id_Groupe, nom_Groupe FROM Groupe ORDER BY nom_Groupe");
if ($resGroupes && $resGroupes->num_rows > 0) {
    while ($g = $resGroupes->fetch_assoc()) {
        $groupes[] = $g;
    }
}

// Récupérer les stagiaires (filtrés si un groupe est sélectionné)
$query = "
    SELECT 
        s.id_stagiaire,
        s.nom,
        s.prenom,
        s.genre,
        s.date_naissance,
        s.annee_etude,
        s.email,
        f.nom_filiere,
        g.nom_Groupe
    FROM Stagiaire s
    LEFT JOIN Filiere f ON s.id_Filiere = f.id_Filiere
    LEFT JOIN Groupe g ON s.id_Groupe = g.id_Groupe
";

if ($selectedGroup > 0) {
    $query .= " WHERE s.id_Groupe = $selectedGroup";
}
$query .= " ORDER BY s.nom, s.prenom";

$result = $conn->query($query);
$stagiaires = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $stagiaires[] = $row;
    }
}
?>

<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">Liste des Stagiaires</h1>

    <!-- Filtres de groupe -->
    <div class="mb-3">
        <a href="stagiaires.php" class="btn btn-secondary btn-sm <?= $selectedGroup == 0 ? 'active' : '' ?>">Tous les groupes</a>
        <?php foreach ($groupes as $groupe): ?>
            <a href="stagiaires.php?groupe=<?= $groupe['id_Groupe'] ?>"
               class="btn btn-outline-primary btn-sm <?= $selectedGroup == $groupe['id_Groupe'] ? 'active' : '' ?>">
                <?= htmlspecialchars($groupe['nom_Groupe']) ?>
            </a>
        <?php endforeach; ?>
    </div>
    
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-success">
                <?= $selectedGroup > 0 ? 'Stagiaires du groupe ' . htmlspecialchars($stagiaires[0]['nom_Groupe'] ?? '') : 'Tous les stagiaires' ?>
            </h6>
        </div>
        <div class="card-body">
            <?php if (empty($stagiaires)): ?>
                <div class="alert alert-warning">Aucun stagiaire trouvé pour ce groupe.</div>
            <?php else: ?>
                <div class="table-responsive">
                    <table class="table table-bordered" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Prénom</th>
                                <th>Genre</th>
                                <th>Date de Naissance</th>
                                <th>Année d'Étude</th>
                                <th>Email</th>
                                <th>Filière</th>
                                <th>Groupe</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($stagiaires as $stagiaire): ?>
                                <tr>
                                    <td><?= htmlspecialchars($stagiaire['nom']) ?></td>
                                    <td><?= htmlspecialchars($stagiaire['prenom']) ?></td>
                                    <td><?= $stagiaire['genre'] === 'F' ? 'Femme' : 'Homme' ?></td>
                                    <td><?= date('d/m/Y', strtotime($stagiaire['date_naissance'])) ?></td>
                                    <td><?= htmlspecialchars($stagiaire['annee_etude']) ?></td>
                                    <td><?= htmlspecialchars($stagiaire['email']) ?></td>
                                    <td><?= htmlspecialchars($stagiaire['nom_filiere']) ?></td>
                                    <td><?= htmlspecialchars($stagiaire['nom_Groupe']) ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            <?php endif; ?>
        </div>
    </div>
</div>

<?php include '../includes/footer.php'; ?>
