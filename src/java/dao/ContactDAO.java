/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author 06052
 */

import model.ContactMessage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {

    public boolean insert(ContactMessage m) {
        String sql = """
            INSERT INTO lien_he(ho_ten, email, so_dien_thoai, tieu_de, noi_dung, trang_thai)
            VALUES (?,?,?,?,?, 'NEW')
        """;
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, m.getHoTen());
            ps.setString(2, m.getEmail());
            ps.setString(3, m.getSoDienThoai());
            ps.setString(4, m.getTieuDe());
            ps.setString(5, m.getNoiDung());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Lấy toàn bộ danh sách liên hệ
    public List<ContactMessage> getAll() {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM lien_he ORDER BY id DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ContactMessage m = new ContactMessage();
                m.setId(rs.getInt("id"));
                m.setHoTen(rs.getString("ho_ten"));
                m.setEmail(rs.getString("email"));
                m.setSoDienThoai(rs.getString("so_dien_thoai"));
                m.setTieuDe(rs.getString("tieu_de"));
                m.setNoiDung(rs.getString("noi_dung"));
                m.setTrangThai(rs.getString("trang_thai"));
                Timestamp ts = rs.getTimestamp("ngay_gui");
                    if (ts != null) {
                        m.setNgayGui(ts.toLocalDateTime());
                    }
                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đánh dấu đã phản hồi
    public boolean updateStatus(int id) {
        String sql = "UPDATE lien_he SET trang_thai = 'REPLIED' WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Đếm liên hệ mới
    public int countNewContacts() {
        String sql = "SELECT COUNT(*) FROM lien_he WHERE trang_thai='NEW'";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    
}
