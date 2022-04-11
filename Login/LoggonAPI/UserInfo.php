<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
if (isset($_COOKIE['ROBLOSECURITY'])) {
	$RBXTICKET = $_COOKIE['ROBLOSECURITY'];
} else {
	$RBXTICKET = null;
}

if ($RBXTICKET !== null) {
	$GetInfo = $MainDB->prepare("SELECT id, name, ticket, robux, termtype, admin FROM users WHERE token = ?");
	$GetInfo->bind_param("s", $RBXTICKET);
	$GetInfo->execute();
	$GetInfo->bind_result($id, $name, $ticket, $robux, $terminated, $admin);
	$GetInfo->fetch();
	$GetInfo->close();
}else{
	$id = null;
	$name = null;
	$ticket = null;
	$robux = null;
	$terminated = null;
	$admin = null;
}
?>
