<?php
$page_title = "Liste des Modules";
require_once '../config/database.php';
include '../includes/header.php';

// Requête pour récupérer les modules avec les formateurs associés
$query = "
    SELECT 
        m.id_module,
        m.nom_module,
        f.id_formateur,
        f.nom AS nom_formateur,
        f.prenom AS prenom_formateur
    FROM Module m
    LEFT JOIN Module_Filiere_Formateur mff ON m.id_module = mff.id_module
    LEFT JOIN Formateur f ON mff.id_formateur = f.id_formateur
    ORDER BY m.nom_module
";

$result = $conn->query($query);

// Organiser les données dans un tableau par module
$modules = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $id_module = $row['id_module'];
        if (!isset($modules[$id_module])) {
            $modules[$id_module] = [
                'nom_module' => $row['nom_module'],
                'formateurs' => [],
            ]; 
        }

        if (!empty($row['id_formateur'])) {
            $modules[$id_module]['formateurs'][] = $row['prenom_formateur'] . ' ' . $row['nom_formateur'];
        }
    }
}
?>

<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">Liste des Modules</h1>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-success">Modules et Formateurs</h6>
        </div>
        <div class="card-body">
            <?php if (empty($modules)): ?>
                <div class="alert alert-warning">Aucun module trouvé.</div>
            <?php else: ?>
                <div class="table-responsive">
                    <table class="table table-bordered" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID Module</th>
                                <th>Nom du Module</th>
                                <th>Formateurs</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($modules as $id => $module): ?>
                                <tr>
                                    <td><?= htmlspecialchars($id) ?></td>
                                    <td><?= htmlspecialchars($module['nom_module']) ?></td>
                                    <td>
                                        <?php 
                                            if (empty($module['formateurs'])) {
                                                echo "<p></p>";
                                            } else {
                                                echo implode('<br>', $module['formateurs']);
                                            }
                                        ?>
                                    </td>
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
