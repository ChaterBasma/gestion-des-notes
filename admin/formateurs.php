<?php
$page_title = "Liste des Formateurs";
require_once '../config/database.php';
include '../includes/header.php';

// Requête pour récupérer les formateurs et leurs groupes
$sql = "
    SELECT f.id_formateur, f.nom AS nom_formateur, f.prenom AS prenom_formateur, f.email,
           g.id_Groupe, g.nom_Groupe
    FROM Formateur f
    LEFT JOIN formateur_groupe fg ON f.id_formateur = fg.id_formateur
    LEFT JOIN Groupe g ON fg.id_groupe = g.id_Groupe
    ORDER BY f.nom, f.prenom
";

$result = $conn->query($sql);

$formateurs = [];
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $id = $row['id_formateur'];
        if (!isset($formateurs[$id])) {
            $formateurs[$id] = [
                'nom' => $row['nom_formateur'],
                'prenom' => $row['prenom_formateur'],
                'email' => $row['email'],
                'groupes' => []
            ];
        }
        if ($row['id_Groupe']) {
            $formateurs[$id]['groupes'][] = $row['nom_Groupe'];
        }
    }
} else {
    echo "<div class='alert alert-danger'>Erreur lors de la récupération des formateurs : " . $conn->error . "</div>";
}
?>

<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">Liste des Formateurs</h1>

    <div class="card shadow mb-4">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Email</th>
                            <th>Groupes Assignés</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($formateurs as $formateur): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($formateur['nom']); ?></td>
                                <td><?php echo htmlspecialchars($formateur['prenom']); ?></td>
                                <td><?php echo htmlspecialchars($formateur['email']); ?></td>
                                <td>
                                    <?php
                                    if (!empty($formateur['groupes'])) {
                                        echo implode(', ', array_map('htmlspecialchars', $formateur['groupes']));
                                    } else {
                                        echo '<em>Aucun groupe</em>';
                                    }
                                    ?>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<?php include '../includes/footer.php'; ?>
