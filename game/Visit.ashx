<?php
	// 8:56 PM
	// 4/13/22
	// pos0
	// Game/Visit.ashx
	// Visit script for Studio
	
	// Set our header
	header("content-type:text/plain");
	// Check if everything exists
	if(!isset($_GET["IsPlaySolo"]) || !isset($_GET["UserID"]) || !isset($_GET["PlaceID"]) || !isset($_GET["universeId"])) { die(json_encode(["message" => "Cannot process the request at this time. Try again later."])); }
	// Include our config file
	include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
	// Initialize our main variables
	$GetMethod = addslashes($_GET["IsPlaySolo"]);
	$UserID = (int)addslashes($_GET["UserID"]);
	$PlaceID = (int)addslashes($_GET["PlaceID"]);
	$UniverseID = (int)addslashes($_GET["universeId"]);
	// Start the output buffer
	ob_start();
?>

game:GetService("RunService"):Run()
pcall(function() game:SetPlaceID(<?php echo $PlaceID; ?>) end)
local player = game:GetService("Players"):CreateLocalPlayer(<?php echo $UserID; ?>)
pcall(function() player.Name = "Guest " .. math.random(0, 9999) end)
player:SetSuperSafeChat(true)
pcall(function() player:SetMembershipType(Enum.MembershipType.None) end)
pcall(function() player:SetAccountAge(13) end)
player:LoadCharacter()
game:GetService("Visit"):SetUploadUrl("")

while true do 
	if player.Character ~= nil then
		if player.Character:findFirstChild("Humanoid") and player.Character.Humanoid.Health == 0 then
			wait(5)
			player:LoadCharacter()
		elseif player.Character.Parent == nil then 
			wait(5)
			player:LoadCharacter()
		end
	end
	wait(0.001)
end

<?php
	// TODO: Use a global sign() function.
	// Get our output buffer data
	$data = ob_get_clean();
	// Init our signature variable
	$signature;
	// Call openssl_sign()
	openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
	// Finally, echo out our signed file.
	die(sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data));
?>
