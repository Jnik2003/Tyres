<?php 
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

require "db.php"; // Определяем константы для подключения к БД
require "function_db.php"; // Функции для работы с БД (SELECT, DELETE и т.п.)

$search_date = $_POST['date'];

$query = "SELECT time FROM `records` WHERE date='".$search_date."'"; 
     
$result = select($query);

// echo json_encode($result, JSON_NUMERIC_CHECK);
echo json_encode($result);
?>