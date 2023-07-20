<?php
include "connect.php";
$product_name = $_POST['product_name'];
$description = $_POST['description'];
$rate = $_POST['rate'];
$status = $_POST['status'];
$created_at = $_POST['created_at'];
$modified_at = $_POST['modified_at'];

$image = $_FILES['image']['name'];
$imagePath = 'productImagesUpload/' . $image;
$tmp_name = $_FILES['image']['tmp_name'];
move_uploaded_file($tmp_name, $imagePath);

$sql1 = "INSERT INTO `product_tb` (`product_name`, `description`, `image`, `rate`, `status`, `created_at`, `modified_at`) VALUES ('$product_name', '$description', '$image', '$rate', '$status', '$created_at', '$modified_at')";

if (mysqli_query($con, $sql1)) {
  $myarray['result'] = 'success';
} else {
  $myarray['result'] = 'failed';
}

echo json_encode($myarray);
?>
