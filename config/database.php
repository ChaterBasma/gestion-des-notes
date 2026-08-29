<?php
// Configuration de la base de données
$host = 'localhost';
$username = 'root';
$password = ''; 
$database = 'gestion_notesP';

// Créer la connexion
$conn = new mysqli($host, $username, $password, $database);

// Vérifier la connexion
if ($conn->connect_error) {
    die("Échec de la connexion à la base de données: " . $conn->connect_error);
}



