<%-- 
    Document   : AddAdmin
    Created on : Jan 8, 2024, 8:29:52 AM
    Author     : 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="no-js" lang="en">


    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title> Shop</title>
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
        <style>

            .inline{
                display:inline-block;
            }
        </style>
    </head>

    <body class="biolife-body" onload="generate()">

        <jsp:include page="header.jsp"/>


        <div class="page-contain login-page">

            <!-- Main content -->
            <div id="main-content" class="main-content">
                <div class="container">
                    <div class="row">

                        <!--Form Sign In-->
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <div class="signin-container">
                                <h1>Add New Product</h1>

                                <form action="AddNewProduct" method="post" enctype="multipart/form-data">
                                        <div class="modal-body">
                                            <b>Name: </b><input type="text" class="form-control" value="" required name="name"><br>
                                            <b>Price: </b><input type="number" step="0.1" class="form-control"  required value="" name="price"><br>
                                             <b>Quantity: </b><input type="number" step="0.1" class="form-control"  required value="" name="stock"><br>
                                            <b>Category: </b>
                                            <div style="height: 50px; w30pxidth: 100%">
                                                <select  class="form-control" style="display: block;" name="category" >
                                                    <c:forEach var="c" items="${clist}">
                                                        <option value="${c.getId()}" ${p.getCategory().getName()==c.getName()?"selected":""} >${c.getName()} </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <b>Description: </b><input type="text" class="form-control" required value="" name="descri"><br>
                                            <b>Image link:</b><input required name="photo" type="file" accept="image/*" class="form-control" value=""  ><br>

                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-success" value="submit">Submit</button>
                                        </div>
                                    </form>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>

        <jsp:include page="footer.jsp"/>

        <!-- Scroll Top Button -->
        <a class="btn-scroll-top"><i class="biolife-icon icon-left-arrow"></i></a>

        <script src="assets/js/jquery-3.4.1.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.countdown.min.js"></script>
        <script src="assets/js/jquery.nice-select.min.js"></script>
        <script src="assets/js/jquery.nicescroll.min.js"></script>
        <script src="assets/js/slick.min.js"></script>
        <script src="assets/js/biolife.framework.js"></script>
        <script src="assets/js/functions.js"></script>
        <script>
        var captcha;
        function generate() {

            // Clear old input
            document.getElementById("submitLogin").value = "";

            // Access the element to store
            // the generated captcha
            captcha = document.getElementById("image");
            var uniquechar = "";

            const randomchar =
                    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

            // Generate captcha for length of
            // 5 with random character
            for (let i = 1; i < 6; i++) {
                uniquechar += randomchar.charAt(
                        Math.random() * randomchar.length)
            }

            // Store generated input
            captcha.innerHTML = uniquechar;
        }

        function printmsg() {
            const usr_input = document
                    .getElementById("submitLogin").value;

            // Check whether the input is equal
            // to generated captcha or not
            if (usr_input == captcha.innerHTML) {
                document.getElementById("btnRegister")
                        .disabled = false;
                var s = document.getElementById("key")
                        .innerHTML = "CapCha Matched";
                generate();
            } else {
                var s = document.getElementById("key")
                        .innerHTML = "CapCha Not Matched";
                generate();
            }
        }
        </script>
    </body>

</html>