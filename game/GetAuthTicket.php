<?php include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); ?>
<?php
if ($RBXTICKET !== null){
	echo $name . ":" . $id . ":" . $RBXTICKET;
}else{
	echo "Guest:". rand(0,9999);
}
?>