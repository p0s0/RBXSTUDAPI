<?php
	// pos0
	// 8:25 PM
	// 4/13/22
	// /Game/LoadPlaceInfo.ashx
	// Loads place info for a place

	// Init our header
	header("content-type:text/plain");
	// Include our ProdRBX config
	include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
	// Init our PlaceId variable.
	$PlaceId = (int)(addslashes($_GET['PlaceId']) ?? die(json_encode(["message" => "Cannot process the request at this time. Try again later."])));
	ob_start();
?>

local baseUrl = <?php echo $baseUrl; ?>

-- Loaded by StartGameSharedScript --
pcall(function() game:SetCreatorID(0, Enum.CreatorType.User) end)

pcall(function() game:GetService("SocialService"):SetFriendUrl(baseUrl .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=IsFriendsWith&playerid=%d&userid=%d") end)
pcall(function() game:GetService("SocialService"):SetBestFriendUrl(baseUrl .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=IsBestFriendsWith&playerid=%d&userid=%d") end)
pcall(function() game:GetService("SocialService"):SetGroupUrl(baseUrl .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=IsInGroup&playerid=%d&groupid=%d") end)
pcall(function() game:GetService("SocialService"):SetGroupRankUrl(baseUrl .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=GetGroupRank&playerid=%d&groupid=%d") end)
pcall(function() game:GetService("SocialService"):SetGroupRoleUrl(baseUrl .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=GetGroupRole&playerid=%d&groupid=%d") end)
pcall(function() game:GetService("GamePassService"):SetPlayerHasPassUrl(baseUrl .. "/Game/GamePass/GamePassHandler.ashx?Action=HasPass&UserID=%d&PassID=%d") end)
pcall(function() game:GetService("MarketplaceService"):SetProductInfoUrl(baseUrl .. "/marketplace/productinfo?assetId=%d") end)
pcall(function() game:GetService("MarketplaceService"):SetDevProductInfoUrl(baseUrl .. "/marketplace/productDetails?productId=%d") end)
pcall(function() game:GetService("MarketplaceService"):SetPlayerOwnsAssetUrl(baseUrl .. "/ownership/hasasset?userId=%d&assetId=%d") end)
pcall(function() game:SetPlaceVersion(0) end)
pcall(function() game:SetVIPServerOwnerId(0) end)
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
