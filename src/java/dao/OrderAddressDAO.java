/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.OrderAddress;

/**
 *
 * @author ADMIN-PC
 */
public class OrderAddressDAO extends DBContext{
     public void insertOrderAddress(OrderAddress orderAddress) {
        try {
            String sql = "INSERT INTO [OrderAddress] ([order_id], [address_id]) VALUES (?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderAddress.getOrderId());
            ps.setInt(2, orderAddress.getAddressId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
