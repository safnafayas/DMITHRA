<?php
include "connect.php";

if(isset($_FILES['image'])) {
    // Assuming you have the necessary data in variables
    $image = $_FILES['image']['name'];
    $imagePath = 'udidUpload/' . $image;
    $tmp_name = $_FILES['image']['tmp_name'];
    move_uploaded_file($tmp_name, $imagePath);
    $login_id = $_POST['login_id'];

    // Update query
    $sql = "UPDATE user_login SET image = '$image' WHERE login_id = '$login_id'";

    // Execute the query
    if(mysqli_query($con, $sql)) {
        echo "Data inserted successfully.";
    } else {
        echo "Error: " . mysqli_error($con);
    }
} else {
    echo "No file uploaded.";
}

// Close the database connection
mysqli_close($con);
?>
