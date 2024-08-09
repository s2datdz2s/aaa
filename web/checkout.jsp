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
    </head>
    <style>
        .popup {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }

        .popup form {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
    </style>

    <body class="biolife-body">

        <jsp:include page="header.jsp"/>


        <div class="page-contain checkout">

            <!-- Main content -->
            <div id="main-content" class="main-content">
                <div class="container sm-margin-top-37px">
                    <div class="row">

                        <h2 class="title" style="text-align: center">Checkout</h2>

                        <!--Order Summary-->
                        <div class=" col-md-12 sm-padding-top-48px sm-margin-bottom-0 xs-margin-bottom-15px">
                            <div class="order-summary sm-margin-bottom-80px">

                                <div class="cart-list-box short-type">
                                    <ul class="cart-list">
                                        <c:forEach var="cart" items="${sessionScope['cart'].getItems()}">

                                            <li class="cart-elem">
                                                <div class="cart-item">
                                                    <div class="product-thumb">
                                                        <a class="prd-thumb" href="#">
                                                            <figure><img src="img/${cart.getProduct().getImg()}" width="113" height="113" alt="shop-cart" ></figure>
                                                        </a>
                                                    </div>
                                                    <div class="info">
                                                        <span class="txt-quantity">${cart.getQuantity()}X</span>
                                                        <a href="#" class="pr-name">${cart.getProduct().getName()}</a>
                                                    </div>
                                                    <div class="price price-contain">
                                                        <ins><span class="price-amount"><span class="currencySymbol"></span>${cart.getProduct().getPrice() * cart.getQuantity()}00VND
                                                            </span></ins>

                                                    </div>
                                                </div>
                                            </li>
                                        </c:forEach>

                                    </ul>
                                    <ul class="subtotal">
                                        <li>
                                            <div class="subtotal-line">
                                                <b class="stt-name">Subtotal</b>
                                                <span class="stt-price">${cart.getTotalMoney()}00VND</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="subtotal-line">
                                                <b class="stt-name">Shipping</b>
                                                <span class="stt-price">0VND</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="subtotal-line">
                                                <b class="stt-name">total:</b>
                                                <span class="stt-price">${cart.getTotalMoney()}00VND</span>
                                            </div>
                                        </li>
                                    </ul>
                                    <form action="Checkout" name="frm-login" method="post">
                                        <p class="form-row">
                                            <b>Shipping notes: </b> <input name="notes" type="text" style="width: 60%;" >
                                        </p>
                                        <ul style="list-style-type: none; padding: 0;">
                                            <li style="display: inline-block; vertical-align: top; margin-top: 10px;">
                                                <b>Address:</b>
                                            </li>
                                            <li style="display: inline-block; vertical-align: top; margin-left: 45px;">
                                                <p class="form-row" style="margin: 0;">
                                                    <select id="addressSelect" name="address" style="width: 60%;" onchange="handleChange(this)">
                                                        <c:forEach var="addr" items="${address}">
                                                            <option value="${addr.addressId}">${addr.address}</option>
                                                        </c:forEach>
                                                        <option value="newAddress">Enter new address</option>
                                                    </select>
                                                </p>
                                            </li>
                                        </ul>
                                        <ul style="list-style-type: none; padding: 0; margin-top: 10px;">
                                            <li style="display: inline-block; vertical-align: top; margin-top: 10px;">
                                                <b>Payment:</b>
                                            </li>
                                            <li style="display: inline-block; vertical-align: top; margin-left: 40px;">
                                                <p class="form-row" style="margin: 0;">
                                                    <select name="paymentMethod" style="width: 60%;">
                                                        <option value="Cash">&#x1F4B5; COD</option>
                                                        <option value="Banking">&#x1F4B3; VNPAY</option>
                                                    </select>
                                                </p>
                                            </li>
                                            <button style="float: right; background-color:#05a503; color: white;" type="submit" name="btn-sbmt" class="btn">Order</button>
                                        </ul>
                                    </form>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
        <!-- Modal -->
        <div class="modal fade" id="newAddressModal" tabindex="-1" role="dialog" aria-labelledby="newAddressModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="newAddressModalLabel">Enter New Address</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="UpdateMoreAddress" name="frm-login" method="post">
                        <div class="modal-body">
                            <input name="newAddressInput" id="newAddressInput" type="text" class="form-control" placeholder="Enter new address">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            function handleChange(selectElement) {
                var selectedValue = selectElement.value;
                if (selectedValue === 'newAddress') {
                    $('#newAddressModal').modal('show');
                    selectElement.value = '';
                }
            }


            function closePopup() {
                var newAddressPopup = document.getElementById("newAddressPopup");
                newAddressPopup.style.display = "none"; // Ẩn popup khi người dùng nhấn Cancel
            }
        </script>
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