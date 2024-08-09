<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <style>
        figure.zoom {
            --bg-x: 50%;
            --bg-y: 50%;
            background-position: var(--bg-x) var(--bg-y);
            position: relative;
            width: 300px;
            height: 400px;
            overflow: hidden;
            cursor: zoom-in;
        }
        figure.zoom img {
            transition: opacity .5s;
            display: block;
            width: 100%;
        }
        figure.zoom img:hover {
            opacity: 0;
        }
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
        *{
            margin: 0;
            padding: 0;
        }
        .rate {
            float: left;
            height: 46px;
            padding: 0 10px;
        }
        .rate:not(:checked) > input {
            position:absolute;
            top:-9999px;
        }
        .rate:not(:checked) > label {
            float:right;
            width:1em;
            overflow:hidden;
            white-space:nowrap;
            cursor:pointer;
            font-size:30px;
            color:#ccc;
        }
        .rate:not(:checked) > label:before {
            content: '★ ';
        }
        .rate > input:checked ~ label {
            color: #ffc700;
        }
        .rate:not(:checked) > label:hover,
        .rate:not(:checked) > label:hover ~ label {
            color: #deb217;
        }
        .rate > input:checked + label:hover,
        .rate > input:checked + label:hover ~ label,
        .rate > input:checked ~ label:hover,
        .rate > input:checked ~ label:hover ~ label,
        .rate > label:hover ~ input:checked ~ label {
            color: #c59b08;
        }

    </style>

    <body class="biolife-body">

        <jsp:include page="header.jsp"/>



        <div class="page-contain single-product">
            <div class="container">



                <!-- Main content -->
                <div id="main-content" class="main-content">
                    <h1 style="text-align: center;"> Product details </h1>

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

                    <!-- summary info -->
                    <div style="display: flex; justify-content: space-around">
                        <div class="media" style="width: 40%">

<!--                            <figure class='zoom' style="background: url(img/${p.getImg()})" onmousemove="zoom(event)" >
                                <img src="img/${p.getImg()}" alt="" width="300" height="300"><br> 
                            </figure>-->

                            <img src="img/${p.getImg()}" alt="" width="300" height="300"><br> 
                            <div>
                                <a href="./ProductDetails?pid=${p.getId()}">
                                    <img src="img/${p.getImg()}" alt="" width="50" height="50">
                                </a>

                                <c:forEach var="o" items="${o}">


                                    <a href="./ProductDetails2?pid=${p.getId()}&mod=${o.getImage_id()}">
                                        <img src="img/${o.getImage_link()}" alt="" width="50" height="50">
                                    </a>
                                </c:forEach>

                            </div>
                        </div>

                        <div class="product-attribute" style="width: 50%">
                            <h2 class="title">Product Name: ${p.getName()}</h2>
                            <div class="rating">
                            </div>
                            <span class="sku"><p style="font-size: 20px;line-height: 20px">
                                <p  style="font-size: 20px;">     <b>Category:</b> ${p.getCategory().getName()} </p> 

                                <p style="font-size: 20px;">    <b>Product information:</b> ${p.getDescription()}</p> 
                                </p>
                            </span>
                            <div class="price">
                                <ins><span class="price-amount" style="color: #ff0000"><s>Price: <span class="currencySymbol"></span>${p.getPrice()+95}00VND</s></span></ins><br>
                                <ins><span class="price-amount" style="color: #1abd0b;" >PriceSell: <span class="currencySymbol"></span>${p.getPrice()}00VND</span></ins>
                            </div>
                            <form action="./AddToCart" method="post">
                                <div class="quantity-box">
                                    <span class="title">Quantity: 
                                        <input type="hidden" value="${p.getId()}" name="pid">
                                        <input type="hidden" value="ProductDetails" name="url">
                                    </span>
                                    <input type="number" class="form-control" style="width: 90px;margin: 10px 0px;" name="quantity" value="1" max="100" min="1" data-step="1">
                                </div>
                                <div class="buttons" >
                                    <c:choose>
                                        <c:when test="${p.getStock() > 0}">
                                            <a href="./AddToCart?pid=${p.getId()}&quantity=1&url=ProductDetails" class="btn btn-primary"><i class="fa fa-cart-arrow-down" aria-hidden="true"></i> Add to cart</a><br>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="btn btn-secondary">Sold Out</span><br>
                                        </c:otherwise>
                                    </c:choose>
                                            <a href="SendFeedback?pid=${p.getId()}" class="btn btn-primary" style=" margin-top: 5px;" >Send Feedback</a>
                                </div>





                            </form>
                            <hr>
                            <h1>Feedback from user</h1>
                            <div style="">
                                <c:forEach var="f" items="${fl}">
                                    <div style="display: flex; justify-content: space-between; width: 100%; margin-bottom: 10px;">
                                        <div style="display: flex;">

                                            <div style="width: 50px; margin-right: 5px;">
                                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWviOnqIDxRswOj4pkCAagxDWFdG7k3lp1jeV-4WWcJvOQTfcpaRxSLYQiF98NA-iGTd8&usqp=CAU" style="width: 100%; border-radius: 50%"> 
                                            </div>
                                            <div >
                                                <p style="color: black; margin-top: 13px">${f.user.name}</p>
                                                <p style="color: gray">Date: ${f.feedback_date}</p>
                                                <p style="color: gray">Content: ${f.fb_content}</p>
                                                <div class="rate">
                                                    <input type="radio" id="star5" ${f.rated==5?"checked":""} name="rate${f.feedback_id}" value="5" />
                                                    <label for="star5" title="text">5 stars</label>
                                                    <input type="radio" id="star4" ${f.rated==4?"checked":""} name="rate${f.feedback_id}" value="4" />
                                                    <label for="star4" title="text">4 stars</label>
                                                    <input type="radio" id="star3" ${f.rated==3?"checked":""} name="rate${f.feedback_id}" value="3" />
                                                    <label for="star3" title="text">3 stars</label>
                                                    <input type="radio" id="star2" ${f.rated==2?"checked":""} name="rate${f.feedback_id}" value="2" />
                                                    <label for="star2" title="text">2 stars</label>
                                                    <input type="radio" id="star1" name="rate${f.feedback_id}"  ${f.rated==1?"checked":""} value="1" />
                                                    <label for="star1" title="text">1 star</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <div style="width: 100px">
                                                <img src="${f.image}"
                                                     style="width: 100%; "> 
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>

                        </div>




                        <!--                    <div class="biolife-tab biolife-tab-contain sm-margin-top-34px">
                                                <div class="tab-head tab-head__icon-top-layout icon-top-layout">
                                                    <h1 style="color: black; font-weight: 600;color: #05a503; border-bottom: 1px solid #7fff00 ">Newest Product</h1>
                                                    <div class="row" style="margin-bottom: 50px;">
                                                        <ul class="products-list" style="list-style: none;">
                        <c:forEach var="p" items="${plist}">
                            <li class="product-item col-lg-4 col-xs-6" style="min-height: 550px;">
                                <div class="contain-product layout-default">
                                    <div class="product-thumb">
                                        <a href="./ProductDetails?pid=${p.getId()}" class="link-to-product" style="display: block; width: 300px; height: 300px; padding: auto;">
                                            <img src="img/${p.getImg()}" alt="img" width="300" height="300" style="margin-left: 8%;">
                                        </a>
                                    </div>
                                    <div class="info">
                                        <h4 class="product-title"  style="margin-top: 25px;"><a style="color: #000000;" href="./ProductDetails?pid=${p.getId()}" class="pr-name">Name: ${p.getName()}</a></h4>
                                        <div class="price">
                                            <ins><span class="price-amount" style="color: #ff0000"><s>Price: <span class="currencySymbol"></span>${p.getPrice()+95}00VND</s></span></ins><br>
                                            <ins><span class="price-amount" style="color: #1abd0b;" >PriceSell: <span class="currencySymbol"></span>${p.getPrice()}00VND</span></ins>
    
                                        </div>
                                        <div class="price">
                                            <a href="./AddToCart?pid=${p.getId()}&quantity=1&url=HomePage" style=" color: #000000; border-bottom: 1px solid #000000;" >Add to cart</a>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
    
                    </ul>
                </div>
            </div>
        </div>-->
                        <!--                    <div style="width: 90%;margin: auto;">
                                                <h2 style="text-align: left;">Feedback</h2> 
                                                <div class="modal-body">
                                                    <form action="ProductDetails" method="post" >
                        
                        <c:if test="${sessionScope['account'].getRoles().getId()==1}">
                            <b>Comment</b><input type="text" class="form-control" name="comment" value="" required=""><br>
                            <button type="submit" class="btn btn-success" value="submit">Post</button> 
                            <input style= "display: none" type="text" class="form-control" name="id" value="${sessionScope['account'].getRoles().getId()}" readonly ><br>
                            <input type="text" style= "display: none" class="form-control" name="pid" value="${p.getId()}" readonly ><br>
    
    
                        </c:if>
    
                    </form> 
                    <table class="table" style="margin-top: 20px; margin-bottom: 20px;">
                        <thead >
                            <tr style="font-size: 20px;">
                                <th scope="col">user </th>
    
                                <th scope="col">Comment</th>
                        <c:if test="${sessionScope['account'].getRoles().getId()==2 || sessionScope['account'].getRoles().getId()==3}">
                        <th scope="col">Delete</th>
                        </c:if>
    
                </tr>
            </thead>
            <tbody>
                        <c:forEach var="f" items="${f}">
                            <tr>
    
                                <td><img style="width:50px;height:50px;"src="img/${f.getUser_id().getImg()}">${f.getUser_id().getName()}</td>
    
                                <td>${f.getComment()}</td>
    
                            <c:if test="${sessionScope['account'].getRoles().getId()==2 || sessionScope['account'].getRoles().getId()==3}">
                                <td ><a href="DeleteFeedback?pid=${f.getId()}&mod=${p.getId()}" class="btn- btn-danger  btn-lg" style="display: block;" > Delete</a></td>
                            </c:if>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
    
    
    
            </div>
        </div>
        <div style="width: 90%;margin: auto;">
                        <c:if test="${sessionScope['account'].getRoles().getId()==2 || sessionScope['account'].getRoles().getId()==3}">
                            <h2 style="text-align: left;">Manager Image</h2>
                            <a href="AddNewImage?pid=${p.getId()}" class="btn- btn-success  btn-lg" style="display: block;" > Add Image</a>
                            <table class="table" style="margin-top: 20px; margin-bottom: 20px;">
                                <thead >
                                    <tr style="font-size: 20px;">
                                        <th scope="col">Image </th>
    
    
    
                                        <th scope="col">Action</th>
    
    
                                    </tr>
                                </thead>
                                <tbody>
                            <c:forEach var="o" items="${o}">
                                <tr>
    
                                    <td><img style="width:50px;height:50px;"src="img/${o.getImage_link()}"></td>
    
                                    <td ><a href="DeleteProduct2?pid=${p.getId()}&mod=${o.getImage_id()}" class="btn- btn-danger  btn-lg" style="display: block;" > Delete</a></td>
    
    
    
                                </tr>
                            </c:forEach>
    
                        </tbody>
                    </table>
                        </c:if>
    
    
    
    
    
                    </div>-->

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
                                function zoom(e) {
                                    var zoomer = e.currentTarget;
                                    e.offsetX ? offsetX = e.offsetX : offsetX = e.touches[0].pageX
                                    e.offsetY ? offsetY = e.offsetY : offsetX = e.touches[0].pageX
                                    x = (offsetX / zoomer.offsetWidth) * 100
                                    y = (offsetY / zoomer.offsetHeight) * 100
                                    zoomer.style.backgroundPosition = x + "% " + y + "%";
                                }
            </script>
    </body>

</html>