<?php
//This page let users sign up
include('initcfg.php');
include('zz.php');

if(isset($_POST['username'], $_POST['password'], $_POST['passverif'], $_POST['email']) and $_POST['username']!='')
{
	if(get_magic_quotes_gpc())
	{
		$_POST['username'] = stripslashes($_POST['username']);
		$_POST['password'] = stripslashes($_POST['password']);
		$_POST['passverif'] = stripslashes($_POST['passverif']);
		$_POST['email'] = stripslashes($_POST['email']);
	}
	if($_POST['password']==$_POST['passverif'])
	{
		/*if(strlen($_POST['password'])>=6)
		{*/
			if(preg_match('#^(([a-z0-9!\#$%&\\\'*+/=?^_`{|}~-]+\.?)*[a-z0-9!\#$%&\\\'*+/=?^_`{|}~-]+)@(([a-z0-9-_]+\.?)*[a-z0-9-_]+)\.[a-z]{2,}$#i',$_POST['email']))
			{
				$username = mysql_real_escape_string($_POST['username']);
				$password = mysql_real_escape_string(sha1($_POST['password']));
				$email = mysql_real_escape_string($_POST['email']);


				$dn = mysql_num_rows(mysql_query('select id from users where username="'.$username.'"'));
				if($dn==0)
				{
					$dn = mysql_num_rows(mysql_query('select id from users where email="'.$email.'"'));
					if($dn==0)
					{
						
						$dn2 = mysql_num_rows(mysql_query('select id from users'));
						$log->lwrite('select id from users '.strval($dn2));
						$log->lwrite('dn2= ['.strval($dn2).']');
						$id = $dn2+1;
						$log->lwrite('id= ['.strval($id).']');
						$sql = "insert into users(id, username, password, email, signup_date) values (".$id.', "'.$username.'", "'.$password.'", "'.$email.'", "'.time().'")';
						$log->lwrite('sql='.$sql);
						
						$result = mysql_query('select id from users');
						$log->lwrite('$result=['.$result.']');
						$mysres = mysql_result($result, 0, 0);
						$log->lwrite('$mysres=['.$mysres.']');
						$log->lwrite("result: ".$result." ; Error: ".mysql_error());
						$sql = 'insert into users(username, password, email, signup_date) values ("'.$username.'", "'.$password.'", "'.$email.'", "'.time().'")';
						$log->lwrite('sql='.$sql);
						if(mysql_query($sql))
						{
							$form = false;
							echo '{success:true,message:"'.getMyLocalizedMessage($languageXMLdoc, 'successfulsignupmessage').'"}';
	/*?>
	<div class="message">You have successfully been signed up. You can now log in.<br />
	<a href="login.php">Log in</a></div>
	<?php*/
						}
						else
						{
							$form = true;
							$log->lwrite("result: ".$result." ; Error: ".mysql_error());
							$message = getMyLocalizedMessage($languageXMLdoc, 'dbsignuperror');#'An error occurred while signing you up.';
						}
					}
					else
					{
						$form = true;
						$message = getMyLocalizedMessage($languageXMLdoc, 'emailalreadyused');#'Another user already use this email.';
					}
				}
				else
				{
					$form = true;
					$message = getMyLocalizedMessage($languageXMLdoc, 'usernamealreadyused');#'Another user already use this username.';
				}
			}
			else
			{
				$form = true;
				$message = getMyLocalizedMessage($languageXMLdoc, 'invalidemail');#'The email you typed is not valid.';
			}
		/*}
		else
		{
			$form = true;
			$message = 'Your password must have a minimum of 6 characters.';
		}*/
	}
	else
	{
		$form = true;
		$message = getMyLocalizedMessage($languageXMLdoc, 'passwordsarenotidentical');#'The passwords you entered are not identical.';
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
	
	$log->lclose();
}
?>