/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import model.*;

/**
 *
 * @author Admin
 */
public class OrderDAO extends DBContext {

    private int noOfRecords;

    //Phuong thuc de them mot don hang moi vao co so du lieu
    public void insertOrder(User u, Cart cart, String notes) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            //Theem 1 don hang moi vao co so du lieu
            String sql = "insert into [Order] ([user_id],[order_date],[total],[notes],[status]) values (?,GETDATE(), ?, ?,1)";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, u.getId());
            ps.setDouble(2, cart.getTotalMoney());
            ps.setString(3, notes);
            ps.executeUpdate();
//Lay Id don hang vua them vao de su dung cho viec them thong tin don hang
            String sql1 = "select top 1 order_id from [Order] order by order_id desc";
            ps = connection.prepareStatement(sql1);
            rs = ps.executeQuery();

            if (rs.next()) {
                int oid = rs.getInt(1);
                //Them thong tin chi tiet don hang vao bang OrderDetail cho tung san pham trong gio hang
                for (CartItem item : cart.getItems()) {
                    String sql2 = "insert into [OrderDetail] ([order_id],[product_id]  ,[price],[quantity]) values (?,?, ?, ?)";
                    ps = connection.prepareStatement(sql2);
                    ps.setInt(1, oid);
                    ps.setInt(2, item.getProduct().getId());
                    ps.setDouble(3, item.getProduct().getPrice());
                    ps.setInt(4, item.getQuantity());
                    ps.executeUpdate();
                }
            }
            // Cap nhat so luong san pham trong bang product
            String sql3 = "update [Product] set [stock] = [stock] - ? "
                    + "where product_id = ?";
            ps = connection.prepareStatement(sql3);
            for (CartItem item : cart.getItems()) {
                ps.setInt(1, item.getQuantity());
                ps.setInt(2, item.getProduct().getId());
                ps.executeUpdate();
            }

        } catch (Exception e) {
        }
    }

    public Order insertOrder1(User u, Cart cart, String notes, String paymentMethod) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        Order ordertoget = null;
        try {
            // Thêm 1 đơn hàng mới vào cơ sở dữ liệu
            String sql = "insert into [Order] ([user_id],[order_date],[total],[notes],[status],[payment_method],[payment_status]) values (?,GETDATE(), ?, ?, 1, ?, ?)";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, u.getId());
            ps.setDouble(2, cart.getTotalMoney());
            ps.setString(3, notes);
            ps.setString(4, paymentMethod);
            ps.setString(5, "Not paying");
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                // Lấy Id đơn hàng vừa thêm vào để sử dụng cho việc thêm thông tin đơn hàng
                String sql1 = "WITH OrdersWithRowNumbers AS (\n"
                        + "    SELECT \n"
                        + "        [order_id],\n"
                        + "        [user_id],\n"
                        + "        [order_date],\n"
                        + "        [total],\n"
                        + "        [notes],\n"
                        + "        [status],\n"
                        + "        ROW_NUMBER() OVER (ORDER BY order_id DESC) AS RowNum\n"
                        + "    FROM [Flower].[dbo].[Order]\n"
                        + ")\n"
                        + "SELECT \n"
                        + "    [order_id],\n"
                        + "    [user_id],\n"
                        + "    [order_date],\n"
                        + "    [total],\n"
                        + "    [notes],\n"
                        + "    [status]\n"
                        + "FROM OrdersWithRowNumbers\n"
                        + "WHERE RowNum = 1;";
                ps = connection.prepareStatement(sql1);
                rs = ps.executeQuery();

                if (rs.next()) {
                    int oid = rs.getInt(1);
                    User u1 = new User();
                    u.setId(rs.getInt(2));
                    ordertoget = new Order(oid, u1, rs.getDate(3), rs.getFloat(4), rs.getString(5), rs.getInt(6));
                    for (CartItem item : cart.getItems()) {
                        String sql2 = "insert into [OrderDetail] ([order_id],[product_id],[price],[quantity]) values (?, ?, ?, ?)";
                        ps = connection.prepareStatement(sql2);
                        ps.setInt(1, oid);
                        ps.setInt(2, item.getProduct().getId());
                        ps.setDouble(3, item.getProduct().getPrice());
                        ps.setInt(4, item.getQuantity());
                        ps.executeUpdate();
                    }
                }
                // Cập nhật số lượng sản phẩm trong bảng product
                String sql3 = "update [Product] set [stock] = [stock] - ? "
                        + "where product_id = ?";
                ps = connection.prepareStatement(sql3);
                for (CartItem item : cart.getItems()) {
                    ps.setInt(1, item.getQuantity());
                    ps.setInt(2, item.getProduct().getId());
                    ps.executeUpdate();
                }
                return ordertoget;
            }
        } catch (Exception e) {
            e.printStackTrace(); // In ra lỗi nếu có
        } finally {
            // Đóng các tài nguyên
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace(); // In ra lỗi nếu có
            }
        }
        return null;
    }

// phuong thuc lay danh sach don hang cho mot ngioi dung cu the trong khoang thoi gian nhat dinh
    public ArrayList<Order> getAllOrderByuId(int uid, String fdate, String tdate, int offset, int noOfRecords) {
        if ("".equals(fdate)) {
            fdate = "1990-01-01";
        }
        if ("".equals(tdate)) {
            tdate = "2990-01-01";
        }
        ArrayList<Order> ol = new ArrayList<>();
        String sql = "SELECT o.*, a.address "
                + "FROM [Order] o "
                + "JOIN [OrderAddress] oa ON o.order_id = oa.order_id "
                + "JOIN [Address] a ON oa.address_id = a.address_id "
                + "JOIN [Users] u ON o.user_id = u.user_id "
                + "WHERE o.user_id = ? "
                + "AND o.order_date BETWEEN ? AND ? "
                + "ORDER BY o.order_date "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, uid);
            ps.setString(2, fdate);
            ps.setString(3, tdate);
            ps.setInt(4, offset);
            ps.setInt(5, noOfRecords);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                Date orderDate = rs.getDate("order_date");
                double amount = rs.getDouble("total");
                int status = rs.getInt("status");
                int userId = rs.getInt("user_id");
                String address = rs.getString("address");
                User user = new User(userId); // Create User object from userId
                ol.add(new Order(orderId, user, orderDate, amount, status, address));
            }
            rs.close();
            ps.close();

            // Count total records
            String countSql = "SELECT COUNT(*) FROM [Order] WHERE user_id = ? AND order_date BETWEEN ? AND ?";
            PreparedStatement countPs = connection.prepareStatement(countSql);
            countPs.setInt(1, uid);
            countPs.setString(2, fdate);
            countPs.setString(3, tdate);
            ResultSet countRs = countPs.executeQuery();
            if (countRs.next()) {
                this.noOfRecords = countRs.getInt(1);
            }
            countRs.close();
            countPs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ol;
    }

    public int getNoOfRecords() {
        return noOfRecords;
    }

    public int getTotalPage(int userId, String fdate, String tdate, int pageSize) {
        if (fdate.isEmpty()) {
            fdate = "1990-01-01";
        }
        if (tdate.isEmpty()) {
            tdate = "2990-01-01";
        }
        String sql = "SELECT COUNT(*) FROM [Order] WHERE user_id = ? AND [order_date] BETWEEN ? AND ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, fdate);
            ps.setString(3, tdate);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int totalOrder = rs.getInt(1);
                return (int) Math.ceil((double) totalOrder / pageSize);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1; // Giá trị mặc định nếu không có đơn hàng nào
    }

    public int getTotalPageOfAllOrder(String fdate, String tdate, int pageSize) {
        if (fdate.isEmpty()) {
            fdate = "1990-01-01";
        }
        if (tdate.isEmpty()) {
            tdate = "2990-01-01";
        }
        String sql = "SELECT COUNT(*) FROM [Order] WHERE [order_date] BETWEEN ? AND ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, fdate);
            ps.setString(2, tdate);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int totalOrder = rs.getInt(1);
                return (int) Math.ceil((double) totalOrder / pageSize);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1; // Giá trị mặc định nếu không có đơn hàng nào
    }

    public ArrayList<Order> getAllOrder(String status, String fdate, String tdate, String search, int offset, int noOfRecords) {
        if ("".equals(fdate)) {
            fdate = "1990-01-01";
        }
        if ("".equals(tdate)) {
            tdate = "2990-01-01";
        }
        ArrayList<Order> ol = new ArrayList<>();

        String sql = "SELECT o.*, u.phone, u.user_name, a.address, o.payment_method, o.payment_status "
                + "FROM [Order] o "
                + "JOIN Users u ON o.user_id = u.user_id "
                + "JOIN OrderAddress oa ON o.order_id = oa.order_id "
                + "JOIN Address a ON oa.address_id = a.address_id "
                + "WHERE (u.user_name LIKE ? OR u.phone LIKE ? OR o.order_id LIKE ? OR a.address LIKE ?) "
                + "AND o.[order_date] BETWEEN ? AND ?";

        // Add condition for status if not null or empty
        if (status != null && !"".equals(status)) {
            sql += " AND o.status = ?";
        }

        sql += " ORDER BY o.[order_date] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        System.out.println(sql);
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + search + "%");
            ps.setString(4, "%" + search + "%");
            ps.setString(5, fdate);
            ps.setString(6, tdate);

            // Set status parameter if not null or empty
            int parameterIndex = 7;
            if (status != null && !"".equals(status)) {
                ps.setString(parameterIndex++, status);
            }

            ps.setInt(parameterIndex++, offset);
            ps.setInt(parameterIndex++, noOfRecords);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ol.add(new Order(rs.getInt(1), new User(rs.getInt(2)), rs.getDate(3), rs.getDouble(4), rs.getString(5), rs.getInt(6), rs.getString("phone"), rs.getString("user_name"), rs.getString("address"),
                        rs.getString("payment_method"),
                        rs.getString("payment_status")
                ));
            }

            // Count total records matching the criteria
            String countSql = "SELECT COUNT(*) FROM [Order] o "
                    + "JOIN OrderAddress oa ON o.order_id = oa.order_id "
                    + "JOIN Address a ON oa.address_id = a.address_id "
                    + "WHERE (u.user_name LIKE ? OR u.phone LIKE ? OR o.order_id LIKE ? OR a.address LIKE ?) "
                    + "AND o.[order_date] BETWEEN ? AND ?";
            if (status != null && !"".equals(status)) {
                countSql += " AND o.status = ?";
            }
            PreparedStatement countPs = connection.prepareStatement(countSql);
            countPs.setString(1, "%" + search + "%");
            countPs.setString(2, "%" + search + "%");
            countPs.setString(3, "%" + search + "%");
            countPs.setString(4, "%" + search + "%");
            countPs.setString(5, fdate);
            countPs.setString(6, tdate);
            if (status != null && !"".equals(status)) {
                countPs.setString(7, status);
            }
            rs = countPs.executeQuery();
            if (rs.next()) {
                this.noOfRecords = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ol;
    }

    public ArrayList<OrderDetail> getAllOrderDetailByoId(int oid) {
        ArrayList<OrderDetail> odl = new ArrayList<>();
        String sql = " SELECT  p.*, o.* FROM [OrderDetail] o, Product p where o.product_id = p.product_id and o.order_id =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, oid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), new Category(rs.getInt("category_id")), rs.getString(6), rs.getString(7), rs.getDate(8));
                odl.add(new OrderDetail(rs.getInt("detail_id"), rs.getInt("order_id"), p, rs.getDouble("price"), rs.getInt("quantity")));
            }
        } catch (Exception e) {
        }
        return odl;
    }

    public int getNumberOrder() {
        String sql = "  select count(*)from  OrderDetail";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public double getTotalProfit() {
        String sql = "  select sum(price*quantity) from OrderDetail";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public void updateStatusOrder(int status, int id) {
        try {
            String sql = "UPDATE [Order] SET status = ?, "
                    + "payment_status = CASE WHEN ? = 3 THEN 'Paid' ELSE payment_status END "
                    + "WHERE [order_id] = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, status);
            ps.setInt(3, id);
            System.out.println("Executing SQL: " + sql + " with status = " + status + " and orderId = " + id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateStatusPaymentStatus(String paymentStatus, int orderId) {
        try {
            String sql = "UPDATE [Order] SET payment_status = ?  WHERE [order_id] = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, paymentStatus);
            ps.setInt(2, orderId);
            System.out.println("Executing SQL: " + sql + " with paymentStatus = " + paymentStatus + " and orderId = " + orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }
    }

    public void deleteOrder(String[] orderIds) {
        if (orderIds == null || orderIds.length == 0) {
            return;
        }

        PreparedStatement ps = null;

        try {
            String deleteOrderDetailSql = "DELETE FROM OrderDetail WHERE order_id IN (";
            StringBuilder placeholdersDetail = new StringBuilder();
            for (int i = 0; i < orderIds.length; i++) {
                placeholdersDetail.append("?");
                if (i < orderIds.length - 1) {
                    placeholdersDetail.append(", ");
                }
            }
            deleteOrderDetailSql += placeholdersDetail.toString() + ")";

            ps = connection.prepareStatement(deleteOrderDetailSql);
            for (int i = 0; i < orderIds.length; i++) {
                if (!orderIds[i].isEmpty()) {
                    ps.setInt(i + 1, Integer.parseInt(orderIds[i]));
                }
            }
            ps.executeUpdate();

            String deleteOrderSql = "DELETE FROM [Order] WHERE order_id IN (";
            StringBuilder placeholdersOrder = new StringBuilder();
            for (int i = 0; i < orderIds.length; i++) {
                placeholdersOrder.append("?");
                if (i < orderIds.length - 1) {
                    placeholdersOrder.append(", ");
                }
            }
            deleteOrderSql += placeholdersOrder.toString() + ")";

            ps = connection.prepareStatement(deleteOrderSql);
            for (int i = 0; i < orderIds.length; i++) {
                ps.setInt(i + 1, Integer.parseInt(orderIds[i]));
            }
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {

        try {
            // Tạo một đối tượng OrderDAO
            OrderDAO orderDAO = new OrderDAO();

            // Khởi tạo các tham số cần thiết cho hàm getAllOrder
            String uid = ""; // Nếu bạn không có thông tin về uid, bạn có thể để giá trị này là chuỗi rỗng
            String fdate = ""; // Ngày bắt đầu khoảng thời gian
            String tdate = ""; // Ngày kết thúc khoảng thời gian
            String search = ""; // Từ khóa tìm kiếm, nếu không có thì để là chuỗi rỗng
            int offset = 0; // Vị trí bắt đầu của trang
            int noOfRecords = 5; // Số lượng bản ghi trên mỗi trang

            // Gọi hàm getAllOrder từ OrderDAO
            ArrayList<Order> orderList = orderDAO.getAllOrderByuId(1, fdate, "2024-06-22", offset, noOfRecords);
            int tttt = orderDAO.getTotalPage(1, fdate, tdate, 5);
            System.out.println("ccc: " + tttt);
            // In ra thông tin về đơn hàng
            for (Order order : orderList) {
                System.out.println("Order ID: " + order.getId());
                System.out.println("Order Date: " + order.getOrderDate());
                System.out.println("Total: " + order.getTotal());
                System.out.println("Status: " + order.getStatus());
                System.out.println("Phone: " + order.getPhone());
                System.out.println("User Name: " + order.getUserName());
                System.out.println("Address: " + order.getAddress());
                System.out.println("-----------------------------");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
