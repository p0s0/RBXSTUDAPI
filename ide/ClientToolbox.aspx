<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
//Models for Toolbox have to be:
//*Free
//*Public
//*Approved by Staff

if(isset($_GET['type'])){
	$type = $_GET['type'];
	if ($type == "Weapons"){
		$ToolboxFetch = mysqli_query($MainDB, "SELECT * FROM models WHERE approved = '1' AND public = '1' AND rsprice = '0' AND tkprice = '0' AND type = 'weapons'");
	}elseif($type == "GameStuff"){
		$ToolboxFetch = mysqli_query($MainDB, "SELECT * FROM models WHERE approved = '1' AND public = '1' AND rsprice = '0' AND tkprice = '0' AND type = 'gamestuff'");
	}else{
		$ToolboxFetch = mysqli_query($MainDB, "SELECT * FROM models WHERE approved = '1' AND public = '1' AND rsprice = '0' AND tkprice = '0'");
	}
}else{
	$ToolboxFetch = mysqli_query($MainDB, "SELECT * FROM models WHERE approved = '1' AND public = '1' AND rsprice = '0' AND tkprice = '0'");
}

$BoxRows = mysqli_num_rows($ToolboxFetch);
?>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Toolbox</title>
      <link href="<?php echo $baseUrl; ?>/CSS/Base/CSS/Toolbox.css" type="text/css" rel="stylesheet">
      <script id="Functions" type="text/jscript">
         function insertContent(id)
         {
                   try
                   {
                 window.external.Insert("<?php echo $baseUrl; ?>/asset/?id=" + id);
                   }
                   catch(x)
                   {
                       alert("Sorry, Unable to insert item.");
                   }			    
         }
         function dragRBX(id)
         {
             try
                   {
                       window.external.StartDrag("<?php echo $baseUrl; ?>/asset/?id=" + id);
                   }
                   catch(x)
                   {
                       alert("Sorry, Unable to drag item.");
                   }
         }
         function clickButton(e, buttonid)
         {
          var bt = document.getElementById(buttonid);
          if (typeof bt == 'object')
          {
           if(navigator.appName.indexOf("Netscape")>(-1))
           {
            if (e.keyCode == 13)
            {
             bt.click();
             return false;
            }
           }
           if (navigator.appName.indexOf("Microsoft Internet Explorer")>(-1))
           {
            if (event.keyCode == 13)
            {
             bt.click();
             return false;
            }
           }
          }
         }
           
      </script>
   </head>
   <body class="Page" style="margin: 0;">
      <div id="NewToolboxContainer">
         <div id="ToolboxControls">
            <div id="SetTabs">
               <a href="<?php echo $baseUrl; ?>/IDE/ClientToolbox.aspx?type=All" style="text-decoration: none;"><div id="All" class="Tabs">All</div></a>
			   <a href="<?php echo $baseUrl; ?>/IDE/ClientToolbox.aspx?type=Weapons" style="text-decoration: none;"><div id="Weapons" class="Tabs">Weapons</div></a>
			   <a href="<?php echo $baseUrl; ?>/IDE/ClientToolbox.aspx?type=GameStuff" style="text-decoration: none;"><div id="GameStuff" class="Tabs">Game Stuff</div></a>
            </div>
         </div>
         <div id="ToolBoxScrollWrapper">
            <div id="ToolboxItems">
			<?php
			if ($BoxRows > 0) {
				while($Fetch = $ToolboxFetch->fetch_assoc()){
				echo "
               <div class='ToolboxItem WithoutVoting' id='span_setitem_". $Fetch['id'] ."' ondragstart='dragRBX(". $Fetch['id'] .")'>   
				   <a href='javascript:insertContent(". $Fetch['id'] .")' class='itemLink' title='". $Fetch['name'] ."'>       
				  <img alt='". $Fetch['name'] ."' id='img_span_setitem_". $Fetch['id'] ."' width='60' height='62' src='". $baseUrl ."/Tools/Asset.ashx?id=". $Fetch['id'] ."&request=model' border='0px' onerror='return Roblox.Controls.Image.OnError(this)'>   
				   </a>
			   </div>
				";
				}
			}else{
				echo "<p style='font-family:arial;'>No models have been found.</p>";
			}
			$MainDB->close();
			?>
            </div>
         </div>
      </div>
   </body>
</html>