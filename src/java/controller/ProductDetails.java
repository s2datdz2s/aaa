/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.FeedbackDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Category;

import model.Product;
import model.Product_img;

/**
 *
 * @author Admin
 */
public class ProductDetails extends HttpServlet {

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
        try {
            // Tạo đối tượng Product 

            ProductDAO pdao = new ProductDAO();
            // Lấy thông tin từ request
            String pid = request.getParameter("pid") == null ? "" : request.getParameter("pid");
            
           //Truy xuất danh sách các danh mục sản phẩm.
              ArrayList<Category> clist = pdao.getCategory();
              
            Product p = pdao.getProductById(Integer.valueOf(pid));
 //Đặt danh sách sản phẩm làm thuộc tính yêu cầu để sử dụng trong JSP.
            request.setAttribute("p", p);
           
            request.setAttribute("clist", clist);
            request.setAttribute("fl", new FeedbackDAO().getFeedbackBypid(Integer.valueOf(pid)));

            request.getRequestDispatcher("productdetails.jsp").forward(request, response);
        } catch (Exception e) {
           
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
            ProductDAO pdao = new ProductDAO();
            String pid = request.getParameter("pid") == null ? "" : request.getParameter("pid");
            String comment = request.getParameter("comment");
            String id = request.getParameter("id");
            Product p = pdao.getProductById(Integer.valueOf(pid));

            ArrayList<Product_img> o = pdao.getImgById(pid);

            pdao.AddFeedback(comment, Integer.parseInt(id), Integer.parseInt(pid));

         

          

            request.setAttribute("p", p);
            request.setAttribute("o", o);
            request.getRequestDispatcher("productdetails.jsp").forward(request, response);
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
