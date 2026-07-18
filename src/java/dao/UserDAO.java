/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author 06052
 */



import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // --- MAPPING USER FROM RESULTSET ---
    private User map(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setName(rs.getString("ten"));
        u.setEmail(rs.getString("email"));
        u.setPasswordHash(rs.getString("mat_khau"));
        u.setPhone(rs.getString("dien_thoai"));
        u.setAddress(rs.getString("dia_chi"));
        u.setRole(rs.getString("quyen"));
        return u;
    }


    // --- Đăng ký tài khoản người dùng ---
    public boolean registerUser(User user) {
        String sql = """
            INSERT INTO nguoi_dung (ten, email, mat_khau, dien_thoai, dia_chi, quyen)
            VALUES (?, ?, ?, ?, ?, ?)
        """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());     // SHA-256
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());

            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }


    // --- Login người dùng ---
    public User loginUser(String email, String passwordHash) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ? AND mat_khau = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, passwordHash);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);

        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }


    // --- Login Admin ---
    public User loginAdmin(String email, String passwordHash) {
        String sql = """
            SELECT * FROM nguoi_dung 
            WHERE email = ? AND mat_khau = ? AND quyen = 'admin'
        """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, passwordHash);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);

        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }


    // --- Kiểm tra email tồn tại ---
    public boolean isEmailExists(String email) {
        String sql = "SELECT 1 FROM nguoi_dung WHERE email = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }


    // --- Lấy toàn bộ người dùng ---
    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM nguoi_dung ORDER BY id DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(map(rs));

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }


    // --- Lấy người dùng theo ID ---
    public User getById(int id) {
        String sql = "SELECT * FROM nguoi_dung WHERE id=?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);

        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    //Thay đổi mk user - khách
    public boolean updatePassword(int userId, String newHashedPassword) {
        String sql = "UPDATE nguoi_dung SET mat_khau=? WHERE id=?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newHashedPassword);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    
    // --- Cập nhật người dùng (dùng trong Admin) ---
    public boolean update(User u) {
        String sql = """
            UPDATE nguoi_dung SET 
                ten=?, 
                email=?, 
                dien_thoai=?, 
                dia_chi=?, 
                quyen=?, 
                mat_khau=?
            WHERE id=?
        """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPhone());
            ps.setString(4, u.getAddress());
            ps.setString(5, u.getRole());
            ps.setString(6, u.getPasswordHash());
            ps.setInt(7, u.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    
    // --- Xóa user ---
    public boolean delete(int id) {
        String sql = "DELETE FROM nguoi_dung WHERE id=?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}
