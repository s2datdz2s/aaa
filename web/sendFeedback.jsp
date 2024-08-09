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

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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
            .carousel-inner>.item>img,
            .carousel-inner>.item>a>img {
                width: 100%;
                margin: auto;
            }

            .sidebar {
                padding: 20px;
                background-color: #f9f9f9;
                border-right: 1px solid #ddd;
                height: 100vh;
                margin-top: 100px;
                margin-left: -200px;
            }

            .sidebar .search-box input {
                margin-bottom: 10px;
            }

            .sidebar .categories,
            .sidebar .latest-products,
            .sidebar .sort-default {
                margin-bottom: 20px;
            }

            .sidebar h2 {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .sidebar ul.list-group {
                padding-left: 0;
            }

            .sidebar ul.list-group li {
                border: none;
                padding: 5px 0;
            }

            .sidebar ul.list-group li a {
                color: #333;
                text-decoration: none;
            }

            .sidebar ul.list-group li a:hover {
                text-decoration: underline;
            }

            .product-tab {
                padding: 20px;
                width: 50%;
                margin: auto;
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

    </head>

    <body class="biolife-body">

        <jsp:include page="header.jsp" />

        <!-- Page Contain -->
        <div class="page-contain container-fluid">
            <div style="display: flex; justify-content: center;">
                <div class="feedback-content">
                    <h1>Send Feedback</h1>
                    <div class="main-content">
                        <form action="SendFeedback" method="post" onsubmit="return checkInput();">
                            <div class="product-info">
                                <h3>Product Information</h3>
                                <p><b>Name: </b>${product.getName()}</p>
                                <p><b>Price: </b>${product.getPrice()} $ </p>
                            </div>
                            <span><b>Feedback content:</b></span>
                            <textarea style="width: 100%" rows="5" name="feedbackContent" id="feedbackContent"></textarea>
                            <span id="invalid" style="color: red;"> ${sessionScope['messc']}</span>
                            <div><b>Feedback Rate: </b></div>

                            <div class="rate">
                                <input type="radio" id="star5" name="rate" value="5" />
                                <label for="star5" title="text">5 stars</label>
                                <input type="radio" id="star4" name="rate" value="4" />
                                <label for="star4" title="text">4 stars</label>
                                <input type="radio" id="star3" name="rate" value="3" />
                                <label for="star3" title="text">3 stars</label>
                                <input type="radio" id="star2" name="rate" value="2" />
                                <label for="star2" title="text">2 stars</label>
                                <input type="radio" id="star1" name="rate" value="1" />
                                <label for="star1" title="text">1 star</label>
                            </div><br><br>
                            <div style="display: flex; justify-content: left;">
                                <span style="height: 10px; width: 10px"><b>  </b></span>

                            </div>
                            <div style="display: flex; justify-content: left;">
                                <span><b>Feedback Image:  </b></span>

                            </div>
                            <input type="file" id="fbimg" name="fbimg" onchange="changeFbimg()" accept=".jpg, .jpeg, .png"><br>

                            <span  id="invalid1" style="color: red;" > </span><br>
                            <input name="img" id="sendimg" type="hidden" >
                            <input name="pid" value="${product.getId()}" type="hidden">
                            <input type="submit" value="Submit" class="btn btn-primary" >

                        </form>
                    </div>
                </div>
            </div>

        </div>
        <script>
            function checkInput() {
                var content = document.getElementById("feedbackContent");
                var img = document.getElementById("fbimg");
                console.log(1);
                var a = 0;
                if (content.value == "") {
                    document.getElementById("invalid").innerHTML = "Content of feedback not allow empty!"
                    a = 1;
                }
                if (content.value.length > 200) {
                    document.getElementById("invalid").innerHTML = "Content of feedback must less than 200 character!"
                    a = 1;
                }
                if (img.value == "") {
                    document.getElementById("invalid1").innerHTML = "Please choose 1 picture!"
                    a = 1;
                }
                console.log(1);
                if (a == 1) {
                    return false;
                } else {
                    return true;
                }

            }
            function changeFbimg() {
                var file = document.getElementById("fbimg").files[0];
                if (file.name.match(/.+\.(jpg|png|jpeg)/i)) {
                    if (file.size / (1024 * 1024) < 5) {
                        var fileReader = new FileReader();
                        fileReader.readAsDataURL(file);
                        fileReader.onload = function () {
                            document.getElementById("sendimg").value = (fileReader.result);
                        }
                    } else {
                        uploadError();
                    }
                } else {
                    uploadError();
                }
            }
            function uploadError() {
                alert('Please upload photo file < 5MB')
                document.getElementById("fbimg").files[0].value = ''
                document.getElementById("fbimg").type = '';
                document.getElementById("fbimg").type = 'file';
            }
            function  checksubmit() {
                if (document.getElementById("feedbackContent").value.length > 200) {
                    document.getElementById('invalid').style.display = "block";
                    return false;
                }
                if (document.getElementById("fbimg").value == "") {
                    document.getElementById('invalid2').style.display = "block";
                    return false;
                }
                return true;
            }
        </script>
    </body>

</html>