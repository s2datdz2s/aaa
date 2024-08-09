/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.AddressDAO;
import dao.OrderAddressDAO;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Address;
import model.Cart;
import model.CartItem;
import model.User;
import model.Admin;
import model.Order;
import model.OrderAddress;

/**
 *
 * @author Admin
 */
public class Checkout extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Lấy thông tin từ session
        Object object = session.getAttribute("account");
        Object object1 = session.getAttribute("cart");

        // Ép kiểu đối tượng "account" về đối tượng User
        User user = (User) object;

        // Ép kiểu đối tượng "cart" về đối tượng Cart
        Cart cart = (Cart) object1;

        // Lưu lại giỏ hàng đã được cập nhật vào session
        session.setAttribute("cart", cart);

        // Print information about the updated cart
        System.out.println("User: " + user);

        System.out.println("Updated Cart:");
        for (CartItem cartItem : cart.getItems()) {
            System.out.println("Product ID: " + cartItem.getProduct().getId() + ", Quantity: " + cartItem.getQuantity());
        }
        if (user == null) {
            response.sendRedirect("login");
        } else {
            AddressDAO addressDAO = new AddressDAO();
            List<Address> addressByUserId = addressDAO.getAddressByUserId(user.getId());
            request.setAttribute("address", addressByUserId);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy HttpSession từ request
        HttpSession session = request.getSession();

        // Lấy các đối tượng từ session
        Object accountObject = session.getAttribute("account");
        Object cartObject = session.getAttribute("cart");

        // Kiểm tra xem đối tượng account và cart có tồn tại không
        if (accountObject == null || cartObject == null) {
            // Nếu không tồn tại, xử lý lỗi và điều hướng người dùng đi đến trang lỗi
            session.setAttribute("orderResult", "error");
            response.sendRedirect("error.jsp"); // Điều hướng tới trang lỗi
            return;
        }

        // Ép kiểu đối tượng "account" về đối tượng User
        User user = (User) accountObject;
        String paymentMethod = request.getParameter("paymentMethod");

        // Lấy ghi chú từ tham số của request
        String notes = request.getParameter("notes");

        // Lấy địa chỉ từ tham số của request
        String address = request.getParameter("address");
        int addressFinal = Integer.parseInt(address);

        // Ép kiểu đối tượng "cart" về đối tượng Cart
        Cart cart = (Cart) cartObject;

        // Tạo một đối tượng OrderDAO
        OrderDAO orderDAO = new OrderDAO();

        // Thêm thông tin đơn hàng vào cơ sở dữ liệu và nhận về đối tượng Order đã thêm
        Order order = orderDAO.insertOrder1(user, cart, notes, paymentMethod);
        OrderAddressDAO oa = new OrderAddressDAO();
        OrderAddress newOrderAddress = new OrderAddress();
        newOrderAddress.setAddressId(addressFinal);
        newOrderAddress.setOrderId(order.getId());
        oa.insertOrderAddress(newOrderAddress);

        // Xử lý kết quả và cập nhật session
        if (order != null) {
            session.setAttribute("orderResult", "success"); // Đặt thông báo thành công vào session
            session.setAttribute("order", order);
            session.removeAttribute("cart");
            session.removeAttribute("cartItems");
            if ("Banking".equalsIgnoreCase(paymentMethod)) {
                double total = cart.getTotalMoney();
                long totalLong = (long) total;
                session.setAttribute("orderSession", order);
                response.sendRedirect("PaymentServlet?total=" + totalLong);
                return; // Chấm dứt phương thức để tránh thực thi tiếp các mã phía dưới
            }
        } else {
            session.setAttribute("orderResult", "error"); // Đặt thông báo thất bại vào session
        }

        // Điều hướng người dùng đến trang kết quả
        response.sendRedirect("result.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
