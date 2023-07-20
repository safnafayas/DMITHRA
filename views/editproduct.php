<?php
include '../connect.php';
$rate = $_POST['rate'];
$pid = $_POST['pid'];

$sql = mysqli_query($con, "UPDATE product_tb SET rate='$rate' WHERE product_id='$pid'");
if ($sql) {
    $myarray['result'] = 'success';
    $myarray['product_id'] = $pid;
  
    // Assign the same product_id that was updated
} else {
    $myarray['result'] = 'failed';
}

echo json_encode($myarray);
?>
