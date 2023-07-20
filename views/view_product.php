<?php
include "../connect.php";
$sql=mysqli_query($con,"SELECT * from product_tb ");
$list=array();
if($sql->num_rows>0){
  while($row=mysqli_fetch_assoc($sql)){
      $myarray['result']='success';
      $myarray['Image']=$row['image'];
      $myarray['Product_name']=$row['product_name'];
      $myarray['rate']=$row['rate'];
      $myarray['product_id']=$row['product_id'];


    
      $myarray['Description']=$row['description'];
    

      array_push($list,$myarray);
  }


 
}
else{
  $myarray['result']='failed';
  array_push($list,$myarray);

  
}
 echo json_encode($list);

?>