<?php
header("content-type:text/plain");
$method = ($_GET["method"] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$pid = ($_GET['playerid'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$gid = ($_GET['groupid'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$GetAllowed = array("1", "2");
switch ($method){
	case "GetGroupRank":
		switch(true){
			case (in_array($pid, $GetAllowed)):
				echo '<value type="integer">255</value>';
				break;
			default:
				echo '<value type="integer">0</value>';
				break;
		}
		break;
	case "IsInGroup":
		switch(true){
			case (in_array($pid, $GetAllowed)):
				echo '<value type="boolean">true</value>';
				break;
			default:
				echo '<value type="boolean">false</value>';
				break;
		}
		break;
}
?>
