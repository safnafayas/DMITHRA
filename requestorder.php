<?php
include 'connect.php';
$productid = $_POST['product_id'];
$loginiD = $_POST['user_id'];
$rate = $_POST['rate'];
$pickdate = $_POST['pickupdate'];
$date = $_POST['date'];

$sql1 = $con->query("INSERT INTO product_orders (product_id, user_id, rate, pickupdate, date) VALUES ('".$productid."', '".$loginiD."', '".$rate."', '".$pickdate."', '".$date."');");

if ($sql1) {
    $myarray['result'] = "success";
    $myarray['response'] = "done";
} else {
    $myarray['result'] = "failed";
}

echo json_encode($myarray);
?>
