<?php
// Point d'entrée principal - Page de login
session_start();

// Rediriger si déjà connecté
if (isset($_SESSION['user_id'])) {
    switch ($_SESSION['user_type']) {
        case 'admin':
            header("Location: admin/dashboard.php");
            break;
        case 'formateur':
            header("Location: formateur/dashboard.php");
            break;
        case 'stagiaire':
            header("Location: stagiaire/dashboard.php");
            break;
    }
    exit;
}

// Traitement du formulaire de connexion
$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_once 'config/database.php';
    
    $email = trim($_POST['email']); //le trim pour supprimer les espaces 
    $password = $_POST['password'];
    $user_type = $_POST['user_type'];
    
    // Vérifier les identifiants selon le type d'utilisateur
    switch ($user_type) {
        case 'admin':
            $table = 'Admine';
            $id_field = 'id_Admin';
            break;
        case 'formateur':
            $table = 'Formateur';
            $id_field = 'id_formateur';
            break;
        case 'stagiaire':
            $table = 'Stagiaire';
            $id_field = 'id_stagiaire';
            break;
        default:
            $error = "Type d'utilisateur invalide";
            break;
    }
    
    if (empty($error)) {
        $stmt = $conn->prepare("SELECT $id_field, nom, prenom FROM $table WHERE email = ? AND mot_de_passe = ?");
        $stmt->bind_param("ss", $email, $password); //bind_param pour lier les vraies valeurs $email et $password aux ? de la requête."ss" est une chaîne qui indique le type de chaque paramètre
        $stmt->execute(); 
        $result = $stmt->get_result();
        
        if ($result->num_rows === 1) {
            $user = $result->fetch_assoc(); // fetch_assoc() transforme la ligne de base de données en table en php
            
            // Créer la session
            $_SESSION['user_id'] = $user[$id_field];
            $_SESSION['user_name'] = $user['prenom'] . ' ' . $user['nom'];
            $_SESSION['user_type'] = $user_type;
            
            // Rediriger vers dashboard
            header("Location: {$user_type}/dashboard.php");
            exit;
        } else {
            $error = "Email ou mot de passe incorrect";
        }
        
        $stmt->close();
    }
    
    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Système de Gestion des Notes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: white;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 30px;
    position: absolute;
    top: 0;
    width: 100%;
}

.login-container {
    max-width: 400px;
    width: 100%;
    padding: 20px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    margin-top: 100px; /* ajoute de l'espace sous le header */
}

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header h1 {
            font-size: 24px;
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .btn-login {
    width: 100%;
    padding: 10px;
    background-color: #198754; /* Vert Bootstrap */
    border: none;
    color: white; /* pour assurer la lisibilité */
}

.btn-login:hover {
    background-color: #157347; /* Vert plus foncé au survol */
}

        .error-message {
            color: #dc3545;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <header><img src="ofppt_gfogb.png" alt="Ma photo" width="140">
    <img src="Screen Shot 1446-11-23 at 22.50.15.png" alt="Ma photo" width="200">
    </header>
    <div class="login-container">
        <div class="login-header">
            <h1>Système de Gestion des Notes</h1>
            

            
        </div>
        
        <?php if (!empty($error)): ?>
    <div class="error-message"><?php echo $error; ?></div>
<?php endif; ?>

<?php if (isset($_GET['timeout'])): ?>
    <div class="error-message">Votre session a expiré pour cause d'inactivité. Veuillez vous reconnecter.</div>
<?php endif; ?>

        
        <form method="POST" action="">
            <div class="form-group">
                <label for="user_type">Type d'utilisateur</label>
                <select class="form-control" id="user_type" name="user_type" required>
                    <option value="admin">Administrateur</option>
                    <option value="formateur">Formateur</option>
                    <option value="stagiaire">Stagiaire</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password">Mot de passe</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn btn-primary btn-login">Se connecter</button>
        </form>
    </div>
    
    
</body>
</html>
