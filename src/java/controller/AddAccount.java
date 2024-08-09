/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;
import model.Roles;
import model.User;

/**
 *
 * @author ADMIN
 */
public class AddAccount extends HttpServlet {

    UserDAO udao = new UserDAO();
    AdminDAO adao = new AdminDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAccount at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        processRequest(request, response);
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
        HttpSession session = request.getSession();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String fullname = request.getParameter("fullname");

        String dob = request.getParameter("dob");

        String q1 = request.getParameter("Q1Id") == null ? "1" : "1";
        String q1_ans = request.getParameter("q1") == null ? "1" : "1";

        String q2 = request.getParameter("Q2Id") == null ? "1" : "1";
        String q2_ans = request.getParameter("q2") == null ? "1" : "1";
        String pass = request.getParameter("pass") == null ? "1" : "1";
        // Kiểm tra xem người dùng và quản trị viên với email đã cho có tồn tại không
        User checkExist = udao.getUserByEmail(email);
        Admin check = adao.getAdminByEmail(email);
//              if (pass.length() >= 6 && pass.matches(".*[A-Z]+.*") && pass.matches(".*[a-z]+.*") && pass.matches(".*\\d+.*")) {
        if (checkExist == null && check == null) {
             udao.inserUser(name, email, phone, address, pass, Integer.valueOf(gender), q1, q1_ans, q2, q2_ans,fullname,dob);
            // Tạo một đối tượng người dùng mới
            User u = new User(name, email, pass, address, phone, gender.equals("1") ? true : false, q1, q1_ans, q2, q2_ans, new Roles(1));
            u.setFullName(fullname);
            u.setDob(dob);
            session.setAttribute("ui", u);// Thiết lập đối tượng người dùng trong phiên
        }
        response.sendRedirect("ManagerUser");
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
