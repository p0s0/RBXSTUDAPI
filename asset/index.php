<?php
header("content-type: text/plain");
$id = (int)($_GET["id"] ?? die(json_encode(["message" => "Unable to process request."])));

switch(file_exists($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $id)){
	case true:
		$file = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $id);
		echo $file;
		break;
	default:
		header("Location: https://assetdelivery.roblox.com/v1/asset/?id=". $id ."");
		die();
		break;
}
?>
