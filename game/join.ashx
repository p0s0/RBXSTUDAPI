<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
header("content-type:text/plain");

if (isset($_GET['username'])){
	$username = $_GET['username'];
}else{
	die('{"message":"Unauthorized request."}');
}

if (isset($_GET['capp'])){
	$app = $_GET['capp'];
}else{
	die('{"message":"Unauthorized request."}');
}

if (isset($_GET['id'])){
	$id = $_GET['id'];
}else{
	die('{"message":"Unauthorized request."}');
}

if (isset($_GET['ip'])){
	$ip = $_GET['ip'];
}else{
	die('{"message":"Unauthorized request."}');
}

if (isset($_GET['port'])){
	$port = $_GET['port'];
}else{
	die('{"message":"Unauthorized request."}');
}

ob_start();
?>

--coke's super cool joinscript have credit
nc = game:GetService("NetworkClient")
nc:PlayerConnect(<?php echo htmlspecialchars($id); ?>, "<?php echo htmlspecialchars($ip); ?>", <?php echo htmlspecialchars($port); ?>)

plr = game.Players.LocalPlayer
plr.Name = "<?php echo htmlspecialchars($username); ?>"
plr.CharacterAppearance = "<?php echo htmlspecialchars($app); ?>"

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
$data = ob_get_clean();
$signature;
openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
?>