<?php
include('initcfg.php');
if (isset($_SESSION['username'])) {
    echo "{success:true,username:'".$_SESSION['username']."',userid:'".$_SESSION['userid']."',message:'You are logged.'}";
} else {
    echo '{success:false,message:"You are not logged."}';
}
?>