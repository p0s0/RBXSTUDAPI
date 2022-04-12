<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
header("content-type:text/plain");
$name = ($_GET['username'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$capp = ($_GET['capp'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$ip = ($_GET['ip'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$port = (int)($_GET['port'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$id = rand(0, 4392);
ob_start();
?>

--coke's super cool joinscript have credit
nc = game:GetService("NetworkClient")
nc:PlayerConnect(<?php echo $id; ?>, "<?php echo htmlspecialchars($ip); ?>", <?php echo htmlspecialchars($port); ?>)

plr = game.Players.LocalPlayer
plr.Name = "<?php echo htmlspecialchars($name); ?>"
plr.CharacterAppearance = "<?php echo htmlspecialchars($capp); ?>"

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
