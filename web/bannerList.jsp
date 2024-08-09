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

                <div class="row" >

                    <div class="col-md-12">
                        <h1 style="text-align: center;">Manager Banner</h1>
                        <form method="get" action="ManageBanner" class="row" style="width: 90%; padding: 15px; display: flex; justify-content: space-between">
                            <div class="col-md-4">
                                <label >Status:</label>
                                <div>
                                    <select  class="form-control" style="display: block;" name="status" onchange="this.form.submit()" >
                                        <option value="">All</option>
                                        <option value="1" ${param['status']=="1"?"selected":""} >Active </option>
                                        <option value="0" ${param['status']=="0"?"selected":""} >Inactive </option>
                                    </select>

                                </div>

                            </div>
                            <div class="col-md-4">
                                <label >Search:</label>
                                <div>
                                    <input type="hidden" name="index" value="1">
                                    <input type="text" style="width: 250px" placeholder="Search title or backlink" value="${param["search"]}" name="search" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-4">

                                <input class="btn btn-primary" type="submit" value="Find" style="margin-top: 10px; ">
                            </div>


                        </form>

                        <table class="table" style="margin-top: 20px; margin-bottom: 20px;">
                            <thead >
                                <tr style="font-size: 20px;">
                                    <th scope="col">ID</th>
                                    <th scope="col">Title</th>
                                    <th scope="col">Image</th>
                                    <th scope="col">Backlink</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Create Date</th>

                                    <th scope="col" colspan="2" style="text-align: center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${bl}">
                                    <tr>
                                        <th scope="row">${p.getId()}</th>
                                        <td>${p.getTitle()}</td>
                                        <td>      
                                            <img style="width:150px;"src="img/${p.getImg()}">
                                        </td>
                                        <td>${p.getBackLink()}</td>
                                        <td>${p.isStatus()>=true?"Active":"Inactive"}</td>

                                        <td>${p.getCreated_on()}</td>


                                        <td ><a href="DeleteBanner?bid=${p.getId()}" class="btn- btn-danger  btn-lg" style="display: block;" > Delete</a></td>
                                        <td><a class="btn btn-primary"  data-toggle="modal" data-target="#EditModalUP${p.getId()}"><i class="fa fa-pencil-square-o" ></i></a></td>
                                         <td><a class="btn btn-danger" data-toggle="modal" data-target="#View${p.getId()}"><i class="fa fa-eye"></i></a></td>
                                                <c:if test="${p.isStatus()==true}">
                                            <td><a class="btn btn-warning" href="ManageBanner?action=switch&fid=${p.getId()}&status=0">InActive</a></td>
                                        </c:if>
                                        <c:if test="${p.isStatus()==false}">
                                            <td><a class="btn btn-success" href="ManageBanner?action=switch&fid=${p.getId()}&status=1">Active</a></td>
                                        </c:if>

                                    </tr>
                                <div class="modal fade" id="EditModalUP${p.getId()}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                     data-keyboard="false">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-body">
                                                <form action="ManageBanner">
                                                    <input type="hidden" readonly="" name="action" value="edit">
                                                    <div class="row">
                                                        <div class="form-group  col-md-12">
                                                            <span class="thong-tin-thanh-toan">
                                                                <h5>Edit Feedback Information</h5>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Title</label>
                                                            <input class="form-control" type="text" readonly="" value="${p.getTitle()}">
                                                            <input class="form-control" type="hidden" name="fid" readonly="" value="${p.getId()}">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label for="exampleSelect1" class="control-label">Backlink</label>
                                                            <input class="form-control" type="text" id="stitle" value="${p.getBackLink()}" readonly="">
                                                            <span id="invalid1" style="color: red;"> </span>

                                                        </div>



                                                        <b>Img: </b><img style="width:150px;height:150px;"src="img/${p.getImg()}"><br>

                                                        <div class="form-group col-md-12" style="
                                                             text-align: center;
                                                             ">
                                                            <label class="control-label">Status</label><br>
                                                            <input  type="radio" name="status" required="" value="1" ${p.isStatus()?"checked":""}> Inactive
                                                            <input  type="radio" name="status" required="" value="0" ${p.isStatus()==false?"checked":""}> Active
                                                        </div>
                                                        

                                                    </div>
                                                    <br>
                                                    <input class="btn btn-primary" type="submit" value="Save">
                                                    <a class="btn btn-danger" data-dismiss="modal" href="#">Cancel</a>
                                                    <br>
                                                </form>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="View${p.getId()}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                     data-keyboard="false">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="form-group  col-md-12">
                                                        <span class="thong-tin-thanh-toan">
                                                            <h5>View Feedback Information</h5>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label class="control-label">Title</label>
                                                        <input class="form-control" type="text" readonly="" value="${p.getTitle()}">
                                                        <input class="form-control" type="hidden" name="fid" readonly="" value="${p.getId()}">
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="exampleSelect1" class="control-label">Backlink</label>
                                                        <input class="form-control" type="text" id="stitle" value="${p.getBackLink()}" readonly="">
                                                        <span id="invalid1" style="color: red;"> </span>

                                                    </div>



                                                    <b>Img: </b><img style="width:150px;height:150px;"src="img/${p.getImg()}"><br>

                                                    
                                                    

                                                </div>
                                                <div class="form-group col-md-12" style="
                                                     text-align: center;
                                                     ">
                                                    <label class="control-label">Status: </label> 
                                                    <c:if test="${p.isStatus()}">
                                                        <span class="label label-success" style="font-size: 15px">Active</span>
                                                    </c:if>
                                                    <c:if test="${p.isStatus()==false}">
                                                        <span class="label label-danger" style="font-size: 15px">False</span>
                                                    </c:if>

                                                </div>

                                                <br>
                                                <a class="btn btn-danger" data-dismiss="modal" href="#">Close</a>
                                                <br>


                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </c:forEach>
                            </tbody>
                        </table>
                        <div style="display: flex; justify-content: center;">
                            <ul class="pagination" >
                                <li  class="page-item next"><a href="ManagerProduct?index=1&search=${param['search']}&status=${param['status']}"><i class="fa fa-angle-left" class="page-link" aria-hidden="true"></i></a></li>
                                        <c:forEach var = "i" begin = "1" end = "${numberPage}">
                                    <li class="${index==i?'page-item active':'page-item'}"><a href="ManagerProduct?index=${i}&search=${param['search']}&status=${param['status']}"   class="page-link">${i}</a></li>
                                    </c:forEach>
                                <li  class="page-item next"><a href="ManagerProduct?index=${numberPage}&search=${param['search']}&status=${param['status']}"><i class="fa fa-angle-right" class="page-link" aria-hidden="true"></i></a></li>
                            </ul>
                        </div>
                    </div>
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
        <script>function displayImage(input) {
                                            var previewImage = document.getElementById("previewImage");
                                            var file = input.files[0];
                                            var reader = new FileReader();

                                            reader.onload = function (e) {
                                                previewImage.src = e.target.result;
                                                previewImage.style.display = "block";
                                            }

                                            reader.readAsDataURL(file);
                                        }

        </script>

    </body>

</html>