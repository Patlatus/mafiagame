<?php
//This page let log in
include('initcfg.php');
include('zz.php');
if(isset($_SESSION['username']))
{
	unset($_SESSION['username'], $_SESSION['userid']);
	setcookie('username', '', time()-100);
	setcookie('password', '', time()-100);
}
else
{
	$ousername = '';
	$user = $_POST['username'];
	$pass = $_POST['password'];
	if (!isset($user)) {
		$user = $_GET['username'];
		$pass = $_GET['password'];
	}
	if(isset($user, $pass))
	{
		if(get_magic_quotes_gpc())
		{
			$ousername = stripslashes($user);
			$username = mysql_real_escape_string(stripslashes($user));
			$password = stripslashes($pass);
		}
		else
		{
			$username = mysql_real_escape_string($user);
			$password = $pass;
		}
		$req = mysql_query('select password,id from users where username="'.$username.'"');
		$dn = mysql_fetch_array($req);
		if($dn['password']==sha1($password) and mysql_num_rows($req)>0)
		{
			$form = false;
			$_SESSION['username'] = $user;
			$_SESSION['userid'] = $dn['id'];
			if(isset($_POST['memorize']) and $_POST['memorize']=='yes')
			{
				$one_year = time()+(60*60*24*365);
				setcookie('planssiteusername', $user, $one_year);
				setcookie('planssitepassword', sha1($password), $one_year);
			}
			echo '{success:true,message:"'.getMyLocalizedMessage($languageXMLdoc, 'successfulloginmessage').'",username:"'.$_SESSION['username'].'",userid:"'.$_SESSION['userid'].'"}';#"You have successfully been logged."
#<div class="message">You have successfully been logged.<br />
		}
		else
		{
			$form = true;
			$message = getMyLocalizedMessage($languageXMLdoc, 'wronguserorpasswordmessage');
		}
	}
	else
	{
		$form = true;
	}
	if($form)
	{

if(isset($message))
{
	echo '{success:false,message:"'.$message.'"}';
}
	}
}
?>