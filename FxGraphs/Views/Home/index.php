<?php /* index.php ( lilURL implementation ) */

require_once 'includes/conf.php'; // <- site-specific settings
require_once 'includes/hjurl.php'; // <- lilURL class file

$lilurl = new lilURL();
$msg = '';

// if the form has been submitted
if ( isset($_POST['longurl']) )
{
	// escape bad characters from the user's url
	$longurl = trim(mysql_escape_string($_POST['longurl']));

	// set the protocol to not ok by default
	$protocol_ok = false;
	
	// if there's a list of allowed protocols, 
	// check to make sure that the user's url uses one of them
	if ( count($allowed_protocols) )
	{
		foreach ( $allowed_protocols as $ap )
		{
			if ( strtolower(substr($longurl, 0, strlen($ap))) == strtolower($ap) )
			{
				$protocol_ok = true;
				break;
			}
		}
	}
	else // if there's no protocol list, screw all that
	{
		$protocol_ok = true;
	}
		
	// add the url to the database
	if ( $protocol_ok && $lilurl->add_url($longurl) )
	{
		if ( REWRITE ) // mod_rewrite style link
		{
			$url = 'http://'.$_SERVER['SERVER_NAME'].dirname($_SERVER['PHP_SELF']).''.$lilurl->get_id($longurl);
		}
		else // regular GET style link
		{
			$url = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['PHP_SELF'].'?id='.$lilurl->get_id($longurl);
		}

		$msg = '<p class="success"><a href="'.$url.'">'.$url.'</a></p>';
	}
	elseif ( !$protocol_ok )
	{
		$msg = '<p class="error">Warning: Вы не ввели URL</p>';
	}
	else
	{
		$msg = '<p class="error">Creation of your lil&#180; URL failed for some reason.</p>';
	}
}
else // if the form hasn't been submitted, look for an id to redirect to
{
	if ( isSet($_GET['id']) ) // check GET first
	{
		$id = mysql_escape_string($_GET['id']);
	}
	elseif ( REWRITE ) // check the URI if we're using mod_rewrite
	{
		$explodo = explode('/', $_SERVER['REQUEST_URI']);
		$id = mysql_escape_string($explodo[count($explodo)-1]);
	}
	else // otherwise, just make it empty
	{
		$id = '';
	}
	
	// if the id isn't empty and it's not this file, redirect to it's url
	if ( $id != '' && $id != basename($_SERVER['PHP_SELF']) )
	{
		$location = $lilurl->get_url($id);
		
		if ( $location != -1 )
		{
			// оттуто происходит редирект
			//header('Location: '.$location);
        ?>
		<html>

	<head>
		<title></title>
		
		<style type="text/css">
		body {
			font: .8em "Trebuchet MS", Verdana, Arial, Sans-Serif;
			text-align: center;
			color: #333;
			background-color: #fff;
			margin-top: 2em;
		}
		
		h1 {
			font-size: 2em;
			padding: 0;
			margin: 0;
		}

		h4 {
			font-size: 1em;
			font-weight: bold;
		}
		
		form {
			width: 45em;
			background-color: #ffffff;
			border: 1px solid #ffffff;
			margin-left: auto;
			margin-right: auto;
			padding: 1em;
		}
		
		fieldset {
			border: 0;
			margin: 0;
			padding: 0;
		}
		
		a {
			color: #09c;
			text-decoration: none;
			font-weight: bold;
			font-size: 1.2em;
			
		}

		a:visited {
			color: #07a;
		}

		a:hover {
			color: #c30;
		}

		.error, .success {
			font-size: 1.2em;
			font-weight: bold;
		}
		
		.error {
			color: #ff0000;
		}
		
		.info, .success {
			font-size: 1.2em;
			font-weight: bold;
		}
		.info2 {
			color: #000000;
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
			font-size: 1.2em;
			font-weight: bold;
		}
		.info {
			color: #747474;
			white-space: nowrap;
			width: 650px;
			text-overflow: ellipsis;
			overflow: hidden;
		}
		
		.success {
			color: #000;
		}
		
		</style>

	</head>


		<form action="<?php echo $_SERVER['PHP_SELF']?>" method="post">
		
			<fieldset>
				<p class="info2">Вы пытаетесь перейти по ссылке:</p>
				<p class="info"><?php echo $location;?></p>
				<a class="btn" href="<?php echo $location;?>"> Перейти </a>
			</fieldset>
		
		</form>

	</body>

</html>

<?php
			exit();
		}
		else
		{
			$msg = '<p class="error">Warning: Этот URL не найден в базе данных</p>';
		}
	}
}

?>

<html>

	<head>
		<title></title>
		
		<style type="text/css">
		body {
			font: .8em "Trebuchet MS", Verdana, Arial, Sans-Serif;
			text-align: center;
			color: #333;
			background-color: #fff;
			margin-top: 5em;
		}
		
		h1 {
			font-size: 2em;
			padding: 0;
			margin: 0;
		}

		h4 {
			font-size: 1em;
			font-weight: bold;
		}
		
		form {
			width: 45em;
			background-color: #FFFFFF;
			border: 1px solid #FFFFFF;
			margin-left: auto;
			margin-right: auto;
			padding: 1em;
		}
		
		fieldset {
			border: 0;
			margin: 0;
			padding: 0;
		}
		
		a {
			color: #09c;
			text-decoration: none;
			font-weight: bold;
		}

		a:visited {
			color: #07a;
		}

		a:hover {
			color: #c30;
		}

		.error, .success {
			font-size: 1.2em;
			font-weight: bold;
		}
		
		.error {
			color: #ff0000;
		}
		
		.success {
			color: #000;
		}
		.longurl {
		width: 300px;
		}
		input[type="text"]:focus {
		outline-style: none;
		border: 2px solid #b2d1ff;
		}
		

		</style>

	</head>
	<body onload="document.getElementById('longurl').focus()">
		
		<form action="<?php echo $_SERVER['PHP_SELF']?>" method="post">
		
				<fieldset>
					<br>
					<br>
					<br>
					<br>
				<input type="text" autocomplete="off" class="longurl" placeholder="Вставте длинную ссылку..." name="longurl" id="longurl" />
				<input type="submit" name="submit" id="submit" value="Сократить ссылку" />
			</fieldset>
		<br>
		<?php echo $msg; ?>
		
		</form>

	</body>

</html>
		
