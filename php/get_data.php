<?php 
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

require "db.php"; // Определяем константы для подключения к БД
require "function_db.php"; // Функции для работы с БД (SELECT, DELETE и т.п.)

$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$date1 = $data['date1'];
$date2 = $data['date2'];

$query = "SELECT * FROM `records` WHERE date between '".$date1."' AND '".$date2."' ORDER BY date ASC, time ASC"; 
     
$result = select($query);

// echo json_encode($result, JSON_NUMERIC_CHECK);
echo json_encode($result);
?>