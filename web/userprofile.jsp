<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Biolife - Organic</title>
        <link href="https://fonts.googleapis.com/css?family=Cairo:400,600,700&amp;display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:600&amp;display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400i,700i" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Ubuntu&amp;display=swap" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/animate.min.css">
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/nice-select.css">
        <link rel="stylesheet" href="assets/css/slick.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/main-color.css">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>



        <style>
            /* CSS to fix the image size */
            .fixed-size-image {
                width: 200px;
                height: 150px;
                object-fit: cover; /* Ensures the image covers the area without distortion */
                margin-left: 8%;
            }
        </style>
    </head>

    <body class="biolife-body">

        <jsp:include page="header.jsp"/>

        <div class="page-contain login-page">
            <!-- Main content -->
            <div id="main-content" class="main-content">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <h3 class="box-title" style="display: inline;">Your Account Profile</h3><br>

                            <!-- Form to update profile -->
                            <form method="post" action="Profile" enctype="multipart/form-data" onsubmit="return validateImageSize()">
                                <div class="col-md-6">
                                    <!-- Displaying the profile image with fixed size -->
                                    <img class="fixed-size-image" src="img/${sessionScope['account'].getImg()}" name="photo">


                                </div>
                                <div class="col-md-6">
                                    <!-- Input for uploading new profile image -->
                                    <label>Link Img</label>
                                    <input class="form-control" name="photo" id="photo" type="file" accept="image/*">
                                </div>
                                <div class="col-md-6">
                                    <!-- Input for updating name -->
                                    <label>Full Name</label>
                                    <input class="form-control" type="text" value="${sessionScope['account'].getName()}" name="name">
                                </div>
                                <div class="col-md-6">
                                    <!-- Input for updating phone number -->
                                    <label>Phone</label>
                                    <input class="form-control" type="text" value="${sessionScope['account'].getPhone()}" name="phone">
                                </div>
                                
                                <div class="col-md-6">
                                    <!-- Input for displaying email -->
                                    <label>Email</label>
                                    <input class="form-control" type="text" value="${sessionScope['account'].getEmail()}" name="email" readonly>
                                </div>

                                <div class="col-md-6">
                                    <!-- Input for selecting gender -->
                                    <label>Gender</label><br>
                                    <input type="radio" name="gender" value="1" ${sessionScope['account'].getGender() ? "Checked" : ""}> Male  
                                    <input type="radio" name="gender" value="0" ${!sessionScope['account'].getGender() ? "Checked" : ""}> Female
                                </div>
                                <div class="col-md-12">
                                    <!-- Input for updating address -->
                                    <label>Address</label>
                                    <input class="form-control" type="text" value="${sessionScope['account'].getAddress()}" name="address">
                                </div>
                                <div class="col-md-12" style="padding: 2px;">
                                    <!-- Hidden input for user ID -->
                                    <input value="${sessionScope['account'].getId()}" name="id" type="hidden">
                                </div>
                                <div class="col-md-12" style="padding: 2px;">
                                    <!-- Displaying success or error message -->
                                    <p style="color: red;">${mess}</p>
                                    <p style="color: green;">${success}</p>
                                </div>

                                <div class="col-md-12">
                                    <!-- Submit button for form -->
                                    <input class="btn btn-primary" type="submit" value="Save changes">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

        <!-- Scroll Top Button -->
        <a class="btn-scroll-top"><i class="biolife-icon icon-left-arrow"></i></a>

        <!-- JavaScript -->
        <script src="assets/js/jquery-3.4.1.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.countdown.min.js"></script>
        <script src="assets/js/jquery.nice-select.min.js"></script>
        <script src="assets/js/jquery.nicescroll.min.js"></script>
        <script src="assets/js/slick.min.js"></script>
        <script src="assets/js/biolife.framework.js"></script>
        <script src="assets/js/functions.js"></script>

        <script>
                                // JavaScript function to validate image size before form submission
                                function validateImageSize() {
                                    var fileInput = document.getElementById('photo');
                                    var file = fileInput.files[0];

                                    if (file) {
                                        var fileSize = file.size / 1024 / 1024; // size in MB
                                        var maxSize = 2; // Max size in MB

                                        if (fileSize > maxSize) {
                                            alert('The image size is too large. Please select an image less than 2MB.');
                                            return false; // Prevent form submission
                                        }
                                    }
                                    return true;
                                }
        </script>
    </body>

</html>
