<?php 
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

require "db.php"; // Определяем константы для подключения к БД
require "function_db.php"; // Функции для работы с БД (SELECT, DELETE и т.п.)

$postData = file_get_contents('php://input');
$data = json_decode($postData, true);
// var_dump ($data);

$date = $data['date'];
$time = $data['time'];
$name = $data['name'];
$phone = $data['phone'];
$email = $data['email'];

$date = trim(filter_var(htmlspecialchars($date, ENT_NOQUOTES), FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES));
$time = trim(filter_var(htmlspecialchars($time, ENT_NOQUOTES), FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES));
$name = trim(filter_var(htmlspecialchars($name, ENT_NOQUOTES), FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES));
$phone = trim(filter_var(htmlspecialchars($phone, ENT_NOQUOTES), FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES));
$email = trim(filter_var(htmlspecialchars($email, ENT_NOQUOTES), FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES));

// проверка, есть ли в бд на эту дату и время запись
$q = "SELECT * FROM `records` WHERE `date`='".$date."' AND `time` = '".$time."'";

$res = select($q);
// если нет - выполним функцию записи в бд
if(count($res) == 0){
   $query = "INSERT INTO records (date, time, name, phone, email) VALUES ('".$date."', '".$time."', '".$name."', '".$phone."', '".$email."')";

    $result = execQuery($query);
}
else{
     echo('3');
     // $result = 0;
     exit();
}

// если результат записи 1, то вернем 1 и отправим письмо  
if($result){
    echo '1';
    sendEmail($email, $date, $time);
}  
else{
    echo('2');
};


function sendEmail($email, $date, $time){
    $to = $email; // адрес получателя 
    $subject = 'Запись в шиномонтаж'; // тема письма
    $subject_from = 'Шиномонтажная №1'; // тема письма для автоответа
    $mail_from = 'kaunas16@gmail.com'; //указать доменную почту чтобы не попадать в спам 
    $headers = 'From: '. $mail_from . "\r\n"; // от кого указать доменную почту чтобы не попадать в спам 
    $headers .= 'Reply-To: '. $email ."\r\n"; // почта отправителя // email для ответа на письмо

    $message = "Вы записаны на дату ".$date." Время ".$time;
    //--------

// кодируем заголовок в UTF-8
$subject = preg_replace("/(\r\n)|(\r)|(\n)/", "", $subject);
$subject = preg_replace("/(\t)/", " ", $subject);
$subject = '=?UTF-8?B?' . base64_encode($subject) . '?=';

@mail($to, $subject, $message, $headers);


}

?>