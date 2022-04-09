<?php
header("content-type:text/plain");
$GetAllowed = array('1');
$IsAllowed = array('1');
	if (isset($_GET['method'])){
	$method = $_GET['method'];
	$pid = $_GET['playerid'];
	$groupid = $_GET['groupid'];
	
	if ($method == "GetGroupRank"){
		if (in_array($pid, $GetAllowed)){
		echo '<value type="integer">255</value>';
		}else{
		echo '<value type="integer">0</value>';
		}
	}elseif($method == "IsInGroup"){
		if(in_array($pid, $GetAllowed)){
		echo '<value type="boolean">true</value>';
		}else{
		echo '<value type="boolean">false</value>';
		}
	}
	
	}else{
	die('{"message":"Cannot process request at this time."}');
	}
?>