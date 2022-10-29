<?php
// require_once ('../../../karma_db/DBController.php');

// class Event2 {
//     private $db_handle;
    
//     function __construct() {
//         $this->db_handle = new DBController();
//     }
    
//     function getCategory() {

//         $array = array(); 
//         $query = "SELECT * FROM events ORDER BY id DESC";
//         $result = $this->db_handle->runBaseQuery($query);

//         foreach ($result as $k => $v) {
//             $row['id'] = $result[$k]["id"];
//             $row['name'] = $result[$k]["name"];
//             //$row['status'] = $result[$k]["status"];

//             array_push($array, $row); 
//         }

//         //print(json_encode(array_reverse($array)));

//         header('Content-Type: application/json; charset=utf-8');
//         echo str_replace('\\/', '/', json_encode($array, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));

//     }

//     function getMissionByUser($id) {
//         $query = "SELECT * FROM mission WHERE user_id = ?";
//         $paramType = "i";
//         $paramValue = array(
//             $id
//         );
        
//         $result = $this->db_handle->runQuery($query, $paramType, $paramValue);

//         header('Content-Type: application/json; charset=utf-8');
//         echo str_replace('\\/', '/', json_encode($result, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
//     }
// }

// $event2=new Event2();
// $event2->getCategory();
//$event2->getMissionByUser(1); 
 ?>