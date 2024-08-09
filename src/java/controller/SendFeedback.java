/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.*;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "SendFeedback", urlPatterns = {"/SendFeedback"})
public class SendFeedback extends HttpServlet {

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
            out.println("<title>Servlet SendFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SendFeedback at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            ProductDAO productDao = new ProductDAO();

            int userId = 1;
            String pid = request.getParameter("pid");

            Product product = productDao.getProductById(Integer.valueOf(pid));

            request.setAttribute("product", product);
            request.getRequestDispatcher("sendFeedback.jsp").forward(request, response);

        } catch (Exception e) {
            response.sendRedirect("404.html");
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
        try {
            FeedbackDAO fdao = new FeedbackDAO();
            HttpSession session = request.getSession();
            if (session.getAttribute("account") == null) {
                response.sendRedirect("login");
            } else {
                String content = request.getParameter("feedbackContent");
                String rate = request.getParameter("rate");
                String img = request.getParameter("img");
                String proid = request.getParameter("pid");
                int userId = 3;
                Object o = session.getAttribute("account");
                User user = (User) o;
                userId = user.getId();
                fdao.insertFeedback(Integer.valueOf(proid), userId, content, rate, img);
                response.sendRedirect("./ProductDetails?pid="+proid);
            }
        } catch (Exception e) {
            response.sendRedirect("404.jsp");
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
