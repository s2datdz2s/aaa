<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>My Website</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    </head>
    <body>
        <!-- HEADER -->
        <nav class="navbar navbar-default">
            <div class="container">

                <!-- BRAND -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#alignment-example" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <img src="img/z5525219777756_e2401e59af37cd3dc6c1f0cb0a14ebd0.jpg" width="45px" height="45px" style="margin-top: 6px" alt="alt"/>
                </div>

                <!-- COLLAPSIBLE NAVBAR -->
                <div class="collapse navbar-collapse" id="alignment-example">

                    <!-- Links -->
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="HomePage" class="nav-link" style="font-size: 20px;">Home</a>
                        </li>
<!--                        <li >
                            <a href="BlogList" class="nav-link" style="font-size: 20px;">Blog</a>
                        </li>-->
                        <li>
                            <a href="ProductList" class="nav-link" data-title="Shop" style="font-size: 20px;">Shop</a>
                        </li>
                        <li>
                            <a href="ViewCart" class="link-to">
                                Cart 
                                <c:if test="${sessionScope['cart'] == null}">
                                    (0)
                                </c:if>
                                <c:if test="${sessionScope['cart'] != null}">
                                    (${sessionScope['cart'].getItems().size()})
                                </c:if>
                            </a>
                        </li>
                        <li>
                            <c:if test="${sessionScope['account'].getRoles().getId() == 2}">
                            <li><a href="ManagerUser">Manager Page</a></li>
                            </c:if>
                        </li>
                        <li>
                            <c:if test="${sessionScope['account'].getRoles().getId() == 3}">
                            <li><a href="ManagerProduct">Manager Page</a></li>
                            </c:if>
                        </li>
                    </ul>

                    <!-- Search -->
                    <form action="ProductList?index=1" class="navbar-form nav navbar-nav" name="desktop-seacrh" method="get">
                        <input type="text" name="search" style="border-radius: 18px; width: 250px" class="input-text" value="" placeholder="Search here...">
                        <button type="submit" style="border-radius: 15px; border: none; position: relative; background-color: white; right: 40px;"><i class="biolife-icon icon-search" style="color: #7fff00; font-weight: bold;"></i></button>
                    </form>

                    <ul class="nav navbar-nav navbar-right">
                        <c:if test="${sessionScope['account'] != null}">
                            <li><a href="MyOrder">My order</a></li>

                            <!-- Dropdown for Profile and Change Password -->
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Account <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="Profile">User Profile</a></li>
                                    <li><a href="Changepassword">Change Password</a></li>
                                </ul>
                            </li>

                            <!-- Logout Button -->
                            <li><a href="Logout" style="color: black;" class="login-link"><i class="fa fa-sign-out" style="font-size: 18px; margin-left: 10px;" aria-hidden="true"></i></a></li>
                                </c:if>

                        <c:if test="${sessionScope['account'] == null}">
                            <li><a href="login" style="color: black;" class="login-link"><i class="biolife-icon icon-login"></i> Login/Register</a></li>
                            </c:if>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
</html>
