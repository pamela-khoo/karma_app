<?php
// session_start();

// include '../../include/connection.php';


// $db = mysqli_connect('localhost','root','','karma_db');

// $data = file_get_contents('php://input');
// $dataDecode = json_decode($data, true);

// $user_id = $dataDecode['id'];

// // print_r($user_id);

// // $query = "SELECT * FROM mission WHERE user_id = '".$user_id."' ";
// // $getData = mysqli_fetch_assoc(mysqli_query($db,$query));

// // if ($getData['event_id']!="") {
// // 	echo $user_id;
// // } else {
// // 	echo 'no id';
// // }

// // $user_id = $_POST['user_id'];
// $event_id = $_POST['event_id'];

// print($user_id);

//  $sql = "SELECT id FROM mission WHERE user_id = '".$user_id."' AND event_id = '".$event_id."'";
//  $result = mysqli_query($db,$sql);
//  $count = mysqli_num_rows($result);
 
//  $row = mysqli_fetch_array($result);

//  if(!empty($row)) 
//     $_SESSION['id'] = $row["id"];
 
//  if($count == 1){
// 	$msg = "Error";
// 	echo json_encode($msg);
//  }else{
// 	$insert = "INSERT INTO mission(user_id, event_id) VALUES ('".$user_id."','".$event_id."')";
// 	$query = mysqli_query($db,$insert);
// 	if($query){
// 		$msg = "Success";
//  		echo json_encode($msg);
// 	}
// }
?>