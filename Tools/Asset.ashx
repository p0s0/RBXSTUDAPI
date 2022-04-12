<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
header('Content-type:image/png');
$errimg = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Images/IDE/not-approved.png");
$penimg = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Images/IDE/pending.png");
$request = ($_GET['request'] ?? die(json_encode(["message" => "Unable to process request."])));
$id = (int)($_GET['id'] ?? die(json_encode(["message" => "Cannot process request at this time."])));

switch($request){
	case "place":
		$AssetFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND id = :id AND itemtype = :request");
		$AssetFetch->execute([':id' => $id,':request' => $request]);
		$results = $AssetFetch->fetch(PDO::FETCH_ASSOC);
		
		switch($results){
			case ($results):
				switch (file_exists($_SERVER['DOCUMENT_ROOT'] . "/Tools/PlaceUserCreated/". $id .".png")){
					case true:
						echo file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Tools/PlaceUserCreated/". $id .".png");
						break;
					default:
						echo $penimg;
						break;
				}
				break;
			default:
				echo $errimg;
				break;
		}
		$AssetFetch->close();
		break;
	case "avatar":
		$AssetFetch = $MainDB->prepare("SELECT * FROM users WHERE id = :id");
		$AssetFetch->execute([':id' => $id]);
		$results = $AssetFetch->fetch(PDO::FETCH_ASSOC);
		
		switch($results){
			case ($results):
				switch (file_exists($_SERVER['DOCUMENT_ROOT'] . "/Tools/UserRendered/". $id .".png")){
					case true:
						echo file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Tools/UserRendered/". $id .".png");
						break;
					default:
						echo $penimg;
						break;
				}
				break;
			default:
				echo $errimg;
				break;
		}
		$AssetFetch->close();
		break;
	case "model":
		$AssetFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND id = :id AND itemtype = :request");
		$AssetFetch->execute([':id' => $id,':request' => $request]);
		$results = $AssetFetch->fetch(PDO::FETCH_ASSOC);
		
		switch($results){
			case ($results):
				switch (file_exists($_SERVER['DOCUMENT_ROOT'] . "/Tools/ModelUserCreated/". $id .".png")){
					case true:
						echo file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Tools/ModelUserCreated/". $id .".png");
						break;
					default:
						echo $penimg;
						break;
				}
				break;
			default:
				echo $errimg;
				break;
		}
		$AssetFetch->close();
		break;
	default:
		echo $errimg;
		break;
}
?>
