<?php
// Vérifier si l'utilisateur est connecté
session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: ../index.php");
    exit;
}

// Vérifier si l'utilisateur a accès à cette section 
$current_dir = basename(dirname($_SERVER['PHP_SELF']));//$_SERVER['PHP_SELF']:chemin relatif du script en cours d'exécution 
if ($_SESSION['user_type'] !== $current_dir) {
    header("Location: ../{$_SESSION['user_type']}/dashboard.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $page_title ?? 'Système de Gestion des Notes'; ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .sidebar {
    min-height: 100vh;
    background-color: #28a745; /* ← vert bootstrap */
    color: white;
}

        .sidebar a {
            color: rgba(255, 255, 255, 0.8);
            padding: 10px 15px;
            text-decoration: none;
            display: block;
        }
        .sidebar a:hover {
            color: white;
            background-color: rgba(255, 255, 255, 0.1);
        }
        .sidebar .active {
            color: white;
            font-weight: bold;
            background-color: rgba(255, 255, 255, 0.2);
        }
        .content {
            padding: 20px;
        }
        .navbar {
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .user-info {
            display: flex;
            align-items: center;
        }
        .user-info .user-name {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 p-0 sidebar">
                <div class="text-center py-4">
                    <h4>Gestion des Notes</h4>
                </div>
                <hr class="bg-light">
                <div class="nav flex-column">
                    <?php if ($_SESSION['user_type'] === 'admin'): ?>
                        <a href="dashboard.php" class="<?php echo basename($_SERVER['PHP_SELF']) === 'dashboard.php' ? 'active' : ''; ?>">
                            <i class="fas fa-tachometer-alt me-2"></i> Tableau de bord
                        </a>
                        <a href="formateurs.php" class="<?php echo basename($_SERVER['PHP_SELF']) === 'formateurs.php' ? 'active' : ''; ?>">
                            <i class="fas fa-chalkboard-teacher me-2"></i> Formateurs
                        </a>
                        <a href="stagiaires.php" class="<?php echo basename($_SERVER['PHP_SELF']) === 'stagiaires.php' ? 'active' : ''; ?>">
                            <i class="fas fa-user-graduate me-2"></i> Stagiaires
                        </a>
                        <a href="modules.php" class="<?php echo basename($_SERVER['PHP_SELF']) === 'modules.php' ? 'active' : ''; ?>">
                            <i class="fas fa-book me-2"></i> Modules
                        </a>
                        <a href="notes.php" class="<?php echo basename($_SERVER['PHP_SELF']) === 'notes.php' ? 'active' : ''; ?>">
                            <i class="fas fa-clipboard-list me-2"></i> Notes
                        </a>
                    <?php elseif ($_SESSION['user_type'] === 'formateur'): ?>
                        <a href="dashboard.php" class="<?php echo basename($_SERVER['PHP_SELF']) === 'dashboard.php' ? 'active' : ''; ?>">
                            <i class="fas fa-tachometer-alt me-2"></i> Tableau de bord
                        </a>
                        <a href="stagiaires.php" class="<?php echo basename($_SERVER['PHP_SELF']) === 'stagiaires.php' ? 'active' : ''; ?>">
                            <i class="fas fa-user-graduate me-2"></i> Mes Stagiaires
                        </a>
                        <a href="notes.php" class="<?php echo basename($_SERVER['PHP_SELF']) === 'notes.php' ? 'active' : ''; ?>">
                            <i class="fas fa-clipboard-list me-2"></i> Gestion des Notes
                        </a>
                    <?php elseif ($_SESSION['user_type'] === 'stagiaire'): ?>
                        <a href="dashboard.php" class="<?php echo basename($_SERVER['PHP_SELF']) === 'dashboard.php' ? 'active' : ''; ?>">
                            <i class="fas fa-tachometer-alt me-2"></i> Tableau de bord
                        </a>
                        <a href="notes.php" class="<?php echo basename($_SERVER['PHP_SELF']) === 'notes.php' ? 'active' : ''; ?>">
                            <i class="fas fa-clipboard-list me-2"></i> Mes Notes
                        </a>
                    <?php endif; ?>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-10 p-0">
                <!-- Top Navbar -->
                <nav class="navbar navbar-expand navbar-light">
                    <div class="container-fluid">
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav ms-auto">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                        <div class="user-info">
                                            <span class="user-name"><?php echo htmlspecialchars($_SESSION['user_name']); ?></span>
                                            <i class="fas fa-user-circle fa-fw"></i>
                                        </div>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                       
                                        <li><a class="dropdown-item" href="../logout.php">Déconnexion</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                
                <!-- Page Content -->
                <div class="content">
                    
