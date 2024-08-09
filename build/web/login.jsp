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
                        <div class="col-lg-3">

                        </div>
                        <!--Form Sign In-->
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <div class="signin-container">
                                <h1>Login</h1>
                                <form action="./LoginAdmin" name="frm-login" method="post">

                                    <p class="form-row">
                                        <label for="fid-name">Email<span class="requite">*</span></label>
                                        <input type="text" id="fid-name" name="email" value="" class="txt-input">
                                    </p>
                                    <p class="form-row">
                                        <label for="fid-pass">Password:<span class="requite">*</span></label>
                                        <input type="password" id="fid-pass" minlength="6" name="pass" value="" class="txt-input">
                                    </p>
                                    <p style="color: red;">${mess}</p>

                                    <a href="register">Sign-up!</a>
                                    <p class="form-row wrap-btn">
                                        <a href="Forgot">Forgot password</a>
                                    </p>
                                    <p class="form-row wrap-btn">

                                        <button class="btn btn-submit "  id="btnLogin" type="submit" name="user">login</button>
                                    </p>
                                </form>

                            </div>
                        </div>

                    </div>

                </div>

            </div>

        </div>

    </body>

</html>