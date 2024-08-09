<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="no-js" lang="en">
    <style>
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a,
        .pagination span {
            padding: 8px 12px;
            margin: 0 4px;
            color: #333;
            text-decoration: none;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .pagination a:hover {
            background-color: #f4f4f4;
        }

        .pagination .current-page {
            background-color: #007bff;
            color: #fff;
        }


    </style>
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

    </head>
    <style>
        .quantity-box.type1 .qty-input button {
            font-size: 14px; /* Adjust the font size as needed */
            margin: 10px;
            margin-bottom: 2px;
            width: 30px; /* Adjust the width as needed */
            height: 35px; /* Adjust the height as needed */
        }
    </style>

    <body class="biolife-body">

        <jsp:include page="header.jsp"/>

        <div class="page-contain shopping-cart">

            <!-- Main content -->
            <div id="main-content" class="main-content">
                <div class="container">

                    <!--Top banner-->

                    <!--Cart Table-->
                    <div class="shopping-cart-container" style="margin-bottom: 60px;">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <h1 class="box-title">View cart </h1>
                                <table class="shop_table cart-form">
                                    <thead>
                                        <tr>
                                            <th >Product Name</th>
                                            <th class="product-name">Product Img</th>
                                            <th class="product-price">Price</th>
                                            <th class="product-quantity">Quantity</th>
                                            <th class="product-subtotal">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cart" items="${sessionScope.cartItems}">                                            
                                            <tr class="cart_item">
                                                <td >
                                                    <a href="#">${cart.product.name}</a>
                                                </td>
                                                <td class="product-thumbnail" data-title="Product Name">
                                                    <a class="prd-thumb" href="#">
                                                        <figure><img width="113" height="113" src="img/${cart.product.img}" alt="shipping cart"></figure>
                                                    </a>
                                                </td>

                                                <td class="product-price" data-title="Price">
                                                    <div class="price price-contain">
                                                        <ins><span class="price-amount"><span class="currencySymbol"></span>${cart.product.price}00VND</span></ins>
                                                    </div>
                                                </td>

                                                <td class="product-quantity" data-title="Quantity">
                                                    <form id="myForm${cart.product.id}" action="UpdateQuantityCart" method="post">
                                                        <div class="quantity-box type1">
                                                            <div class="qty-input">
                                                                <input type="hidden" name="productId" value="${cart.product.id}"> 

                                                                <button type="button" onclick="updateAndSubmitForm(${cart.product.id}, -1)">-</button>
                                                                <input type="text" id="quantityInput${cart.product.id}" name="quantity" value="${cart.quantity}">
                                                                <button type="button" onclick="updateAndSubmitForm(${cart.product.id}, 1)">+</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </td>

                                                <td class="product-subtotal" data-title="Total">
                                                    <div class="action">
                                                        <a href="./DeleteCartItem?pid=${cart.product.id}"style="color: red; font-size: 40px;" class="remove"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <tr class="cart_item wrap-buttons">
                                            <td class="wrap-btn-control" colspan="4">
                                                <a class="btn back-to-shop" href="./HomePage" style="background-color: #05a503">Back to Shop</a>
                                            </td>
                                            <td class="wrap-btn-control" colspan="2">
                                                <a class="btn back-to-shop" href="Checkout"  style="background-color:#05a503">Checkout</a>
                                            </td>
                                        </tr>

                                    </tbody>    
                                </table>
                                <div class="pagination" style="display: flex; justify-content: center;">
                                    <c:if test="${currentPage > 1}">
                                        <a href="ViewCart?page=${currentPage - 1}">Previous</a>
                                    </c:if>
                                    <c:forEach var="page" begin="1" end="${totalPages}">
                                        <c:choose>
                                            <c:when test="${page == currentPage}">
                                                <a href="ViewCart?page=${page}" class="current-page">${page}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="ViewCart?page=${page}">${page}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="ViewCart?page=${currentPage + 1}">Next</a>
                                    </c:if>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- FOOTER -->
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
                                                                    function updateAndSubmitForm(productId, change) {
                                                                        var quantityInput = document.getElementById('quantityInput' + productId);
                                                                        var currentQuantity = parseInt(quantityInput.value);

                                                                        // Ensure quantity is not negative
                                                                        if (currentQuantity + change >= 1) {
                                                                            quantityInput.value = currentQuantity + change;
                                                                        }

                                                                        // Submit the specific form by using the unique form ID
                                                                        document.getElementById('myForm' + productId).submit();
                                                                    }
        </script>
    </body>

</html>