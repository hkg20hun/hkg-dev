<?php
$servername = "sql7.freesqldatabase.com";
$username = "sql7765071";
$password = "SSwMQsXZKg";
$dbname = "sql7765071";

// Kapcsolódás az adatbázishoz
$conn = new mysqli($servername, $username, $password, $dbname);

// Kapcsolat ellenőrzése
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Meghívó generálás
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $code = generateCode();

    // Meghívó hozzáadása az adatbázishoz
    $sql = "INSERT INTO invites (email, code) VALUES ('$email', '$code')";

    if ($conn->query($sql) === TRUE) {
        echo "New invite created successfully. Your code is: " . $code;
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

// Meghívó kód generálása
function generateCode() {
    return strtoupper(bin2hex(random_bytes(4))); // 8 karakteres kód
}

$conn->close();
?>