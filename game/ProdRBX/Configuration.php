<?php
$baseUrl = "http://".$_SERVER['SERVER_NAME'];

$PrivKey = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/game/ProdRBX/ProdKeyRBX/ProdKey.pem");

$hostdb = "localhost";
$accdb = "root";
$passdb = "dwj]ik62Cg98Tj8H";
$namedb = "prodrbx";

$MainDB = mysqli_connect($hostdb, $accdb, $passdb, $namedb) or die('{"errors":[{"code":"500","message":"An Internal Server Error occurred."}]}');

//header('Location: ' . $baseUrl . '/IDE/Maintenance.ashx');
//die();
?>