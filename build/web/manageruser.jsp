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
        <!--<link rel="stylesheet" href="assets/css/style.css">-->
        <link rel="stylesheet" href="assets/css/main-color.css">

    </head>

    <body class="biolife-body">

        <nav class="navbar navbar-default">
            <div class="container">

                <!-- BRAND -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#alignment-example" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                    </button>
                    <a class="navbar-brand" href="HomePage">Online Shop</a>
                </div>
                <!-- COLLAPSIBLE NAVBAR -->
                <div class="collapse navbar-collapse" id="alignment-example">

                    <!-- Links -->
                    <ul class="nav navbar-nav">

                        <c:if test="${sessionScope['account'].getRoles().getId()==2}">
                            <li>
                                <a style="text-decoration: none;" href="ManagerUser"> Manage User</a>
                            </li>
                            <li>

                            <li>
                                <a style="text-decoration: none;" href="ManagerAdmin"> Manage Admin</a>
                            </li>  
                            <!--                            <li>
                                                            <a style="text-decoration: none;" href="productlist">  list</a>
                                                        </li>  -->

                        </c:if>
                       
                        <li >
                            <a style="text-decoration: none;" href="ManagerProduct"> Manage Product</a>
                        </li>
                        <li >
                            <a style="text-decoration: none;" href="ManagerOrder"> Manage Order</a>
                        </li>
                        <li>
                            <a style="text-decoration: none;" href="CategoryManager"> Manage Category</a>
                        </li>
                        <li>
                            <a style="text-decoration: none;" href="FeedbackList"> Manage Feedbacks </a>
                        </li>
                       <li >
                            <a style="text-decoration: none;" href="ManageBanner"> Manage Banner</a>
                        </li>
                        <li >
                            <a style="text-decoration: none;" href="HomePage">Back</a>
                        </li>
                    </ul>
                </div>

            </div>
        </nav>
        <!-- Main content -->
        <div id="main-content" class="main-content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <h1 style="text-align: center;">Manager User</h1>
                        <div>
                            Total Account: <input type="text" style="width: 50px" value="${numberOfUsers}" name="total" class="" readonly>
                        </div> 
                        <form >
                            <div class="modal-header">
                                <a class="btn btn-submit " href="addAccount.jsp"  id="btnLogin" type="submit" name="add">Add New User</a>
                            </div>   
                        </form>
                        <form method="get" action="ManagerUser" style="width: 90%; padding: 15px; display: flex; justify-content: space-between">
                            <!-- Add your form fields here -->
                            <form method="get" action="ManagerUser" style="width: 90%; padding: 15px; display: flex; justify-content: space-between">
                                <div>
                                    <label >Gender:</label>
                                    <div>
                                        <select name="uid">
                                            <option value="">Select</option>
                                            <option value="1">Male</option>
                                            <option value="0">Female</option>                                
                                        </select>

                                    </div>
                                </div>
                                <div>
                                    <label >Search:</label>
                                    <div>
                                        <input type="text" style="width: 250px" placeholder="Search by username, phone, address" value="${param["search"]}" name="search" class="form-control">
                                    </div>
                                </div>

                                <input class="btn btn-primary" type="submit" value="Find" style="margin-top: 10px; ">


                            </form>
                            <table class="table" style="margin-top: 20px; margin-bottom: 20px;">
                                <thead>
                                    <tr style="font-size: 20px;">
                                        <th scope="col">Select</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Gender</th>
                                        <th scope="col">Phone</th>
                                        <th scope="col" style="text-align: center">Action</th>
                                        <th scope="col" style="text-align: center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${userList}">
                                        <tr>
                                            <td><input type="checkbox" name="selectedUser" value="${p.getId()}"></td>
                                            <td>${p.getName()}</td>
                                            <td>${p.getEmail()}</td>
                                            <td>${p.getAddress()}</td>
                                            <td>${p.getGender() ? "Male" : "Female"}</td>
                                            <td>${p.getPhone()}</td>
                                            <td><a href="EditAccount?pid=${p.getId()}" class="btn btn-info btn-lg" style="display: block;">Update</a></td>
                                            <td><a href="DeleteUser?id=${p.getId()}" class="btn btn-danger btn-lg" style="display: block;">Delete</a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                    </div>
                </div>
                <div style="display: flex; justify-content: center;">
                    <ul class="pagination">
                        <c:forEach var="i" begin="1" end="${numberPage}">
                            <li class="${currentPage == i ? 'page-item active' : 'page-item'}">
                                <a href="ManagerUser?index=${i}" class="page-link">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

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