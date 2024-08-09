/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminDAO;
import dao.MD5;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Admin;
import model.Question1;
import model.Question2;
import model.User;

/**
 *
 * @author 

 */
public class LoginAdmin extends HttpServlet {

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
            out.println("<title>Servlet LoginAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginAdmin at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");

        try {

            HttpSession session = request.getSession();
            String email = request.getParameter("email");
            String pass = request.getParameter("pass");
            UserDAO udao = new UserDAO();
            AdminDAO adao = new AdminDAO();
            MD5 md5 = new MD5();

            Admin admin = adao.getAdminByEmail(email, pass);
            User user = udao.getUserByEmail(email, pass);

            String mess = "Email or password wrong!";
            if (user != null) {
                session.setAttribute("account", user);
                session.setAttribute("img", user.getImg()); // Cập nhật đường dẫn ảnh vào session

                mess = "user";
            }

            if (admin != null) {
                session.setAttribute("account", admin);
                session.setAttribute("img", admin.getImg()); // Cập nhật đường dẫn ảnh vào session

                mess = "admin";
            }

            if (mess.equals("user")) {

                response.sendRedirect("./HomePage");
            }
            if (mess.equals("admin")) {

                response.sendRedirect("./ManagerAdmin");
            } else {

                request.setAttribute("mess", mess);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
        }
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
