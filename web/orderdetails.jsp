<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="model.OrderDetail" %>
<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Flower Shop</title>

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

    </head>

    <body class="biolife-body">
        <c:set var="orderId" value="${param.oid}" />

        <jsp:include page="header.jsp"/>

        <table style="width: 100%;">
            <tr>
                <td>
                    <div style="display: flex; justify-content: space-between; margin-left: 150px; margin-right: 150px">
                        <div>
                            <h2><strong>Perfume shop</strong></h2>
                        </div>
                        <div>
                            <h4><strong>USA</strong></h4>
                            <h4><strong>0987654321</strong></h4>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

        <div style="text-align: center;">
            <h4><strong>#Order${orderId}</strong></h4>
        </div>

        <div class="page-contain login-page">
            <!-- Main content -->
            <div id="main-content" class="main-content">
                <div class="container">
                    <div class="user-info">
                        <h3><strong>User Information</strong></h3>
                        <p>Name: ${user.name}</p>
                        <p>Email: ${user.email}</p>
                        <p>Phone: ${user.phone}</p>
                        <!-- Add other user information as needed -->
                    </div>
                    <div class="row">

                        <div class=" col-12">
                            <h3 class="box-title" style="text-align: center"><strong>Order Detail</strong></h3>
                            <table class="table table-bordered table-striped" style="font-size: 20px;">
                                <thead>
                                    <tr>
                                        <th class="product-price">Product Name</th>
                                        <th class="product-name">Product Image</th>
                                        <th class="product-price">Price</th>
                                        <th class="product-subtotal">Quantity</th>
                                        <th class="product-subtotal">Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="odl" items="${odl}">
                                        <tr class="cart_item">
                                            <td class="product-thumbnail" data-title="Product Name">
                                                <a class="prd-name" href="./ProductDetails?pid=${odl.getProduct().getId()}">${odl.getProduct().getName()}</a>
                                            </td>
                                            <td class="product-thumbnail" data-title="Product Name">
                                                <a class="prd-thumb" href="./ProductDetails?pid=${odl.getProduct().getId()}">
                                                    <figure><img width="113" height="113" src="img/${odl.getProduct().getImg()}" alt="shipping cart"></figure>
                                                </a>
                                            </td>
                                            <td class="product-price" data-title="Price">
                                                <div class="price price-contain">
                                                    <ins><span class="price-amount"><span class="currencySymbol"></span>${odl.getProduct().getPrice()}00VND</span></ins>
                                                </div>
                                            </td>
                                            <td class="product-subtotal" data-title="Quantity">
                                                <div class="quantity-box type1">
                                                    ${odl.getQuantity()}
                                                </div>
                                            </td>
                                            <c:set var="subtotal" value="${odl.getProduct().getPrice() * odl.getQuantity()}" />
                                            <c:set var="total" value="${total + subtotal}" />
                                            <td class="product-subtotal" data-title="Total">
                                                <div class="price price-contain">
                                                    <ins><span class="price-amount"><span class="currencySymbol"></span>${odl.getProduct().getPrice()*odl.getQuantity()}00VND</span></ins>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                            <h4 style="text-align: right"><strong>Total: <c:out value="${total}" />00VND</strong></h4>

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
    </body>

</html>