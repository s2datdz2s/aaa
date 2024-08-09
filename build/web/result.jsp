<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Biolife - Organic </title>
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
        <meta charset="UTF-8">
        <title>Result</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            .success-message, .error-message {
                margin-top: 50px;
                text-align: center;
            }
            .success-message i, .error-message i {
                font-size: 48px;
            }
            @keyframes shake {
                0% {
                    transform: translateX(0);
                }
                20% {
                    transform: translateX(-5px);
                }
                40% {
                    transform: translateX(5px);
                }
                60% {
                    transform: translateX(-5px);
                }
                80% {
                    transform: translateX(5px);
                }
                100% {
                    transform: translateX(0);
                }
            }

            .animated-icon {
                animation: shake 4s infinite;
            }
        </style>
    </head>
    <body class="biolife-body">
        <jsp:include page="header.jsp"/>
        <%
            String orderResult = (String) session.getAttribute("orderResult");
            if ("success".equals(orderResult)) {
        %>
        <div class="success-message">
            <i class="fas fa-check-circle animated-icon" style="color: green;"></i>
            <h1>Order placed successfully!</h1>
            <p style="text-align: center;font-size: 16px">Please follow your order regularly to update the order status.</p>
        </div>
        <div style="text-align: center; margin-top: 20px;">
            <button onclick="window.location.href = 'HomePage'; sessionStorage.removeItem('orderResult');" class="btn btn-primary" style="background-color: green;">Back to Home</button>
            <button onclick="window.location.href = 'MyOrder'; sessionStorage.removeItem('orderResult');" class="btn btn-secondary">Back to My Order</button>
        </div>
        <% } else if ("error".equals(orderResult)) { %>
        <div class="error-message">
            <i class="fas fa-exclamation-circle animated-icon" style="color: red;"></i>
            <h1>Error occurred while placing the order!</h1>
            <p style="text-align: center; font-size: 16px">Contact us for immediate assistance.</p>
        </div>
        <div style="text-align: center; margin-top: 20px;">
            <button onclick="window.location.href = 'HomePage'; sessionStorage.removeItem('orderResult');" class="btn btn-primary" style="background-color: green;">Back to Home</button>
            <button onclick="window.location.href = 'MyOrder'; sessionStorage.removeItem('orderResult');" class="btn btn-secondary">Back to My Order</button>
        </div>
        <% } %>
        <div style="margin-bottom: 185px;">
            <!-- Nội dung của div -->
        </div>

        <jsp:include page="footer.jsp"/>
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
