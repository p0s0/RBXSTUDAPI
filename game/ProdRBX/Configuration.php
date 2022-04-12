<?php
$baseUrl = "http://".$_SERVER['SERVER_NAME'];

$PrivKey = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/game/ProdRBX/ProdKeyRBX/ProdKey.pem");

$hostdb = "localhost";
$accdb = "root";
$passdb = "dwj]ik62Cg98Tj8H";
$namedb = "prodrbx";

$MainDB = new PDO("mysql:host=$hostdb;dbname=$namedb", $accdb, $passdb);

//header('Location: ' . $baseUrl . '/IDE/Maintenance.ashx');
//die();
?>
