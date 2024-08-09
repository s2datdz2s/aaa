package controller;

import dao.OrderDAO;
import dao.UserDAO;
import model.User;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;

public class ManagerUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String uid = request.getParameter("uid") == null ? "" : request.getParameter("uid");
        String search = request.getParameter("search") == null ? "" : request.getParameter("search");

        OrderDAO odao = new OrderDAO();
        HttpSession session = request.getSession();

        Object object = session.getAttribute("account");
        UserDAO udao = new UserDAO();
        Admin u = (Admin) object;
        int numberOfUsers = udao.getNumberUser();
        int numberPage = (int) Math.ceil((double) numberOfUsers / 5);
        request.setAttribute("numberPage", numberPage);
        request.setAttribute("numberOfUsers", numberOfUsers);
        int index;
        String currentPage = request.getParameter("index");
        if (currentPage == null) {
            index = 1;
        } else {
            index = Integer.parseInt(currentPage);
        }
        if (u.getRoles().getId() == 2) {
            ArrayList<User> ol = udao.searchAndPaginate(uid, search, index);
            request.setAttribute("userList", ol);
            request.getRequestDispatcher("manageruser.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
