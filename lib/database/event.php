<?php
session_start();

$db = mysqli_connect('localhost','root','','karma_db');

$user_id = $_POST['user_id'];
$event_id = $_POST['event_id'];

 $sql = "SELECT id FROM mission WHERE user_id = '".$user_id."' AND event_id = '".$event_id."'";
 $result = mysqli_query($db,$sql);
 $count = mysqli_num_rows($result);
 
 $row = mysqli_fetch_array($result);

 if(!empty($row)) 
    $_SESSION['id'] = $row["id"];
 
 if($count == 1){
	$msg = "Error";
	echo json_encode($msg);
 }else{
	$insert = "INSERT INTO mission(user_id, event_id) VALUES ('".$user_id."','".$event_id."')";
	$query = mysqli_query($db,$insert);
	if($query){
		$msg = "Success";
 		echo json_encode($msg);
	}
}
?>