<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
header("content-type:text/plain");

$baseUrl = $_SERVER['HTTP_HOST'];
if (isset($_GET['IsPlaySolo'])){
	$is = $_GET['IsPlaySolo'];
	$UID = $_GET['UserID'];
	$PID = $_GET['PlaceID'];
	$UNIVERSE = $_GET['universeId'];
	
	if ($is == null){
	die('{"message":"Unable to process request."}');
	}
	
	if ($UID == null){
	die('{"message":"Unable to process request."}');
	}
	
	if ($PID == null){
	die('{"message":"Unable to process request."}');
	}
	
	if ($UNIVERSE == null){
	die('{"message":"Unable to process request."}');
	}
	
}else{
	die('{"message":"Unauthorized request."}');
}

ob_start();
?>

game:GetService("RunService"):Run()
local player = game:GetService("Players"):CreateLocalPlayer(<?php echo htmlspecialchars($UID); ?>)
pcall(function() player.Name = [========[Player]========] end)
player:SetSuperSafeChat(false)
pcall(function() player:SetMembershipType(Enum.MembershipType.None) end)
pcall(function() player:SetAccountAge(13) end)
player:LoadCharacter()
game:GetService("Visit"):SetUploadUrl("")
while true do 
	wait(0.001)
	if (player.Character ~= nil) then
		if (player.Character:findFirstChild("Humanoid") and (player.Character.Humanoid.Health == 0)) then
			wait(5)
			player:LoadCharacter()
		elseif (player.Character.Parent == nil) then 
			wait(5)
			player:LoadCharacter() -- to make sure nobody is deleted.
		end
	end
end
<?php
$data = ob_get_clean();
$signature;
openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
?>