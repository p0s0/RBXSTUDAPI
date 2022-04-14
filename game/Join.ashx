<?php
	// 8:45 PM
	// 4/13/22
	// pos0
	// Game/Join.ashx
	// Join script for the thing yes Funny

	// Set our header
	header("Content-Type: text/plain");
	// Check if everything exists
	if(!isset($_GET["username"]) || !isset($_GET["capp"]) || !isset($_GET["ip"]) || !isset($_GET["port"])) { die(json_encode(["message" => "Cannot process the request at this time. Try again later."])); }
	// Include our config file
	include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
	// Initialize our main variables
	$name = addslashes($_GET["username"]);
	$capp = addslashes($_GET["capp"]);
	$ip = addslashes($_GET["ip"]);
	$port = (int)addslashes($_GET["port"]);
	// Set the id to a random number between 0 and 4392
	// TODO: Make this user-defined? Review
	$id = rand(0, 4392);
	// Start the output buffer
	ob_start();
?>

-- coke's super cool joinscript have credit
local nc = game:GetService("NetworkClient")
nc:PlayerConnect(<?php echo $id; ?>, "<?php echo $ip; ?>", <?php echo $port; ?>)

local plr = game.Players.LocalPlayer
plr.Name = "<?php echo $name; ?>"
plr.CharacterAppearance = "<?php echo $capp; ?>"

game:GetService("Visit"):SetUploadUrl("")
game.Players:SetChatStyle("ClassicAndBubble")

nc.ConnectionAccepted:connect(function(peer, repl)
    game:SetMessageBrickCount()
    
    local mkr = repl:SendMarker()
    mkr.Received:connect(function()
        game:SetMessage("Requesting Character...")
        repl:RequestCharacter()
        
        game:SetMessage("Waiting for character...")
        --because a while loop didnt work
        chngd = plr.Changed:connect(function(prop)
            if prop == "Character" then chngd:disconnect() end
        end)
        game:ClearMessage()
    end)
    
    repl.Disconnection:connect(function()
        game:SetMessage("This game has shut down")
    end)
end)

nc.ConnectionFailed:connect(function() game:SetMessage("Failed to connect to the game ID: 15") end)
nc.ConnectionRejected:connect(function() game:SetMessage("Failed to connect to the game (Connection Rejected)") end)

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
