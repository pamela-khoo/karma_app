<?php
session_start();

$db = mysqli_connect('localhost','root','','karma_db');
if(!$db)
{
	echo "Database connection failed";
}
$email = $_POST['email'];
$password = $_POST['password'];
$first_name = $_POST['first_name'];
$last_name = $_POST['last_name'];

$sql = "SELECT email FROM user WHERE email = '".$email."'";
$result = mysqli_query($db,$sql);
$count = mysqli_num_rows($result);
if ($email==''||$password==''||$first_name==''||$last_name=='') {
	echo json_encode("Empty");
} elseif ($count == 1){
	echo json_encode("Error");
}else{
	$insert = "INSERT INTO user(email,password,first_name,last_name) VALUES ('".$email."','".$password."','".$first_name."','".$last_name."')";
		$query = mysqli_query($db,$insert);
		if($query){
			echo json_encode("Success");
		}
}
?>