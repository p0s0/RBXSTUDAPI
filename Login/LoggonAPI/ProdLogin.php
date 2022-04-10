<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
session_start();
$errors = array();
$date = date("Y-m-d");

if (isset($_POST['loginrbx'])) {
	$username = mysqli_real_escape_string($MainDB, strip_tags($_POST['username']));
	$password = mysqli_real_escape_string($MainDB, strip_tags($_POST['password']));
	
	if (empty($username)) {array_push($errors, "Username box is empty.");}
	if (empty($password)) {array_push($errors, "Password box is empty.");}
	if (preg_match('/^[a-z0-9_]+$/i', $username) == 0) {array_push($errors, "User does not exist.");}
	if (preg_match('/^[a-z0-9_]+$/i', $password) == 0) {array_push($errors, "User does not exist.");}
	
    $loggon = $MainDB->prepare("SELECT password, token FROM users WHERE name=?");
    $loggon->bind_param("s", $username);
    $loggon->execute();
    $loggon->bind_result($checkpsw, $token);
    $loggon->fetch();
    
	if (count($errors) == 0) {  
		if (!empty($checkpsw)){
			if(password_verify($password,$checkpsw)){
				setcookie("ROBLOSECURITY", $token, time()+9900, "/", $_SERVER['SERVER_NAME']);
				header("Refresh:0");
			}else{
			array_push($errors, "The password is not right.");
			}
		}else{
		array_push($errors, "User does not exist.");
		}
	}
}
?>