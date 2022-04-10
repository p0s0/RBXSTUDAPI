<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
header('Content-type:image/png');
$errimg = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Images/IDE/not-approved.png");
$penimg = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Images/IDE/pending.png");
if (isset($_GET['request'])){
	$request = $_GET['request'];
	$id = $_GET['id'];
	if ($request !== "avatar"){
		$ModelFetch = mysqli_query($MainDB, "SELECT * FROM asset WHERE approved = '1' AND id = '". $id ."' AND itemtype = '". $request ."'");
		if (mysqli_num_rows($ModelFetch) > 0){
			if (file_exists($_SERVER['DOCUMENT_ROOT'] . "/Tools/UserCreatedImages/". $id .".png")){
				echo file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Tools/UserCreatedImages/". $id .".png");
			}else{
				echo $penimg;
			}
		}else{
			echo $errimg;
		}
	}else{
		$AvatarFetch = mysqli_query($MainDB, "SELECT * FROM users WHERE id = '". $id ."'");
		if (mysqli_num_rows($AvatarFetch) > 0){
			if (file_exists($_SERVER['DOCUMENT_ROOT'] . "/Tools/Avatar/". $id .".png")){
				echo file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Tools/Avatar/". $id .".png");
			}else{
				echo $penimg;
			}
		}else{
			echo $errimg;
		}
	}
}else{
	die();
}
$MainDB->close();
?>