/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import dao.AdminDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.Question1;
import model.Question2;
import model.Roles;
import model.User;
import model.Admin;

/**
 *
 * @author *
 */
public class Forgot extends HttpServlet {

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
            out.println("<title>Servlet Forgot</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Forgot at " + request.getContextPath() + "</h1>");
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
    UserDAO udao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Question1> q1list = udao.getQuestion1();
        ArrayList<Question2> q2list = udao.getQuestion2();
        request.setAttribute("q1list", q1list);
        request.setAttribute("q2list", q2list);
        request.getRequestDispatcher("Forgot.jsp").forward(request, response);
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
            HttpSession session = request.getSession();
            String email = request.getParameter("email");

            // Kiểm tra tính hợp lệ của email đầu vào
            if (email == null || email.isEmpty()) {
                request.setAttribute("messregis", "Email cannot be empty");
                request.getRequestDispatcher("Forgot.jsp").forward(request, response);
                return;
            }
            UserDAO udao = new UserDAO();
            // Kiểm tra email có tồn tại trong hệ thống hay không
            if (udao.getUserByEmail(email) == null) {
                request.setAttribute("messregis", "Email not found");
                request.getRequestDispatcher("Forgot.jsp").forward(request, response);
                return;
            }

            String q1 = "1";
            String q1_ans = "1";
            String q2 = "1";
            String q2_ans = "1";

            // Cấu hình thông tin email gửi đi
            final String username = "havunam001@gmail.com";
            final String password = "yzfh mmzq lyjy wkyz";
            Properties prop = new Properties();
            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "587");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true");

            // Tạo một session email với thông tin xác thực
            javax.mail.Session sessions = javax.mail.Session.getInstance(prop, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
            // Tạo một mã xác nhận và lưu vào session
            String code = UUID.randomUUID().toString();
            session.setAttribute("codecheck", code);

            // Chuẩn bị nội dung email
            String emailTo = email;
            String key = generateRandomString(10);
            String emailSubject = "Change password Account";
            String emailContent = "You need to verify your account by clicking the link:"
                    + "http://localhost:8080/OnlineShopPrj/ChangePass?email=" + email + "&key=" + key;

            // Cập nhật key trong database
            udao.updateKeyByEmail(email, key);
            udao.updateKeyByEmailAdmin(email, key);
            session.setAttribute("createTime", System.currentTimeMillis());
            try {
                // Tạo và gửi thông điệp email
                Message message = new MimeMessage(sessions);
                message.setFrom(new InternetAddress(username));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(emailTo));
                message.setSubject(emailSubject);
                message.setText(emailContent);
                Transport.send(message);

            } catch (Exception e) {
                // Xử lý lỗi gửi email
                request.setAttribute("messregis", "Failed to send verification email");
                request.getRequestDispatcher("Forgot.jsp").forward(request, response);
                return;
            }

            // Thông báo thành công
            request.setAttribute("messregis", "Verification email sent!");
            request.getRequestDispatcher("Forgot.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý lỗi tổng quát
            request.setAttribute("messregis", "An error occurred. Please try again.");
            request.getRequestDispatcher("Forgot.jsp").forward(request, response);

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

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final Random RANDOM = new Random();

    public static String generateRandomString(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int index = RANDOM.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }
        return sb.toString();
    }

}
