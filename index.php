<?php

class Constants
{
    //DATABASE DETAILS
    static $DB_SERVER="localhost";
    static $DB_NAME="karma_db";
    static $USERNAME="root";
    static $PASSWORD="";

    //STATEMENTS
    static $SQL_SELECT_ALL="SELECT * FROM events JOIN organization ON events.organization=organization.id";


}

class Event
{
    /*******************************************************************************************************************************************/
    /*
       1.CONNECT TO DATABASE.
       2. RETURN CONNECTION OBJECT
    */
    public function connect()
    {
        $con=new mysqli(Constants::$DB_SERVER,Constants::$USERNAME,Constants::$PASSWORD,Constants::$DB_NAME);
        if($con->connect_error)
        {
            // echo "Unable To Connect"; - For debug
            return null;
        }else
        {
            //echo "Connected"; - For debug
            return $con;
        }
    }
    /*******************************************************************************************************************************************/
    /*
       1.SELECT FROM DATABASE.
    */
    public function select()
    {
        $con=$this->connect();
        if($con != null)
        {
            $result=$con->query(Constants::$SQL_SELECT_ALL);
            if($result->num_rows>0)
            {
                $event=array();
                while($row=$result->fetch_array())
                {
                    array_push($event, array("id"=>$row['id'],"name"=>$row['name'],
                    "start_date"=>$row['start_date'],"end_date"=>$row['end_date'],"time"=>$row['time'],
                    "description"=>$row['description'],"status"=>$row['status'],"venue"=>$row['venue'],
                    "category"=>$row['category'],"organization"=>$row['org_name'],
                    "points"=>$row['points'],"image_url"=>$row['image_url']));
                }
                print(json_encode(array_reverse($event)));
            }else
            {
                print(json_encode(array("PHP EXCEPTION : CAN'T RETRIEVE FROM MYSQL. ")));
            }
            $con->close();

        }else{
            print(json_encode(array("PHP EXCEPTION : CAN'T CONNECT TO MYSQL. NULL CONNECTION.")));
        }
    }
}

$event=new Event();
$event->select();

//end
