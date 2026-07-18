/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author 06052
 */


import model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Map 1 dòng ResultSet -> Product
    private Product map(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));                 // cột id trong bảng hoa
        p.setTen(rs.getString("ten_hoa"));        // ten_hoa
        p.setMaLoai(rs.getInt("id_loai"));        // id_loai
        p.setGia(rs.getDouble("gia"));            // gia
        p.setGiaGoc(rs.getDouble("gia_goc"));     // gia_goc
        p.setHinhAnh(rs.getString("anh"));        // anh
        p.setMoTa(rs.getString("mo_ta"));         // mo_ta
        p.setSoLuong(rs.getInt("so_luong"));      // so_luong
        // cột mới: is_recommended (TINYINT(1))
        p.setRecommended(rs.getBoolean("is_recommended"));
        return p;
    }

    // Lấy tất cả sản phẩm
    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM hoa ORDER BY id DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy 1 sản phẩm theo id
    public Product getById(int id) {
        String sql = "SELECT * FROM hoa WHERE id = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy sản phẩm cùng danh mục (trừ chính nó), có limit
    public List<Product> getRelated(int categoryId, int exceptId, int limit) {
        List<Product> list = new ArrayList<>();
        String sql = """
                SELECT * FROM hoa
                WHERE id_loai = ? AND id <> ?
                ORDER BY id DESC
                LIMIT ?
                """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ps.setInt(2, exceptId);
            ps.setInt(3, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Sản phẩm đang giảm giá (gia < gia_goc), có limit
    public List<Product> getDiscounted(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = """
                SELECT * FROM hoa
                WHERE gia_goc IS NOT NULL AND gia_goc > gia
                ORDER BY (gia_goc - gia) DESC
                LIMIT ?
                """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy theo loại, có limit
    public List<Product> getByCategory(int categoryId, int limit) {
        List<Product> list = new ArrayList<>();
        String sql = """
                SELECT * FROM hoa
                WHERE id_loai = ?
                ORDER BY id DESC
                LIMIT ?
                """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ps.setInt(2, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Mới nhất (order by id desc), có limit
    public List<Product> getNewest(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM hoa ORDER BY id DESC LIMIT ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tìm kiếm theo tên hoa
    public List<Product> searchByKeyword(String keyword) {
        List<Product> list = new ArrayList<>();

        if (keyword == null) return list;
        keyword = keyword.trim();
        if (keyword.isEmpty()) return list;

        String sql = """
                SELECT * FROM hoa
                WHERE ten_hoa LIKE ?
                ORDER BY id DESC
                """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Sản phẩm bán chạy (best seller)
    public List<Product> getBestSeller(int limit) {
        List<Product> list = new ArrayList<>();

        String sql = """
                SELECT h.*, SUM(ct.so_luong) AS total_sold
                FROM hoa h
                JOIN chi_tiet_don_hang ct ON h.id = ct.id_hoa
                GROUP BY h.id
                ORDER BY total_sold DESC
                LIMIT ?
                """;

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // total_sold không dùng trong Product, nên map bình thường
                    list.add(map(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // SẢN PHẨM GỢI Ý (dựa trên flag is_recommended do admin tick)
    public List<Product> getRecommended(int limit) {
        List<Product> list = new ArrayList<>();

        String sql = """
            SELECT *
            FROM hoa
            WHERE is_recommended = 1
            ORDER BY id DESC
            LIMIT ?
        """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));   // dùng chung hàm map(...) đã có
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    // Đếm tổng số sản phẩm
    public int countAllProducts() {
        String sql = "SELECT COUNT(*) FROM hoa";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Giảm số lượng sản phẩm trong kho
    public boolean reduceStock(int productId, int quantity) {
        String sql = """
                UPDATE hoa
                SET so_luong = so_luong - ?
                WHERE id = ? AND so_luong >= ?
                """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // -------- ADMIN CRUD --------

    // THÊM SẢN PHẨM MỚI
    public boolean insert(Product p) {
        String sql = """
                INSERT INTO hoa(ten_hoa, id_loai, gia, gia_goc, anh, mo_ta, so_luong, is_recommended)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getTen());
            ps.setInt(2, p.getMaLoai());
            ps.setDouble(3, p.getGia());
            ps.setDouble(4, p.getGiaGoc());
            ps.setString(5, p.getHinhAnh());
            ps.setString(6, p.getMoTa());
            ps.setInt(7, p.getSoLuong());
            ps.setBoolean(8, p.isRecommended());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // CẬP NHẬT SẢN PHẨM
    public boolean update(Product p) {
        String sql = """
                UPDATE hoa
                SET ten_hoa = ?,
                    id_loai = ?,
                    gia = ?,
                    gia_goc = ?,
                    anh = ?,
                    mo_ta = ?,
                    so_luong = ?,
                    is_recommended = ?
                WHERE id = ?
                """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getTen());
            ps.setInt(2, p.getMaLoai());
            ps.setDouble(3, p.getGia());
            ps.setDouble(4, p.getGiaGoc());
            ps.setString(5, p.getHinhAnh());
            ps.setString(6, p.getMoTa());
            ps.setInt(7, p.getSoLuong());
            ps.setBoolean(8, p.isRecommended());
            ps.setInt(9, p.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // XÓA SẢN PHẨM
    public boolean delete(int id) {
        String sql = "DELETE FROM hoa WHERE id = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
