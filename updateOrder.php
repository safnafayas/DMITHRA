<?php
 include 'connect.php';
$status = $_POST['status'];
$order_id = $_POST['order_id'];
$product_id = $_POST['product_id'];
$stock = $_POST['stock'];


// $data=mysqli_query($con,"insert into demo_name_tb(name) values('$name')");

$sql1 = mysqli_query($con, "UPDATE product_orders set status = '$status' where order_id='$order_id'");
$sql2 = mysqli_query($con, "UPDATE product_tb set stock='$stock' where product_id='$product_id'");

if($sql1 && $sql2 ){
    $myarray['result']="success";

    $myarray['response']="done";
} else{
    $myarray['result']="failed";
 
}
echo json_encode($myarray);
?>