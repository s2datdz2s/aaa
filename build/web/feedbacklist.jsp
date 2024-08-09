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
        <c:if test="${param['index']==null }">   
            <c:set var = "index" scope = "page" value = "1"/>
        </c:if>
        <c:if test="${param['index']!=null}">
            <c:set var = "index" scope = "page" value = "${param['index']}"/>
        </c:if>
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
                        <c:if test="${sessionScope['account'].getRoles().getId()==4}">
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
                        <!--                        <li >
                                                    <a style="text-decoration: none;" href="BannerManager"> Manage Banner</a>
                                                </li>-->
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
                        <h1 style="text-align: center;">Feedback List</h1>
                        <div class="panel">

                            <!-- <div class="box-header"> -->
                            <!-- <h3 class="box-title">Responsive Hover Table</h3> -->

                            <!-- </div> -->
                            <div class="panel-body table-responsive">
                                <div class="sliderList">
                                    <div class="input-group" style="margin-bottom: 10px;width: 100%; ">
                                        <form class="search-slider"
                                              style="width: 100%; display: flex; justify-content: space-between; position: relative;"
                                              method="get" action="FeedbackList">
                                            <select  name="star" style="display: inline-block; width: 135px;">
                                                <option value="" ${param['star']==""?'selected':''}>All Rate Star</option>
                                                <option value="1" ${param['star']==1?'selected':''}>1</option>
                                                <option value="2" ${param['star']==2?'selected':''}>2</option>
                                                <option value="3" ${param['star']==3?'selected':''}>3</option>
                                                <option value="4" ${param['star']==4?'selected':''}>4</option>
                                                <option value="5" ${param['star']==5?'selected':''}>5</option>
                                            </select>
                                            <select  name="status" style="display: inline-block; width: 110px;">
                                                <option value="">All Status</option>
                                                <option value="1" ${param['status']=="1"?'selected':''}>Active</option>
                                                <option value="0"${param['status']=="0"?'selected':''}>Inactive</option>
                                            </select>
                                            <input type="text" name="search"  class="form-control"
                                                   style="width: 250px;" placeholder="Search" value="${param['search']}"/>
                                            <select name="type-search" 
                                                    style="display: inline-block; width: 90px; border:none; position:absolute; right:50px;top:2px;">
                                                <option value="0" ${param['type-search']==0?'selected':''}>Fullname</option>
                                                <option value="1" ${param['type-search']==1?'selected':''}>Product</option>
                                            </select>
                                            <button class="btn btn-default">Find</button>
                                        </form>
                                    </div>
                                    <table class="panel-body table-responsive" id="slidetable" cellspacing="0" style="width: 100%;">
                                        <thead>
                                            <tr style="cursor: pointer; font-size: 15px; border-bottom: 1px solid #ccc; text-align: center;">
                                                <th>ID <i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                <th>Fullname <i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                <th>Image</th>
                                                <th>Product <i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                <th>Rated star <i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                <th>Status 
                                                    <i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                <th  width="3%">Edit</th>
                                                <th  width="3%">View</th>
                                                <th width="3%">Switch</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="f" items="${feedbackList}">
                                                <tr>
                                                    <td>${f.feedback_id}</td>
                                                    <td>${f.user.name}</td>
                                                    <td><img src="img/${f.product.img}" width="100px"></td>
                                                    <td>${f.product.name}</td>
                                                    <td>${f.rated}</td>
                                                    <c:if test="${f.active}">
                                                        <td><span class="label label-success" style="font-size: 15px">Acive</span></td>
                                                    </c:if>
                                                    <c:if test="${!f.active}">
                                                        <td><span class="label label-danger" style="font-size: 15px">Inacive</span></td>
                                                    </c:if>
                                                    <td><a class="btn btn-primary"  data-toggle="modal" data-target="#EditModalUP${f.feedback_id}"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a></td>
                                                    <td><a class="btn btn-danger" data-toggle="modal" data-target="#View${f.feedback_id}"><i class="fa fa-eye" aria-hidden="true"></i></a></td>
                                                            <c:if test="${f.active==true}">
                                                        <td><a class="btn btn-warning" href="FeedbackList?action=switch&fid=${f.feedback_id}&status=0">InActive</a></td>
                                                    </c:if>
                                                    <c:if test="${f.active==false}">
                                                        <td><a class="btn btn-success" href="FeedbackList?action=switch&fid=${f.feedback_id}&status=1">Active</a></td>
                                                    </c:if>
                                                </tr>
                                                <!-- Show detail modal -->

                                            <div class="modal fade" id="EditModalUP${f.feedback_id}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                                 data-keyboard="false">
                                                <div class="modal-dialog modal-dialog-centered" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-body">
                                                            <form action="FeedbackList">
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
                                                                        <label class="control-label">Fullname</label>
                                                                        <input class="form-control" type="text" readonly="" value="${f.user.name}">
                                                                        <input class="form-control" type="hidden" name="fid" readonly="" value="${f.feedback_id}">
                                                                    </div>
                                                                    <div class="form-group col-md-6">
                                                                        <label for="exampleSelect1" class="control-label">Email</label>
                                                                        <input class="form-control" type="text" id="stitle" value="${f.user.email}" readonly="">
                                                                        <span id="invalid1" style="color: red;"> </span>

                                                                    </div>
                                                                    <div class="form-group col-md-6">
                                                                        <label class="control-label">Phone</label>
                                                                        <input class="form-control" type="text" readonly="" value="${f.user.phone}">
                                                                    </div>
                                                                    <div class="form-group col-md-6">
                                                                        <label for="exampleSelect1" class="control-label">Rate Star</label>
                                                                        <input class="form-control" type="text" value="${f.rated}" readonly="">
                                                                        <span id="invalid1" style="color: red;"> </span>

                                                                    </div>
                                                                    <div class="form-group col-md-12">
                                                                        <label class="control-label">Feedback</label>
                                                                        <textarea readonly="" class="form-control" >${f.fb_content}</textarea>
                                                                        <span id="invalid3" style="color: red;"> </span>
                                                                    </div><div class="form-group col-md-12" style="
                                                                               text-align: center;
                                                                               ">
                                                                        <label class="control-label">Image</label>
                                                                        <img src="${f.image}" alt="" width="150">
                                                                        <span id="invalid3" style="color: red;"> </span>
                                                                    </div>

                                                                    <div class="form-group col-md-12" style="
                                                                         text-align: center;
                                                                         ">
                                                                        <label class="control-label">Status</label><br>
                                                                        <input  type="radio" name="status" required="" value="1" ${f.active?"checked":""}>Active
                                                                        <input  type="radio" name="status" required="" value="0" ${f.active==false?"checked":""}> Inactive
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

                                            <div class="modal fade" id="View${f.feedback_id}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
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
                                                                    <label class="control-label">Fullname</label>
                                                                    <input class="form-control" type="text" readonly="" value="${f.user.name}">
                                                                </div>
                                                                <div class="form-group col-md-6">
                                                                    <label for="exampleSelect1" class="control-label">Email</label>
                                                                    <input class="form-control" type="text" value="${f.user.email}" readonly="">
                                                                    <span id="invalid1" style="color: red;"> </span>

                                                                </div>
                                                                <div class="form-group col-md-6">
                                                                    <label class="control-label">Phone</label>
                                                                    <input class="form-control" type="text" readonly="" value="${f.user.phone}">
                                                                </div>
                                                                <div class="form-group col-md-6">
                                                                    <label for="exampleSelect1" class="control-label">Rate Star</label>
                                                                    <input class="form-control" type="text" id="stitle" value="${f.rated}" readonly="">
                                                                    <span id="invalid1" style="color: red;"> </span>

                                                                </div>
                                                                <div class="form-group col-md-12">
                                                                    <label class="control-label">Feedback</label>
                                                                    <textarea readonly="" class="form-control" >${f.fb_content}</textarea>
                                                                    <span id="invalid3" style="color: red;"> </span>
                                                                </div><div class="form-group col-md-12" style="
                                                                           text-align: center;
                                                                           ">
                                                                    <label class="control-label">Image</label>
                                                                    <img src="${f.image}" alt="" width="150">
                                                                    <span id="invalid3" style="color: red;"> </span>
                                                                </div>



                                                            </div>
                                                            <div class="form-group col-md-12" style="
                                                                 text-align: center;
                                                                 ">
                                                                <label class="control-label">Status: </label> 
                                                                <c:if test="${f.active}">
                                                                    <span class="label label-success" style="font-size: 15px">Active</span>
                                                                </c:if>
                                                                <c:if test="${f.active==false}">
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
                                    <div class="pagination-arena " style="margin-left: 40%">
                                        <ul class="pagination">
                                            <li class="page-item"><a href="./FeedbackList?star=${param['star']}&status=${param['status']}&search=${param['search']}&type-search=${param['type-search']}&index=1"" class="page-link"><i class="fa fa-angle-left" aria-hidden="true"></i></a></li>
                                            <li class="page-item">
                                                <a href="./FeedbackList?star=${param['star']}&status=${param['status']}&search=${param['search']}&type-search=${param['type-search']}&index=${index-2}"" class="page-link " style="${index-2<1?"display:none;":""}">${index-2}</a></li>
                                            <li class="page-item">
                                                <a href="./FeedbackList?star=${param['star']}&status=${param['status']}&search=${param['search']}&type-search=${param['type-search']}&index=${index-1}"" class="page-link " style="${index-1<1?"display:none;":""}">${index-1}</a></li>
                                            <li class="page-item active">
                                                <a href="./FeedbackList?star=${param['star']}&status=${param['status']}&search=${param['search']}&type-search=${param['type-search']}&index=${index}"" class="page-link">${index}</a></li>
                                            <li class="page-item">
                                                <a href="./FeedbackList?star=${param['star']}&status=${param['status']}&search=${param['search']}&type-search=${param['type-search']}&index=${index+1}"" class="page-link " style="${index+1>numberPage?"display:none;":""}" >${index+1}</a></li>
                                            <li class="page-item">
                                                <a href="./FeedbackList?star=${param['star']}&status=${param['status']}&search=${param['search']}&type-search=${param['type-search']}&index=${index+2}"" class="page-link " style="${index+2>numberPage?"display:none;":""}">${index+2}</a></li>
                                            <li><a href="./FeedbackList?star=${param['star']}&status=${param['status']}&search=${param['search']}&type-search=${param['type-search']}&index=${numberPage}"" class="page-link"><i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
                                        </ul>
                                    </div> 
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- Scroll Top Button -->
        <a class="btn-scroll-top"><i class="biolife-icon icon-left-arrow"></i></a>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
        <script>
            $(document).ready(function () {
                $("#slidetable").DataTable({bFilter: false, bInfo: false, paging: false});
            });
        </script>
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