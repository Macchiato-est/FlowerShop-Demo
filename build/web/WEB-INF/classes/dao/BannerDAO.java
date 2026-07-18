/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author 06052
 */

import model.Banner;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BannerDAO {

    private Banner map(ResultSet rs) throws Exception {
        Banner b = new Banner();
        b.setId(rs.getInt("id"));
        b.setTieuDe(rs.getString("tieu_de"));
        b.setHinhAnh(rs.getString("hinh_anh"));
        b.setTrangThai(rs.getString("trang_thai"));
        return b;
    }

    public List<Banner> getAll() {
        List<Banner> list = new ArrayList<>();
        String sql = "SELECT * FROM banner ORDER BY id DESC";

        try (Connection c = DBConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(map(rs));

        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean insert(Banner b) {
        String sql = "INSERT INTO banner(tieu_de, hinh_anh, trang_thai) VALUES(?,?,?)";

        try (Connection c = DBConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, b.getTieuDe());
            ps.setString(2, b.getHinhAnh());
            ps.setString(3, b.getTrangThai());

            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }

        return false;
    }

    public Banner getById(int id) {
        String sql = "SELECT * FROM banner WHERE id=?";
        try (Connection c = DBConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);

        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public boolean update(Banner b) {
        String sql = "UPDATE banner SET tieu_de=?, hinh_anh=?, trang_thai=? WHERE id=?";
        try (Connection c = DBConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, b.getTieuDe());
            ps.setString(2, b.getHinhAnh());
            ps.setString(3, b.getTrangThai());
            ps.setInt(4, b.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM banner WHERE id=?";
        try (Connection c = DBConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}
