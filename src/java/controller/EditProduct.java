/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import Helper.UploadImage;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
@WebServlet(name = "EditProduct", urlPatterns = {"/EditProduct"})
public class EditProduct extends HttpServlet {

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
    Logger logger = Logger.getLogger(getClass().getName());

    try {
        response.setContentType("text/html;charset=UTF-8");

        // Sử dụng phương thức parse thay cho valueOf
        int id = Integer.parseInt(request.getParameter("id"));
        int cateId = Integer.parseInt(request.getParameter("category"));
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stockQuantity"));

        // Sử dụng logger thay vì System.out.println
        logger.log(Level.INFO, "param: {0}", request.getParameter("stock"));
        response.getWriter().print(request.getParameter("photo"));

        UploadImage uploadImage = new UploadImage();
        String img = (String) uploadImage.uploadFile(request, "img");

        String descri = request.getParameter("descri");
        String name = request.getParameter("name");
        String creDate = request.getParameter("creDate");
        
        ProductDAO pdao = new ProductDAO();
        pdao.UpdateProduct(id, name, price, cateId, stock, creDate, descri, img);
        response.sendRedirect("./ManagerProduct");
    } catch (Exception e) {
        // Sử dụng logger để log lỗi
        logger.log(Level.SEVERE, "Error during product update", e);
        response.sendRedirect("./404.html");
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
