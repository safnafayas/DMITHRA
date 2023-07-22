<?php
include 'connect.php';
if(isset($_GET['id'])){
    $user_id=$_GET['id'];
    $sql1=mysqli_query($con,"DELETE from user_login where login_id='$user_id'");
    $sql2=mysqli_query($con,"DELETE from user_register_table where login_id='$user_id'");
    if($sql1 && $sql2){
        echo "Record deleted successfully";
        echo"<script>alert('Record Deleted successfully !');</script>";

        echo "<script>window.location.href='DifrentlyAbled.php'; </script>";


    }else{
        echo "Can't Delete !!";
        echo"<script>alert('Failed to  delete record  !');</script>";

                header('location:DifrentlyAbled.php');
    }

}
?>
