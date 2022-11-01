<?php

session_start();


 $db = mysqli_connect('localhost','root','','karma_db');

 $email = $_POST['email'];
 $password = $_POST['password'];

 $sql = "SELECT * FROM user WHERE email = '".$email."' AND password = '".$password."'";
 $result = mysqli_query($db,$sql);
 $count = mysqli_num_rows($result);
 
 $row = mysqli_fetch_array($result);

 if(!empty($row)) 
    $_SESSION['id'] = $row["id"];
 
 if($count == 1){
	$msg = "Success";
	$array = [$row["id"], $row["first_name"], $row["email"], $msg];
	echo json_encode($array);
 } 
 else{
	$msg = "Error";
 	echo json_encode($msg);
 }
?>