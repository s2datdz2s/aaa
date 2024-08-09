/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Address;
import model.OrderAddress;

/**
 *
 * @author ADMIN-PC
 */
public class AddressDAO extends DBContext {

    public Address getAddressById(int addressId) {
        Address address = null;
        try {
            String sql = "SELECT * FROM [Address] WHERE address_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, addressId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                address = new Address();
                address.setAddressId(rs.getInt("address_id"));
                address.setUserId(rs.getInt("user_id"));
                address.setAddress(rs.getString("address"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return address;
    }

    public List<Address> getAddressByUserId(int userId) {
        List<Address> addresses = new ArrayList<>();
        try {
            String sql = "SELECT a.* FROM [Address] a WHERE a.user_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Address address = new Address();
                address.setAddressId(rs.getInt("address_id"));
                address.setUserId(rs.getInt("user_id"));
                address.setAddress(rs.getString("address"));
                addresses.add(address);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return addresses;
    }

    public void insertAddress(Address address) {
        try {
            String sql = "INSERT INTO [Address] ([user_id], [address]) VALUES (?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, address.getUserId());
            ps.setString(2, address.getAddress());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
    }
}
