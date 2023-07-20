<?php
include '../connect.php';
$sql=mysqli_query($con,"SELECT * from entertainment_tb ");
$list=array();
if($sql->num_rows>0){
    while($row=mysqli_fetch_assoc($sql)){
        $myarray['result']='success';
        $myarray['Link']=$row['link'];
        $myarray['Caption']=$row['caption'];
        $myarray['Date']=$row['date'] ?? '';

        array_push($list,$myarray);
    }


   
}
else{
    $myarray['result']='failed';
    array_push($list,$myarray);

    
}
 echo json_encode($list);

?>
