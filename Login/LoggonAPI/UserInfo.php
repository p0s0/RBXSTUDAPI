<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
switch(true){
	case (isset($_COOKIE['ROBLOSECURITY'])):
		$RBXTICKET = $_COOKIE['ROBLOSECURITY'];
		break;
	default:
		$RBXTICKET = null;
		break;
}

switch(true){
	case ($RBXTICKET !== null):
		$GetInfo = $MainDB->prepare("SELECT id, name, ticket, robux, termtype, admin FROM users WHERE token = :token");
		$GetInfo->execute([':token' => $RBXTICKET]);
		$Info = $GetInfo->fetch(PDO::FETCH_ASSOC);
		$id = $Info['id'];
		$name = $Info['name'];
		$ticket = $Info['ticket'];
		$robux = $Info['robux'];
		$termtype = $Info['termtype'];
		$admin = $Info['admin'];
		break;
	default:
		$id = null;
		$name = null;
		$ticket = null;
		$robux = null;
		$termtype = null;
		$admin = null;
		break;
}
?>
