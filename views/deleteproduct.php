<?php
include '../connect.php';

$product_id=$_POST['product_id'] ?? '';



 $sql=mysqli_query($con ,"DELETE FROM product_tb  where product_id='$product_id'");
if($sql){
    $myarray['result']='success';
}
else
{
    $myarray['result']='failed';
}

echo json_encode($myarray);
?>