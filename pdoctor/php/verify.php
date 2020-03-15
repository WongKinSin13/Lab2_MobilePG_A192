<?php
error_reporting(0);
include_once ("dbconnect.php");

if(isset($_GET['vkey'])){
	//Process verification
	$vkey = $_GET['vkey'];
	
	$resultSet = $mysqli->query("SELECT verified,veky FROM accounts WHERE verified 0 AND vkey = '$vkey' LIMIT 1");
	
	if($resultSet->num_rows == 1){
		//Validate email
		$update = $mysqli->query("UPDATE ACCOUNTS SET verified = 1 WHERE vkey = '$vkey' LIMIT 1");
		
		if($update){
		echo "Your account has been verified. You can now login.";
	
		} else{
		echo "$mysqli->error";
		}
		}else{
		echo "This account is invalid or already verified";
		}
	}else{
	die("Something went wrong");
	}
	?>