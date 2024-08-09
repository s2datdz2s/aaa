/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="FeedbackList", urlPatterns={"/FeedbackList"})
public class FeedbackList extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet FeedbackList</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackList at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 
@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FeedbackDAO dao = new FeedbackDAO();
        String action = request.getParameter("action");
        if (action == null) {
            if (request.getParameter("star") == null) {
                int numberFeedback = dao.getNumberFeedbackWithCondition("", "", "", "");
                int numberPage = (int) Math.ceil((double) numberFeedback / 11);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("feedbackList", dao.getAllFeedbacks());
            } else {
                String search = request.getParameter("search");
                String typeSearch = request.getParameter("type-search");
                String fullname = "";
                String title = "";
                if (typeSearch.equals("0")) {
                    fullname = search;
                } else {
                    title = search;
                }
                int index;
                String currentPage = request.getParameter("index");
                if (currentPage == null) {
                    index = 1;
                } else {
                    index = Integer.parseInt(currentPage);
                }
                int numberFeedback = dao.getNumberFeedbackWithCondition(request.getParameter("star"), request.getParameter("status"),
                        fullname, title);
                int numberPage = (int) Math.ceil((double) numberFeedback / 9);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("feedbackList", dao.getFeedbackByConditions(request.getParameter("star"), request.getParameter("status"),
                        fullname, title, index));
            }
            request.getRequestDispatcher("./feedbacklist.jsp").forward(request, response);

        } else {
            if ("edit".equals(action)) {
                dao.updateStatusByFbID(request.getParameter("status"), request.getParameter("fid"));
            }
            if ("switch".equals(action)) {
                dao.updateStatusByFbID(request.getParameter("status"), request.getParameter("fid"));
            }
            response.sendRedirect("FeedbackList");

        }

    }

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
