/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Helper.UploadImage;
import dao.AdminDAO;
import dao.BannerDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
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
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class EditAccount extends HttpServlet {

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
            out.println("<title>Servlet EditAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditAccount at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect("login");
        } else {
            session.setAttribute("upAccount", new UserDAO().getUserById(Integer.valueOf(request.getParameter("pid"))));
            request.getRequestDispatcher("editAccount.jsp").forward(request, response);
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
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        Boolean gender2;
        if (Integer.valueOf(gender) == 1) {
            gender2 = true;
        } else {
            gender2 = false;
        }
        BannerDAO badao = new BannerDAO();
        response.getWriter().print(request.getParameter("photo"));
        UploadImage uploadImage = new UploadImage();
        String img = (String) uploadImage.uploadFile(request, "img");

//        String pass = request.getParameter("pass");
        String id = request.getParameter("id");
        UserDAO udao = new UserDAO();
        AdminDAO adao = new AdminDAO();
        HttpSession session = request.getSession();
        try {
            User checkExist = udao.getUserByEmail(email);
          
                udao.UpdateUser(name, email, phone, address, Integer.valueOf(gender), Integer.valueOf(id), img);
                User u = new User(name, email, address, gender2, phone, new Roles(1), img);
                u.setId(Integer.valueOf(id));
                request.setAttribute("mess", "UpdateSuccess");
                response.sendRedirect("ManagerUser");
        } catch (Exception e) {
            response.getWriter().println(e);
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
