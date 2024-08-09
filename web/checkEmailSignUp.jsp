<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registration Successful</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 50%;
                margin: auto;
                background-color: #fff;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-top: 50px;
                border-radius: 8px;
            }
            .success-message {
                text-align: center;
                color: #4CAF50;
            }
            .details {
                margin-top: 20px;
                text-align: center;
            }
            a {
                color: #4CAF50;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1 class="success-message">Registration Successful!</h1>
            <div class="details">
                <p>Thank you for registering. Your account has been created successfully.</p>
                <p><a href="login.jsp">Click here to login</a></p>
            </div>
        </div>
    </body>
</html>
