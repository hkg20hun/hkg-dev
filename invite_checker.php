?php
$servername = "sql7.freesqldatabase.com";
$username = "sql7765071";
$password = "SSwMQsXZKg";
$dbname = "sql7765071";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $code = $_POST['code'];

    $sql = "SELECT * FROM invites WHERE code = '$code' AND status = 'unused'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Meghívó megtalálva és érvényes
        $sql = "UPDATE invites SET status = 'used' WHERE code = '$code'";
        if ($conn->query($sql) === TRUE) {
            echo "Meghívó aktiválva!";
        } else {
            echo "Hiba történt a meghívó aktiválásakor.";
        }
    } else {
        echo "Érvénytelen vagy már felhasznált kód.";
    }
}

$conn->close();
?>

<form action="activate_invite.php" method="POST">
    <label for="code">Meghívó kód:</label>
    <input type="text" id="code" name="code" required>
    <button type="submit">Aktiválás</button>
</form>