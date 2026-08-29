<?php
// Déconnexion
session_start();
session_destroy();//Elle supprime toutes les données de session côté serveur
header("Location: index.php");
exit;
