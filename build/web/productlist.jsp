<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Perfume Shop</title>
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
         <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            /* Add the CSS rules here */
            .sidebar {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .sidebar h2 {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 15px;
                color: #333;
            }

            .sidebar .list-group-item {
                border: none;
                padding: 10px 0;
                font-size: 16px;
                color: #555;
                transition: background-color 0.3s, color 0.3s;
            }

            .sidebar .list-group-item a {
                text-decoration: none;
                color: inherit;
            }

            .sidebar .list-group-item:hover,
            .sidebar .list-group-item a:hover {
                background-color: #f0f0f0;
                color: #007bff;
            }

            .sidebar .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                font-weight: bold;
                transition: background-color 0.3s, border-color 0.3s;
            }

            .sidebar .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }

            .products-list {
                display: flex;
                flex-wrap: wrap;
                list-style-type: none; /* Remove default list markers */
                padding: 0; /* Remove default padding */
                margin: 0; /* Remove default margin */
            }

            .products-list::marker {
                display: none; /* Ensure no default markers are displayed */
            }

            .product-item {
                flex: 0 0 33.3333%;
                box-sizing: border-box;
                padding: 15px;
            }

            @media (max-width: 768px) {
                .product-item {
                    flex: 0 0 50%;
                }
            }

            @media (max-width: 576px) {
                .product-item {
                    flex: 0 0 100%;
                }
            }
        </style>
    </head>

    <body class="biolife-body">
        <jsp:include page="header.jsp"/>

        <div class="page-contain category-page no-sidebar">
            <div class="container">
                <div class="row">
                    <!-- Sidebar -->
                    <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                        <div class="sidebar" style="margin-left: -50px;">
                            <div class="search-box">
                                <form action="ProductList" method="get">
                                    <input type="text" name="search" class="form-control" placeholder="Search products...">
                                    <button type="submit" class="btn btn-primary btn-block" style="margin-top: 10px;">Search</button>
                                </form>
                            </div>
                            <div class="categories">
                                <h2>Product Categories</h2>
                                <ul class="list-group">
                                    <li class="list-group-item"><a href="ProductList">All Category</a></li>
                                        <c:forEach var="c" items="${clist}">
                                        <li class="list-group-item">
                                            <a href="ProductList?categoryId=${c.getId()}">${c.getName()}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="sort-default">
                                <h2>Sort Default</h2>
                                <ul class="list-group">
                                    <li class="list-group-item">
                                        <a href="ProductList?sort=0" ${param['sort'] == 0 ? 'class="active"' : ''}>Sort Default</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="ProductList?sort=1" ${param['sort'] == 1 ? 'class="active"' : ''}>Newest</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="ProductList?sort=2" ${param['sort'] == 2 ? 'class="active"' : ''}>Price ascending</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="ProductList?sort=3" ${param['sort'] == 3 ? 'class="active"' : ''}>Price descending</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="static-links">
                                <h2>Contacts & Links</h2>
                                <ul class="list-group">
                                    <li class="list-group-item"><a href="contact.jsp">Contact Us</a></li>
                                    <li class="list-group-item"><a href="about.jsp">About Us</a></li>
                                    <li class="list-group-item"><a href="faq.jsp">FAQ</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Main content -->
                    <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
                        <ul class="products-list">
                            <c:forEach var="p" items="${plist}">
                                <li class="product-item">
                                    <div class="contain-product layout-default">
                                        <div class="product-thumb">
                                            <a href="./ProductDetails?pid=${p.getId()}" class="link-to-product" style="display: block; width: 100%; height: auto;">
                                                <img src="img/${p.getImg()}" alt="img" style="width: 100%; height: auto;">
                                            </a>
                                        </div>
                                        <div class="info">
                                            <h4 class="product-title"><a href="./ProductDetails?pid=${p.getId()}" class="pr-name" style="color: #000000;">Name: ${p.getName()}</a></h4>
                                            <div class="price">
                                                <ins><span class="price-amount" style="color: #ff0000"><s>Price: <span class="currencySymbol"></span>${p.getPrice() + 95}00VND</s></span></ins><br>
                                                <ins><span class="price-amount" style="color: #1abd0b;">PriceSell: <span class="currencySymbol"></span>${p.getPrice()}00VND</span></ins>
                                                <div class="buttons">
                                                    <c:choose>
                                                        <c:when test="${p.getStock() > 0}">
                                                            <a href="./AddToCart?pid=${p.getId()}&quantity=1&url=ProductList" class="btn btn-primary"><i class="fa fa-cart-arrow-down" aria-hidden="true"></i> Add to cart</a><br>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="btn btn-secondary">Sold Out</span><br>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <a href="SendFeedback?pid=${p.getId()}" class="btn btn-primary"  style=" margin-top: 5px;">Send Feedback</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>

                        <div style="display: flex; justify-content: center;">
                            <ul class="pagination">
                                <li class="page-item next"><a href="ProductList?index=1&categoryId=${param['categoryId']}&sort=${param['sort']}"><i class="fa fa-angle-left" class="page-link" aria-hidden="true"></i></a></li>
                                        <c:forEach var="i" begin="1" end="${numberPage}">
                                    <li class="${param['index'] == i ? 'page-item active' : 'page-item'}"><a href="ProductList?index=${i}&categoryId=${param['categoryId']}&sort=${param['sort']}" class="page-link">${i}</a></li>
                                    </c:forEach>
                                <li class="page-item next"><a href="ProductList?index=${numberPage}&categoryId=${param['categoryId']}&sort=${param['sort']}"><i class="fa fa-angle-right" class="page-link" aria-hidden="true"></i></a></li>
                            </ul>
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
