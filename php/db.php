<?php
define('SERVER', 'localhost');
// define('SERVER', 'localhost');
define('USER', 'pnikitinas_tires');
// define('USER', 'root');
define('PASSWORD', 'naHCcu80');
// define('PASSWORD', 'root');
define('DB', 'pnikitinas_tires');
// define('DB', 'tires');

$conn = connect();

function connect()
{
    $conn = mysqli_connect(SERVER, USER, PASSWORD, DB);
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }
    mysqli_set_charset($conn, "utf8");
    return $conn;
}

?>