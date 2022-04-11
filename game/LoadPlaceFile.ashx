<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
header("content-type: text/plain");
if (isset($_GET['PlaceId'])){
	$pid = $_GET['PlaceId'];
	if($pid !== null){
		$PlaceFetch = mysqli_query($MainDB, "SELECT * FROM asset WHERE approved = '1' AND id = '". $pid ."' AND itemtype = 'place'");
		if (mysqli_num_rows($PlaceFetch) > 0){
			if (file_exists($_SERVER['DOCUMENT_ROOT'] . "/asset/". $pid)){
				$data = '
game:Load("'. $baseUrl .'/asset/?id='. $pid .'")';
				openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
				echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
			}else{
				$data = 'game:SetMessage("Cannot retrieve game at this time.")';
				openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
				echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
			}
		}else{
			$data = 'game:SetMessage("Game does not exist.")';
			openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
			echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
		}
	}
}
?>
