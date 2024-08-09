<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>About Us</title>
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
/*            body {
                font-family: 'Poppins', sans-serif;
            }*/
            .about-section {
                background: #f7f7f7;
                padding: 50px;
                margin-top: 50px;
                margin-bottom: 50px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
            }
            .about-section h2 {
                color: #007bff;
                font-weight: 600;
                margin-bottom: 20px;
            }
            .about-section p {
                font-size: 18px;
                line-height: 1.6;
                color: #555;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="about-section">
            <h2>About Us</h2>
            <p>
                Welcome to The Perfume Store, your number one source for perfumes. We are dedicated to providing you with the best products, focusing on reliability, customer service and uniqueness.
            </p>
            <p>
                Established in 2024 by group 3 class SE1714, Flower Shop has come a long way since its beginning. When we first started, their passion for eco-friendly products motivated them to start their own business.
            </p>
            <p>
                We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please contact us.
            </p>
            <p>
                Sincerely:<br>
                Group 3
            </p>
        </div>
        <jsp:include page="footer.jsp" />
        <script src="assets/js/jquery-3.4.1.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
    </body>
</html>
