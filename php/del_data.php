<?php 
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

require "db.php"; // Определяем константы для подключения к БД
require "function_db.php"; // Функции для работы с БД (SELECT, DELETE и т.п.)

// echo($_POST['id']);
$id = $_POST['id'];

function delId($id){   
    $query = "DELETE FROM `records` WHERE id='".$id."'";
    return execQuery($query);
}

$result = delId($id);
// echo($result);
   
if($result){
    echo ('1');    
}  
else{
    echo('2');
};


?>