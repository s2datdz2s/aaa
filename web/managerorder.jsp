<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<!-- Định nghĩa HTML và thiết lập ngôn ngữ là tiếng Anh -->
<html class="no-js" lang="en">

    <head>
        <!-- Thiết lập mã ký tự và khai báo cài đặt cho trình duyệt -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Tiêu đề trang -->
        <title> Shop</title>

        <!-- Liên kết với các font chữ từ Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Cairo:400,600,700&amp;display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:600&amp;display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400i,700i" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Ubuntu&amp;display=swap" rel="stylesheet">

        <!-- Liên kết với các file CSS từ assets -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/animate.min.css">
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/nice-select.css">
        <link rel="stylesheet" href="assets/css/slick.min.css">
        <!-- <link rel="stylesheet" href="assets/css/style.css"> -->
        <link rel="stylesheet" href="assets/css/main-color.css">
    </head>
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
        .not-paying {
            color: red;
        }
        .paid {
            color: green;
        }

    </style>
    <body class="biolife-body">

        <!-- Thẻ nav định nghĩa thanh điều hướng -->
        <nav class="navbar navbar-default">
            <div class="container">

                <!-- Phần đầu thanh điều hướng (BRAND) -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#alignment-example" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                    </button>
                    <!-- Liên kết đến trang chủ, thay thế cho logo -->
                    <a class="navbar-brand" href="HomePage">Online Shop</a>
                </div>

                <!-- Phần thân thanh điều hướng có thể thu gọn (COLLAPSIBLE NAVBAR) -->
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

        <!-- Phần nội dung chính -->
        <div id="main-content" class="main-content">
            <div class="container-fluid">

                <!-- Phần giao diện quản lý đơn hàng -->
                <div class="row">
                    <div class="col-md-12">
                        <h1 style="text-align: center;">Manager Order</h1>

                        <!-- Form tìm kiếm và lọc đơn hàng -->
                        <form method="get" action="ManagerOrder" style="width: 90%; padding: 15px; display: flex; justify-content: space-between">
                            <div>
                                <label>Status:</label>
                                <div>
                                    <!-- Dropdown để lọc theo trạng thái đơn hàng -->
                                    <select name="status">
                                        <option value="">All</option>
                                        <option value="1">Pending</option>
                                        <option value="2">Shipping</option>
                                        <option value="3">Delivered</option>
                                        <option value="4">Canceled</option>
                                    </select>
                                </div>
                            </div>
                            <div>
                                <label>Search:</label>
                                <div>
                                    <!-- Ô nhập liệu để tìm kiếm theo tên người dùng, số điện thoại, địa chỉ, orderId -->
                                    <input type="text" style="width: 250px" placeholder="Search by username, phone, address, orderId" value="${param["search"]}" name="search" class="form-control">
                                </div>
                            </div>
                            <div>
                                <label>From date:</label>
                                <!-- Ô nhập liệu để chọn ngày bắt đầu -->
                                <input type="date" name="fdate" value="${fdate}" class="form-control">
                            </div>
                            <div>
                                <label>To date:</label>
                                <!-- Ô nhập liệu để chọn ngày kết thúc -->
                                <input type="date" name="tdate" value="${tdate}" class="form-control">
                            </div>
                            <!-- Nút tìm kiếm -->
                            <input class="btn btn-primary" type="submit" value="Find" style="margin-top: 10px; ">
                        </form>
                    </div>
                    <c:if test="${statusErr != null}">
                        <p style="color: red">${statusErr}</p>
                    </c:if>

                    <!-- Bảng hiển thị đơn hàng -->
                    <form id="orderForm" action="DeleteOrder" method="post">

                        <table class="table" style="margin-top: 20px; margin-bottom: 20px;">
                            <thead>
                                <!-- Tiêu đề cột bảng -->
                                <tr>
                                    <th>
                                        <input type="checkbox" id="selectAllCheckbox" onchange="selectAllCheckboxes()">
                                    </th>
                                    <th class="product-name">Order Id </th>
                                    <th class="product-price">Order Date</th>
                                    <th class="product-price">UserName</th>
                                    <th class="product-price">Phone</th>
                                    <th class="product-price">Address</th>
                                    <th class="product-quantity">Total Bill</th>
                                    <th class="product-subtotal">Note</th>
                                    <th class="product-subtotal">Status</th>
                                    <th class="product-subtotal">Payment Method</th>
                                    <th class="product-subtotal">Payment Status</th>
                                    <th class="product-subtotal">Details</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Vòng lặp hiển thị thông tin đơn hàng -->
                                <!-- Vòng lặp hiển thị thông tin đơn hàng -->
                                <c:forEach var="o" items="${ol}">
                                    <tr class="cart_item">
                                        <!-- Thêm checkbox -->
                                        <td class="product-checkbox">
                                            <input type="checkbox" name="orderCheckbox" value="${o.getId()}" onchange="handleCheckboxClick(this)">
                                        </td>
                                        <!-- Các cột thông tin đơn hàng -->
                                        <td class="product-thumbnail">
                                            ${o.getId()}
                                        </td>
                                        <td class="product-thumbnail">
                                            ${o.getFormattedDateTime()}
                                        </td>
                                        <td class="product-price">
                                            ${o.getUserName()}
                                        </td>
                                        <td class="product-price">
                                            ${o.getPhone()}
                                        </td>
                                        <td class="product-price">
                                            ${o.getAddress()}
                                        </td>
                                        <td class="product-quantity">
                                            ${o.getTotal()}
                                        </td>
                                        <td class="product-subtotal">
                                            ${o.getNotes()}
                                        </td>
                                        <td class="product-subtotal">
                                            <input type="hidden" class="orderid" value="${o.getId()}">
                                            <select id="statusSelect" name="status" onchange="confirmStatusUpdate(this)">
                                                <option value="1" ${o.getStatus() == 1 ? "selected" : ""} >Pending</option>
                                                <option value="2" ${o.getStatus() == 2 ? "selected" : ""} >Shipping</option> 
                                                <option value="3" ${o.getStatus() == 3 ? "selected" : ""} >Delivered</option> 
                                                <option value="4" ${o.getStatus() == 4 ? "selected" : ""} >Canceled</option>
                                            </select>
                                        </td>
                                        <td class="product-subtotal">
                                            ${o.getPaymentMethod()}
                                        </td>
                                        <td class="product-subtotal ${o.getPaymentStatus() == "Paid" ? 'paid' : 'not-paying'}">
                                            ${o.getPaymentStatus()}
                                        </td>

                                        <td class="product-subtotal">
                                            <!-- Liên kết đến trang chi tiết đơn hàng -->
                                            <a href="./OrderDetails?oid=${o.getId()}">Details</a>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="ManagerOrder?page=${currentPage - 1}&fdate=${param.fdate}&tdate=${param.tdate}&search=${param.search}&uid=${param.uid}">Previous</a>
                            </c:if>
                            <c:forEach begin="1" end="${noOfPages}" var="i">
                                <a href="ManagerOrder?page=${i}&fdate=${param.fdate}&tdate=${param.tdate}&search=${param.search}&uid=${param.uid}" class="${currentPage == i ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <c:if test="${currentPage < noOfPages}">
                                <a href="ManagerOrder?page=${currentPage + 1}&fdate=${param.fdate}&tdate=${param.tdate}&search=${param.search}&uid=${param.uid}">Next</a>
                            </c:if>
                        </div>

                        <input type="hidden" id="selectedOrderIds" name="selectedOrderIds" value="">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete selected orders?')">Delete Selected Orders</button>
                    </form>

                </div>

            </div>
        </div>

        <!-- Nút cuộn lên đầu trang -->
        <a class="btn-scroll-top"><i class="biolife-icon icon-left-arrow"></i></a>

        <!-- Liên kết với các file JavaScript từ assets -->
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
                            function cancelOrder(orderId) {
                                var confirmation = confirm("Are you sure you want to cancel this order?");
                                if (confirmation) {
                                    document.getElementById("orderIdInput").value = orderId;
                                    document.getElementById("cancelOrderForm").submit();
                                }
                            }

                            function confirmStatusUpdate(selectElement) {
                                var status = selectElement.value;
                                var orderId = selectElement.parentNode.querySelector('.orderid').value;
                                var confirmationMessage = "";

                                switch (status) {
                                    case "1":
                                        confirmationMessage = "Are you sure you want to mark this order as Pending?";
                                        break;
                                    case "2":
                                        confirmationMessage = "Are you sure you want to mark this order as Shipping?";
                                        break;
                                    case "3":
                                        confirmationMessage = "Are you sure you want to mark this order as Delivered?";
                                        break;
                                    case "4":
                                        confirmationMessage = "Are you sure you want to cancel this order?";
                                        break;
                                    case "5":
                                        confirmationMessage = "Have you received this order?";
                                        break;
                                    default:
                                        confirmationMessage = "Are you sure you want to change the status of this order?";
                                        break;
                                }

                                if (confirm(confirmationMessage)) {
                                    window.location.href = "changestatus?status=" + status + "&orderId=" + orderId;
                                } else {
                                }
                            }
        </script>





    </body>

</html>
