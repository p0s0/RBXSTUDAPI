<?php
	// 9:05 PM
	// 4/13/22
	// pos0
	// IDE/ClientToolbox.aspx
	// The toolbox. That's all it is
	
	// Models for Toolbox have to be:
	// *Free
	// *Public
	// *Approved by Staff
	
	
	// Include our config file
	include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
	
	// Initialize the main genre variable
	$genre = (addslashes($_GET["genre"]) ?? null);
	
	// Switch case to determine the genre and to determine what to do
	switch($genre) {
		// If our genre is GameStuff, then:
		case "GameStuff":
			$ToolboxFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND rsprice = '0' AND tkprice = '0' AND genre = 'GameStuff' AND itemtype = 'model'");
			$ToolboxFetch->execute();
			break;
		// Otherwise, if our genre is Weapons, then:
		case "Weapons":
			$ToolboxFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND rsprice = '0' AND tkprice = '0' AND genre = 'Weapons' AND itemtype = 'model'");
			$ToolboxFetch->execute();
			break;
		// In any other case:
		default:
			$ToolboxFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND rsprice = '0' AND tkprice = '0' AND itemtype = 'model'");
			$ToolboxFetch->execute();
			break;
	}
	
	// Define our BoxRows variable
	$BoxRows = $ToolboxFetch->fetchAll();
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
               <a href="<?php echo $baseUrl; ?>/IDE/ClientToolbox.aspx" style="text-decoration: none;"><div id="All" class="Tabs">All</div></a>
			   <a href="<?php echo $baseUrl; ?>/IDE/ClientToolbox.aspx?genre=Weapons" style="text-decoration: none;"><div id="Weapons" class="Tabs">Weapons</div></a>
			   <a href="<?php echo $baseUrl; ?>/IDE/ClientToolbox.aspx?genre=GameStuff" style="text-decoration: none;"><div id="GameStuff" class="Tabs">Game Stuff</div></a>
            </div>
         </div>
         <div id="ToolBoxScrollWrapper">
            <div id="ToolboxItems">
			<?php
				// Switch case for determining whether $BoxRows exists
				switch(true) {
					// If it does, then:
					case ($BoxRows):
						// Loop through BoxRows, and insert a Box inside of the ToolboxItems div for each item.
						foreach($BoxRows as $Fetch) {
							echo "
						   <div class='ToolboxItem WithoutVoting' id='span_setitem_". $Fetch['id'] ."' ondragstart='dragRBX(". $Fetch['id'] .")'>   
							   <a href='javascript:insertContent(". $Fetch['id'] .")' class='itemLink' title='". $Fetch['name'] ."'>       
							  <img alt='". $Fetch['name'] ."' id='img_span_setitem_". $Fetch['id'] ."' width='60' height='62' src='". $baseUrl ."/Tools/Asset.ashx?id=". $Fetch['id'] ."&request=model' border='0px' onerror='return Roblox.Controls.Image.OnError(this)'>   
							   </a>
						   </div>
							";
						}
						
						break;
					// Otherwise, if it doesn't exist, then:
					default:
						echo "<p align='center' style='font-family:arial;'>There are no models.</p>";
						break;
				}
			?>
            </div>
         </div>
      </div>
   </body>
</html>
