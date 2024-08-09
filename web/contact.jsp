<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Contact Us</title>
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
            .contact-form {
                background: #fff;
                margin-top: 50px;
                margin-bottom: 50px;
                width: 70%;
                margin-left: auto;
                margin-right: auto;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
            }
            .contact-form h2 {
                padding: 20px 40px;
                background: #007bff;
                color: #fff;
                font-weight: 600;
                margin-bottom: 0;
            }
            .contact-form form {
                padding: 30px 40px;
            }
            .contact-form .form-control {
                margin-bottom: 10px;
            }
            .contact-form button {
                background: #28a745;
                color: #fff;
                padding: 10px 20px;
                border: none;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="contact-form">
            <h2>Contact Us</h2>
            <form action="ContactServlet" method="post">
                <div class="form-group">
                    <label for="name">Liên hệ:</label>
                    <p>
                        Bạn có bất kì thắc mắc nào hãy liên hệ với:</p><br>
                    <p>SDT:0387206430</p><br>
                    <p>  Email:Datlhhe173006@fpt.edu.vn</p><br>
                    <p>Facebook:https://www.facebook.com/profile.php?id=100033129942522</p><br>
                    <p> Chúng tôi luôn lắng nghe và giải quyết mọi thắc mắc và chúng tôi sẽ giải quyết chúng nhanh nhất có thể</p><br>

                    
                </div>

            </form>
        </div>
        <jsp:include page="footer.jsp" />
        <script src="assets/js/jquery-3.4.1.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
    </body>
</html>
