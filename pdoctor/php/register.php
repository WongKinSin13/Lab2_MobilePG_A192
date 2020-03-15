<?php
error_reporting(0);
include_once ("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);

if (empty($username) || empty($email) || empty($password) || empty ($passwordRepeat)){
	  echo "Please fill in all fields before submit";
	  exit();
	}
	else if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
	  echo "Invalid email format";
	  exit();
	}
	else {
$vkey = md5(time().$name);
$sqlinsert = "INSERT INTO accounts(username,password,email,phone) VALUES ('$name','$password','$email','$phone')";

if ($conn->query($sqlinsert) === true)
{
    sendEmail($email);
    echo "Success";
    
}
else
{
    echo "Failed";
}
}
function sendEmail($useremail) {
    $to      = $useremail; 
    $subject = 'Sign up verification - Pocket Doctor'; 
    $message = 'http://pocketdoctor.com/pdoctor/php/verify.php?email='.$useremail; 
    $headers = 'From: noreply@pocketdoctor.com' . "\r\n" . 
    'Reply-To: '.$useremail . "\r\n" . 
    'X-Mailer: PHP/' . phpversion(); 
    mail($to, $subject, $message, $headers); 
}

?>