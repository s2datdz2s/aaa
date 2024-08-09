/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Category;
import model.Product;

/**
 *
 * @author Admin
 */
public class ProductList extends HttpServlet {

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
            // Lấy HttpSession từ request
            HttpSession session = request.getSession();
             // Lấy thông tin từ request
            String categoryId = request.getParameter("categoryId") == null ? "" : request.getParameter("categoryId");
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String sort = request.getParameter("sort") == null ? "" : request.getParameter("sort");
            search = search.trim();
            // Tạo đối tượng Product 
            ProductDAO pdao = new ProductDAO();
            //Truy xuất danh sách các danh mục sản phẩm.
            ArrayList<Category> clist = pdao.getCategory();
            int totalproduct = pdao.getNumberProduct(categoryId,search);
            //Tính tổng số trang dựa trên số lượng sản phẩm
            int numberPage = (int) Math.ceil((double) totalproduct / 6);
            int index;
            String currentPage = request.getParameter("index");
            if (currentPage == null) {
                index = 1;
            } else {
                index = Integer.parseInt(currentPage);
            }
            //Truy xuất danh sách sản phẩm được phân trang
            ArrayList<Product> plist = pdao.getProductt(categoryId, search, index,sort);
            
            //Đặt danh sách sản phẩm làm thuộc tính yêu cầu để sử dụng trong JSP.
            request.setAttribute("numberPage", numberPage);
            request.setAttribute("plist", plist);
            request.setAttribute("clist", clist);
            request.getRequestDispatcher("productlist.jsp").forward(request, response);
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
        processRequest(request, response);
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
