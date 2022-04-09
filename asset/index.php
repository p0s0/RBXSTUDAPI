<?php
header("content-type: text/plain");
if(isset($_GET['id'])){
	$id = $_GET["id"];
	if (file_exists($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $id)){
		$file = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $id);
		echo $file;
	}else{
		header("Location: https://assetdelivery.roblox.com/v1/asset/?id=". $id ."");
		die();
	}
}else{
	die('{"message":"Unable to process request."}');
}
?>