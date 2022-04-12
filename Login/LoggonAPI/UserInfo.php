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
		$id = ($Info['id'] ?? null);
		$name = ($Info['name'] ?? null);
		$ticket = ($Info['ticket'] ?? null);
		$robux = ($Info['robux'] ?? null);
		$termtype = ($Info['termtype'] ?? null);
		$admin = ($Info['admin'] ?? null);
		break;
	default:
		$id = null;
		$name = null;
		$robux = null;
		$ticket = null;
		$termtype = null;
		$admin = null;
		break;
}
?>
