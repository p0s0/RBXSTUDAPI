<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
session_start();
$errors = array();
$date = date("Y-m-d");

switch(true){
	case (isset($_POST['loginrbx'])):
		$username = strip_tags($_POST['username']);
		$password = strip_tags($_POST['password']);
		
		switch(true){case (empty($username)):array_push($errors, "Username box is empty.");break;}
		switch(true){case (empty($username)):array_push($errors, "Password box is empty.");break;}
		switch(true){case (preg_match('/^[a-z0-9_]+$/i', $username) == 0):array_push($errors, "User does not exist.");break;}
		switch(true){case (preg_match('/^[a-z0-9_]+$/i', $password) == 0):array_push($errors, "User does not exist.");break;}

		$loggon = $MainDB->prepare("SELECT password, token FROM users WHERE name = :username");
		$loggon->execute([':username' => $username]);
		$results = $loggon->fetch(PDO::FETCH_ASSOC);
		$checkpsw = $results['password'];
		$token = $results['token'];
		
		switch(true){
			case (count($errors) == 0):
				switch(true){
					case (!empty($checkpsw)):
						switch(true){
							case (password_verify($password,$checkpsw)):
								setcookie("ROBLOSECURITY", $token, time()+9900, "/", $_SERVER['SERVER_NAME']);
								header("Refresh:0");
								break;
							default:
								array_push($errors, "Your password is incorrect.");
								break;
						}
						break;
					default:
						array_push($errors, "This account does not exist.");
						break;
				}
				break;
		}
		break;
}
?>
