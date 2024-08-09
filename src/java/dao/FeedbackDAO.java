/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Feedback;
import model.Product;
import model.User;

/**
 *
 * @author Admin
 */
public class FeedbackDAO extends DBContext {

    private ProductDAO pdao = new ProductDAO();
    private UserDAO udao = new UserDAO();

    
    
    
    public void insertFeedback(int pid, int uid, String content, String rate, String img) {
        try {
            String sql = "insert into feedback values (?,?,?,?,?,GETDATE(),1)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            stm.setInt(2, uid);
            stm.setInt(3, Integer.valueOf(rate));
            stm.setString(4, content);
            stm.setString(5, img);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public ArrayList<Feedback> getFeedbackBypid(int pid) {
        ArrayList<Feedback> FeedbackList = new ArrayList<>();
        try {
            String sql = "  select * from feedback where product_id =  " + pid;
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = udao.getUserById(rs.getInt(3));
                Product p = pdao.getProductById(rs.getInt(2));
                Feedback fb = new Feedback(rs.getInt(1), rs.getInt(2), u, rs.getInt(4), rs.getString(5), rs.getString(6), rs.getDate(7), rs.getBoolean(8), p);
                FeedbackList.add(fb);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return FeedbackList;
    }
    

    public String getNumberFeedbackByProId(int pid) {
        try {
            String sql = "  select round(avg( Cast(rated as Float)),1),count(*) from feedback where product_id =?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String avg = "0";
                String s = "";
                if (rs.getString(2) != null) {
                    avg = rs.getString(2);
                }
                if (rs.getString(1) == null) {
                    s = "<b>" + 0 + "</b><i class=\"fa fa-star\" ></i>  (" + avg + " feedbacks)";

                } else {
                    s = "<b>" + rs.getString(1) + "</b><i class=\"fa fa-star\" ></i>  (" + avg + " feedbacks)";
                }

                return s;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public ArrayList<Feedback> getAllFeedbacks() {
        ArrayList<Feedback> FeedbackList = new ArrayList<>();
        try {
            String sql = "select  * from feedback  "
                    + "order by feedback_id asc OFFSET 0 ROWS FETCH NEXT 9  ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                System.out.println("1");
                User u = udao.getUserById(rs.getInt(3));
                Product p = pdao.getProductById(rs.getInt(2));
                Feedback fb = new Feedback(rs.getInt(1), rs.getInt(2), u, rs.getInt(4), rs.getString(5), rs.getString(6), rs.getDate(7), rs.getBoolean(8), p);
                FeedbackList.add(fb);
            }
        } catch (SQLException e) {
        }
        return FeedbackList;
    }
    public static void main(String[] args) {
        for (Feedback allFeedback : new FeedbackDAO().getAllFeedbacks()) {
            System.out.println(allFeedback);
        }
    }
    public ArrayList<Feedback> getFeedbackByConditions(String star, String status, String fullname, String product, int index) {
        ArrayList<Feedback> FeedbackList = new ArrayList<>();
        try {
            String sql = "select f.* from feedback f join product p on f.product_id = p.product_id \n"
                    + "join [Users] u on u.user_id = f.user_id where rated like ? and f.active like ? and [user_name] like ? and product_name like ? "
                    + "order by feedback_id asc OFFSET ? ROWS FETCH NEXT 9  ROWS ONLY";
            System.out.println(sql);
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + star + "%");
            stm.setString(2, "%" + status + "%");
            stm.setString(3, "%" + fullname + "%");
            stm.setString(4, "%" + product + "%");
            stm.setInt(5, (index - 1) * 9);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = udao.getUserById(rs.getInt(3));
                Product p = pdao.getProductById(rs.getInt(2));
                Feedback fb = new Feedback(rs.getInt(1), rs.getInt(2), u, rs.getInt(4), rs.getString(5), rs.getString(6), rs.getDate(7), rs.getBoolean(8), p);
                FeedbackList.add(fb);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return FeedbackList;
    }

    public int getNumberFeedbackWithCondition(String star, String status, String fullname, String product) {
        try {
            String sql = "  select COUNT(*) from feedback f join product p on f.product_id = p.product_id \n"
                    + "join [user] u on u.user_id = f.user_id where rated like ? and f.active like ? and fullname like ? and title like ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + star + "%");
            stm.setString(2, "%" + status + "%");
            stm.setString(3, "%" + fullname + "%");
            stm.setString(4, "%" + product + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public void updateStatusByFbID(String status, String fid) {
        try {
            PreparedStatement ps = connection.prepareStatement("UPDATE [dbo].[feedback]\n"
                    + "   SET [active] = ?\n"
                    + " WHERE feedback_id = ?");
            ps.setString(1, status);
            ps.setString(2, fid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

}
