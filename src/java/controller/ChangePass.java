/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.MD5;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author *
 */
public class ChangePass extends HttpServlet {

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
            out.println("<title>Servlet ChangePass</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePass at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("ChangePass.jsp").forward(request, response);
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
        String email = request.getParameter("email");
        String key = request.getParameter("key");
        String newpass = request.getParameter("newpass");
        String renewpass = request.getParameter("renewpass");

        UserDAO dao = new UserDAO();

        // Kiểm tra nếu trường mật khẩu mới hoặc xác nhận mật khẩu bị bỏ trống
        if (newpass == null || newpass.isEmpty() || renewpass == null || renewpass.isEmpty()) {
            request.setAttribute("email", email);
            request.setAttribute("mess", "Password fields cannot be empty");
            request.getRequestDispatcher("ChangePass.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tính hợp lệ của email và key
        String storedKey = "";
        User checkExist = dao.getUserByEmail(email);
        if (checkExist != null) {
          storedKey = dao.getKeyByEmail(email);
        } else {
           storedKey = dao.getKeyByEmailAdmin(email);
        }
        if (storedKey == null || !storedKey.equals(key)) {
            request.setAttribute("email", email);
            request.setAttribute("mess", "Key not valid!" );
            request.getRequestDispatcher("ChangePass.jsp").forward(request, response);
            return; // Dừng xử lý nếu key không hợp lệ
        }

        if (!newpass.equals(renewpass)) {
            request.setAttribute("email", email);
            request.setAttribute("mess", "Passwords do not match");
            request.getRequestDispatcher("ChangePass.jsp").forward(request, response);
        } // Kiểm tra độ dài và tính hợp lệ của mật khẩu mới
//        if (newpass.length() < 8 || !newpass.matches(".*[!@#$%^&*].*")) {
//            request.setAttribute("email", email);
//            request.setAttribute("mess", "Password must be at least 8 characters long and include a special character");
//            request.getRequestDispatcher("ChangePass.jsp").forward(request, response);
//            return;
//        } 
        else {
            if (checkExist != null) {
                dao.changePasswordByEmail(email, newpass);
            } else {
                dao.changeAdminPasswordByEmail(email, newpass);

            }

            request.setAttribute("email", email);
            request.setAttribute("mess", "Change password sucessfully!");
            request.getRequestDispatcher("ChangePass.jsp").forward(request, response);
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
