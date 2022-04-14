<?php
	// pos0
	// 8:05 PM
	// 4/13/22
	// /Game/LoadPlaceFile.ashx
	// Loads the place file

	// Set the header
	header("content-type: text/plain");
	// Include our ProdRBX config
	include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
	// This function signs the script, with $data being the data that is being signed.
	function sign($data = "game:SetMessage(\"Cannot process the request at this time. Try again later.\")") {
		echo "\n";
		openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
		echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
	}
	// Init our placeId variable.
	$pid = (int)(addslashes($_GET['PlaceId']) ?? die(json_encode(["message" => "Cannot process the request at this time. Try again later."])));
	// Switch case to determine whether or not $pid exists
	switch(true) {
		// If it does exist, let's get our place info from the DB
		case($pid):
			// Initialize our request to the DB
			$PlaceFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND id = :pid AND itemtype = 'place'");
			// Execute our request
			$PlaceFetch->execute([":pid" => $pid]);
			// Fetch our results using PDO::FETCH_ASSOC
			$Results = $PlaceFetch->fetch(PDO::FETCH_ASSOC);
			// Switch case to determine whether or not $Results exists
			switch(true){
				// If it does exist, let's check if the file exists on the server before we continue.
				case($Results):
					// Switch case to determine whether or not the /asset/ file exists on the server.
					switch (file_exists($_SERVER['DOCUMENT_ROOT'] . "/asset/". $pid)){
						// If it does, let's sign out with DataModel:Load("asset").
						 case true:
							sign(sprintf("game:Load(\"%s/asset/?id=\")"), $baseUrl, $pid);
							break;
						// If not, however, let's sign out with a generic error message.
						 default:
							sign("game:SetMessage(\"Cannot retrieve game at this time.\")")
							break;
					}
					break;
				// If not, however, let's sign out with another generic error message.
				default:
					sign("game:SetMessage(\"Unable to fetch game.\")");
					break;
			}
			break;
		// If not, let's sign out with yet another generic error message.
		default:
			sign(); // We don't need to have an arg here.
			break;
	}
?>
