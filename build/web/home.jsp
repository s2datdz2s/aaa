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
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/animate.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/nice-select.css">
        <link rel="stylesheet" type="text/css" href="assets/css/slick.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/main-color.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            .carousel-inner > .item > img,
            .carousel-inner > .item > a > img {
                width: 100%;
                margin: auto;
            }
            .sidebar {
                margin-top: 80px;
                margin-left: -40px;
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .sidebar .search-box input {
                border-radius: 20px;
                padding: 10px;
            }
            .sidebar .btn-primary {
                background-color: #007bff;
                border: none;
                border-radius: 20px;
            }
            .sidebar .categories h2,
            .sidebar .sort-default h2,
            .sidebar .static-links h2 {
                font-size: 1.2em;
                margin-bottom: 10px;
            }
            .sidebar .list-group-item {
                border: none;
                padding: 10px 15px;
                font-size: 0.9em;
            }
            .sidebar .list-group-item a {
                text-decoration: none;
                color: #007bff;
            }
            .sidebar .list-group-item a.active {
                font-weight: bold;
                color: #0056b3;
            }
        </style>
    </head>

    <body class="biolife-body">

        <jsp:include page="header.jsp"/>

        <div class="page-contain">

            <div id="main-content" class="main-content">

                <div class="product-tab z-index-20">
                    <div class="container">
                        <br>
                        <div id="myCarousel" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ol class="carousel-indicators">
                                <li data-target="#myCarousel" data-slide-to="0" class="active"></li> 
                                    <c:forEach var="p" items="${balist}">
                                    <li data-target="#myCarousel" data-slide-to="${p.getId()}"></li>   
                                    </c:forEach>
                            </ol>

                            <!-- Wrapper for slides -->
                            <div class="carousel-inner" role="listbox">
                                <div class="item active">
                                    <a href="./banner0.jsp">
                                        <img src="img/z5475507570017_e02186104ef761e544cd6c152f385cfe.jpg" alt="banner1" width="460" height="345">
                                    </a>
                                </div>
                                <c:forEach var="p" items="${balist}">
                                    <div class="item">
                                        <a href="./ManagerBanner?bid=${p.getId()}">
                                            <img src="img/${p.getImg()}" alt="${p.getId()}" width="460" height="345">
                                        </a>
                                    </div>   
                                </c:forEach>
                            </div>

                            <!-- Left and right controls -->
                            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>

                        <!-- Sidebar -->
                        <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                            <div class="sidebar">
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

                        <div class="biolife-tab biolife-tab-contain sm-margin-top-34px">
                            <div class="tab-head tab-head__icon-top-layout icon-top-layout">
                                <h1 style="color: black; font-weight: 600; color: #000000; border-bottom: 1px solid #000000">Newest Product</h1>
                                <div class="row" style="margin-bottom: 50px;">
                                    <ul class="products-list" style="list-style: none;">
                                        <c:forEach var="p" items="${plist}">
                                            <li class="product-item col-lg-4 col-xs-6" style="min-height: 550px;">
                                                <div class="contain-product layout-default">
                                                    <div class="product-thumb">
                                                        <a href="./ProductDetails?pid=${p.getId()}" class="link-to-product" style="display: block; width: 300px; height: 300px; margin: 0 auto; display: flex; justify-content: center; align-items: center;">
                                                            <img src="img/${p.getImg()}" alt="img" style="max-width: 100%; max-height: 80%; object-fit: contain; margin-left: -40px">
                                                        </a>
                                                    </div>
                                                    <div class="info">
                                                        <h4 class="product-title" style="margin-top: 25px;">
                                                            <a style="color: #000000;" href="./ProductDetails?pid=${p.getId()}" class="pr-name">Name: ${p.getName()}</a>
                                                        </h4>
                                                        <div class="price">
                                                            <ins><span class="price-amount" style="color: #ff0000"><s>Price: <span class="currencySymbol"></span>${p.getPrice() + 95}00VND</s></span></ins><br>
                                                            <ins><span class="price-amount" style="color: #1abd0b;">PriceSell: <span class="currencySymbol"></span>${p.getPrice()}00VND</span></ins>
                                                        </div>
                                                        <div class="price">
                                                            <a href="./AddToCart?pid=${p.getId()}&quantity=1&url=HomePage" style="color: #000000; border-bottom: 1px solid #000000;">Add to cart</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>


                        <div class="product-tab z-index-20 sm-margin-top-193px xs-margin-top-30px">
                            <div class="container">
                                <div class="biolife-tab biolife-tab-contain sm-margin-top-34px">
                                    <div class="tab-head tab-head__icon-top-layout icon-top-layout">
                                        <ul class="tabs md-margin-bottom-35-im xs-margin-bottom-40-im">
                                            <li class="tab-element">
                                                <h1 style="color: black; font-weight: 600; font-family: cursive; color: #000000; border-bottom: 1px solid #000000">Top seller</h1>
                                            </li>
                                        </ul>
                                        <div class="row" style="margin-bottom: 50px;">
                                            <ul class="products-list" style="list-style: none;">
                                                <c:forEach var="p" items="${plist1}">
                                                    <li class="product-item col-lg-4 col-xs-6">
                                                        <div class="contain-product layout-default">
                                                            <div class="product-thumb">
                                                                <a href="./ProductDetails?pid=${p.getId()}" class="link-to-product" style="display: block; width: 250px; height: 250px; padding: auto; margin-left: -25px">
                                                                    <img src="img/${p.getImg()}" alt="img" width="300" height="300" style="margin-left: 8%;">
                                                                </a>
                                                            </div>
                                                            <div class="info">
                                                                <h4 class="product-title" style="margin-top: 25px;">
                                                                    <a href="./ProductDetails?pid=${p.getId()}" style="color: #000000;" class="pr-name">Name: ${p.getName()}</a>
                                                                </h4>
                                                                <div class="price">
                                                                    <ins><span class="price-amount" style="color: #ff0000"><s>Price: <span class="currencySymbol"></span>${p.getPrice() + 95}00VND</s></span></ins><br>
                                                                    <ins><span class="price-amount" style="color: #1abd0b;">PriceSell: <span class="currencySymbol"></span>${p.getPrice()}00VND</span></ins>
                                                                </div>
                                                                <div class="price">
                                                                    <a href="./AddToCart?pid=${p.getId()}&quantity=1&url=HomePage" style="color: #000000; border-bottom: 1px solid #000000;">Add to cart</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
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
    </body>

</html>
