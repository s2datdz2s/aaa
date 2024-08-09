/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Banner;
import model.Roles;

/**
 *
 * @author
 */
public class BannerDAO extends DBContext {

    public static void main(String[] args) {
        BannerDAO udao = new BannerDAO();
//        ArrayList<Admin> userList = udao.getAllAdmin();
        ArrayList<Banner> userList = udao.searchBannerPaging("", "", 1);
        System.out.println(userList);
        // Print the current time
    }

    public ArrayList<Banner> getAllBanner() {
        ArrayList<Banner> list = new ArrayList<>();
        String sql = "select * from [Banner]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                list.add(new Banner(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getInt(7), rs.getString(8)));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<Banner> searchBanner(String search, String status) {
        ArrayList<Banner> list = new ArrayList<>();
        String sql = "Select * from [Banner] where ([backlink] like ? or [banner_title] like ? ) and [status] like ?  ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + status + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Banner b = new Banner(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getInt(7), rs.getString(8));
                b.setBackLink(rs.getString(9));
                b.setStatus(rs.getBoolean(10));
                list.add(b);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<Banner> searchBannerPaging(String search, String status, int index) {
        ArrayList<Banner> list = new ArrayList<>();
        String sql = "Select * from [Banner] where ([backlink] like ? or [banner_title] like ? ) and [status] like ? "
                + " order by [banner_id]  OFFSET ? ROWS FETCH NEXT 6  ROWS ONLY ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + status + "%");
            ps.setInt(4, (index - 1) * 6);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Banner b = new Banner(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getInt(7), rs.getString(8));
                b.setBackLink(rs.getString(9));
                b.setStatus(rs.getBoolean(10));
                list.add(b);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public Banner getBannerById(int pid) {
        String sql = " select * from [Banner] where [banner_id]= ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Banner p = new Banner(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getInt(7), rs.getString(8));

                return p;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void insertBanner(String img, String tittle, String content, String created_by, String modifile_by) {
        String sql = "  insert into [Banner] ([banner_img],[banner_title],[banner_content], [created_by], [created_on], [modifile_by], [modifile_on]) \n"
                + "  values (?,?,?,?,getdate(),?,getdate())";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, img);
            ps.setString(2, tittle);
            ps.setString(3, content);
            ps.setString(4, created_by);
            ps.setString(5, modifile_by);
            ps.executeUpdate();
        } catch (Exception e) {
        }

    }

    public void DeleteBanner(int pid) {
        String sql = "  DELETE FROM [Banner] WHERE banner_id =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void UpdateBanner(int id, String img, String title, String content, int modifile_by) {
        String sql = "  UPDATE [Banner]  set [banner_img]= ?   ,[banner_title] = ?  ,[banner_content]= ?,  \n"
                + "  [modifile_by] = ?   ,[modifile_on] = getdate() \n"
                + "  where banner_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, img);
            ps.setString(2, title);
            ps.setString(3, content);
            ps.setInt(4, modifile_by);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
     public void updateStatusByFbID(String status, String fid) {
        try {
            PreparedStatement ps = connection.prepareStatement("UPDATE [dbo].[Banner]\n"
                    + "   SET [status] = ?\n"
                    + " WHERE banner_id = ?");
            ps.setString(1, status);
            ps.setString(2, fid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
}
