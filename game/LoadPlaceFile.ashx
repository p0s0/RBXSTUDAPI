<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
header("content-type: text/plain");
$pid = (int)($_GET['PlaceId'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
	switch(true){
		case ($pid):
			$PlaceFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND id = :pid AND itemtype = 'place'");
			$PlaceFetch->execute([":pid" => $pid]);
			$Results = $PlaceFetch->fetch(PDO::FETCH_ASSOC);
			switch(true){
				case($Results):
					switch (file_exists($_SERVER['DOCUMENT_ROOT'] . "/asset/". $pid)){
						 case true:
							$data = '
							game:Load("'. $baseUrl .'/asset/?id='. $pid .'")';
							openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
							echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
							break;
						 default:
							$data = '
							game:SetMessage("Cannot retrieve game at this time.")';
							openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
							echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
							break;
					}
					break;
				default:
					$data = '
					game:SetMessage("Unable to fetch game.")';
					openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
					echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
					break;
			}
			break;
		default:
			$data = '
			game:SetMessage("Cannot process request at this time.")';
			openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
			echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
			break;
	}
?>
