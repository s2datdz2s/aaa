<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="no-js" lang="en">
    <style>
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 5px;
            padding: 10px 15px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        .pagination a:hover {
            background-color: #007bff;
            color: #fff;
        }
        .pagination a.active {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
        }
        .pagination a.disabled {
            color: #ddd;
            pointer-events: none;
        }
        .error-message {
            color: red;
            font-weight: bold;
        }
    </style>
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
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/main-color.css">

    </head>

    <body class="biolife-body">

        <jsp:include page="header.jsp"/>



        <div class="page-contain login-page">

            <!-- Main content -->
            <div id="main-content" class="main-content">
                <div class="container">

                    <div class="row">

                        <div class="col-12">
                            <h3 class="box-title"  style="text-align: center">My Order List</h3>
                            <form method="get" action="DeleteOrder" style="width: 40%; padding: 15px; display: flex; justify-content: space-between">
                                <div>
                                    From date: <input type="date" name="fdate" value="${param["fdate"]}" class="form-control">
                                </div>
                                <div >  
                                    To date: <input type="date" name="tdate"  value="${param["tdate"]}" class="form-control">
                                </div>
                                <input class="btn btn-primary" type="submit" value="Find" style="margin-top: 10px; ">
                            </form>
                            <c:if test="${not empty requestScope.err}">
                                <div class="error-message">${requestScope.err}</div>
                            </c:if>

                            <table class="table table-hover table-striped" style="font-size: 20px;">
                                <thead>
                                    <tr>
                                        <th>
                                            <input type="checkbox" id="selectAllCheckbox" onchange="selectAllCheckboxes()">
                                        </th>
                                        <th class="product-name">Order Id </th>
                                        <th class="product-price">Order Date</th>
                                        <th class="product-quantity">Total Bill</th>
                                        <th class="product-subtotal">Note</th>
                                        <th class="product-subtotal">Status</th>
                                        <th class="product-subtotal">Details</th>
                                        <th class="product-subtotal">Action</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="o" items="${ol}">
                                        <tr class="cart_item">
                                            <td class="product-subtotal">
                                                <input type="checkbox" name="orderCheckbox" value="${o.getId()}" onclick="handleCheckboxClick(this)">
                                            </td>
                                            <td class="product-thumbnail" >
                                                ${o.getId()}
                                            </td>
                                            <td class="product-price" >
                                                ${o.getFormattedDateTime()}
                                            </td>
                                            <td class="product-quantity" >
                                                ${o.getTotal()}00VND

                                            </td>
                                            <td class="product-subtotal" >
                                                ${o.getNotes()}
                                            </td>
                                            <td class="product-subtotal" >
                                                ${o.getStatusName()}
                                            </td>
                                            <td class="product-subtotal" >
                                                <a href="./OrderDetails?oid=${o.getId()}">Details</a>
                                            </td>
                                            <td class="product-subtotal" >
                                                <a href="./CancelOrder?oid=${o.getId()}&status=${o.getStatus()}" class="btn btn-danger">Cancel order</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty ol}">
                                        <tr>
                                            <td colspan="8">No orders available.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                            <div class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <a href="MyOrder?page=${currentPage - 1}&fdate=${param.fdate}&tdate=${param.tdate}">Previous</a>
                                </c:if>
                                <c:forEach begin="1" end="${noOfPages}" var="i">
                                    <a href="MyOrder?page=${i}&fdate=${param.fdate}&tdate=${param.tdate}" class="${currentPage == i ? 'active' : ''}">${i}</a>
                                </c:forEach>
                                <c:if test="${currentPage < noOfPages}">
                                    <a href="MyOrder?page=${currentPage + 1}&fdate=${param.fdate}&tdate=${param.tdate}">Next</a>
                                </c:if>
                            </div>
                            <div>
                                <form method="post" action="./DeleteOrder">
                                    <input type="hidden" id="selectedOrderIds" name="selectedOrderIds" value="">
                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete selected orders?')">Delete Selected Orders</button>
                                </form>
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
        <script>
                                        function selectAllCheckboxes() {
                                            var checkboxes = document.getElementsByName("orderCheckbox");
                                            var selectAllCheckbox = document.getElementById("selectAllCheckbox");
                                            var selectedOrderIdsInput = document.getElementById("selectedOrderIds");

                                            var selectedOrderIds = [];
                                            for (var i = 0; i < checkboxes.length; i++) {
                                                checkboxes[i].checked = selectAllCheckbox.checked;

                                                if (checkboxes[i].checked) {
                                                    selectedOrderIds.push(checkboxes[i].value);
                                                }
                                            }

                                            console.log("Selected Order IDs: ", selectedOrderIds);
                                            selectedOrderIdsInput.value = selectedOrderIds.join(",");
                                        }

                                        function handleCheckboxClick(checkbox) {
                                            var selectedOrderIdsInput = document.getElementById("selectedOrderIds");

                                            var selectedOrderIds = [];
                                            var checkboxes = document.getElementsByName("orderCheckbox");

                                            for (var i = 0; i < checkboxes.length; i++) {
                                                if (checkboxes[i].checked) {
                                                    selectedOrderIds.push(checkboxes[i].value);
                                                }
                                            }

                                            console.log("Selected Order IDs: ", selectedOrderIds);
                                            selectedOrderIdsInput.value = selectedOrderIds.join(",");
                                        }
        </script>
    </body>

</html>