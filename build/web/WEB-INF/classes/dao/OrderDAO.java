/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author 06052
 */

import model.Order;
import model.OrderItem;
import model.TopProductStats;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO {

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setIdNguoiDung(rs.getInt("id_nguoi_dung"));
        o.setHoTenNhan(rs.getString("ho_ten_nhan"));
        o.setDienThoaiNhan(rs.getString("dien_thoai_nhan"));
        o.setDiaChiNhan(rs.getString("dia_chi_nhan"));
        o.setEmail(rs.getString("email"));
        o.setNgayLap(rs.getTimestamp("ngay_lap"));
        o.setTrangThai(rs.getString("trang_thai"));
        o.setTongTien(rs.getDouble("tong_tien"));
        return o;
    }

    // --- Tạo đơn hàng ---
    public int create(Order order) {
        String sql = """
            INSERT INTO don_hang
            (id_nguoi_dung, ho_ten_nhan, dien_thoai_nhan, dia_chi_nhan, email, ngay_lap, trang_thai, tong_tien)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getIdNguoiDung());
            ps.setString(2, order.getHoTenNhan());
            ps.setString(3, order.getDienThoaiNhan());
            ps.setString(4, order.getDiaChiNhan());
            ps.setString(5, order.getEmail());
            ps.setTimestamp(6, order.getNgayLap());
            ps.setString(7, order.getTrangThai());
            ps.setDouble(8, order.getTongTien());

            int rows = ps.executeUpdate();
            if (rows == 0) return -1;

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    // --- Lưu chi tiết đơn hàng ---
    public void addOrderItems(int orderId, List<OrderItem> items) {
        String sql = "INSERT INTO chi_tiet_don_hang(id_don_hang, id_hoa, so_luong, don_gia) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (OrderItem i : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, i.getIdHoa());
                ps.setInt(3, i.getSoLuong());
                ps.setDouble(4, i.getDonGia());
                ps.addBatch();
            }
            ps.executeBatch();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // --- Lấy danh sách đơn hàng người dùng ---
    public List<Order> getByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM don_hang WHERE id_nguoi_dung = ? ORDER BY id DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapOrder(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // --- Lấy chi tiết đơn hàng ---
    public List<OrderItem> getItems(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = """
            SELECT ct.id_don_hang, ct.id_hoa, ct.so_luong, ct.don_gia,
                   h.ten_hoa, h.anh
            FROM chi_tiet_don_hang ct
            JOIN hoa h ON ct.id_hoa = h.id
            WHERE ct.id_don_hang = ?
            """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();

                // KHÔNG SET item.id vì bảng không có cột id
                item.setIdDonHang(rs.getInt("id_don_hang"));
                item.setIdHoa(rs.getInt("id_hoa"));
                item.setSoLuong(rs.getInt("so_luong"));
                item.setDonGia(rs.getDouble("don_gia"));

                item.setProductName(rs.getString("ten_hoa"));
                item.setImage(rs.getString("anh"));

                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // --- Lấy đơn theo id + id user ---
    public Order getByIdForUser(int orderId, int userId) {
        String sql = "SELECT * FROM don_hang WHERE id = ? AND id_nguoi_dung = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapOrder(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // --- Hủy đơn hàng ---
    public boolean cancelOrder(int orderId, int userId) {
        String sql = """
                UPDATE don_hang
                SET trang_thai = 'CANCELLED'
                WHERE id = ? AND id_nguoi_dung = ? AND trang_thai = 'PENDING'
                """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Đếm tổng số đơn hàng
    public int countAllOrders() {
        String sql = "SELECT COUNT(*) FROM don_hang";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Đếm số đơn theo trạng thái
    public int countOrdersByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM don_hang WHERE trang_thai = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // -------------admin---------------- /

    // LẤY TẤT CẢ ĐƠN HÀNG (cho admin)
    public List<Order> getAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM don_hang ORDER BY id DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapOrder(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // LẤY ĐƠN HÀNG THEO ID (cho admin, KHÔNG lọc user)
    public Order getById(int id) {
        String sql = "SELECT * FROM don_hang WHERE id = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapOrder(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // CẬP NHẬT TRẠNG THÁI ĐƠN HÀNG
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE don_hang SET trang_thai = ? WHERE id = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //=====Thống kê=====//

    // Doanh thu theo ngày (7 ngày gần nhất)
    public Map<String, Double> getRevenueByDay() {
        Map<String, Double> map = new LinkedHashMap<>();
        String sql = """
            SELECT DATE(ngay_lap) AS ngay, SUM(tong_tien) AS doanh_thu
            FROM don_hang
            WHERE trang_thai IN ('CONFIRMED','SHIPPING','DONE')
            GROUP BY DATE(ngay_lap)
            ORDER BY ngay DESC
            LIMIT 7
        """;

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                map.put(rs.getString("ngay"), rs.getDouble("doanh_thu"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    // Doanh thu theo tháng (12 tháng gần nhất)
    public Map<String, Double> getRevenueByMonth() {
        Map<String, Double> map = new LinkedHashMap<>();
        String sql = """
            SELECT DATE_FORMAT(ngay_lap, '%Y-%m') AS thang, SUM(tong_tien) AS doanh_thu
            FROM don_hang
            WHERE trang_thai IN ('CONFIRMED','SHIPPING','DONE')
            GROUP BY thang
            ORDER BY thang DESC
            LIMIT 12
        """;

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                map.put(rs.getString("thang"), rs.getDouble("doanh_thu"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    // ================== TOP SẢN PHẨM ================== //

    // Top sản phẩm bán chạy 30 ngày gần nhất (theo SỐ LƯỢNG)
    public List<TopProductStats> getTopProductsLast30Days(int limit) {
        List<TopProductStats> list = new ArrayList<>();

        String sql = """
            SELECT h.id,
                   h.ten_hoa,
                   SUM(ct.so_luong) AS total_qty,
                   SUM(ct.so_luong * ct.don_gia) AS total_revenue
            FROM chi_tiet_don_hang ct
            JOIN don_hang d ON ct.id_don_hang = d.id
            JOIN hoa h ON ct.id_hoa = h.id
            WHERE d.trang_thai IN ('CONFIRMED','SHIPPING','DONE')
              AND d.ngay_lap >= NOW() - INTERVAL 30 DAY
            GROUP BY h.id, h.ten_hoa
            ORDER BY total_qty DESC
            LIMIT ?
            """;

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TopProductStats t = new TopProductStats();
                    t.setId(rs.getInt("id"));
                    t.setTen(rs.getString("ten_hoa"));
                    t.setTongSoLuong(rs.getInt("total_qty"));
                    t.setTongDoanhThu(rs.getDouble("total_revenue"));
                    list.add(t);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Top sản phẩm DOANH THU CAO NHẤT (toàn thời gian)
    public List<TopProductStats> getTopProductsByRevenue(int limit) {
        List<TopProductStats> list = new ArrayList<>();

        String sql = """
            SELECT h.id,
                   h.ten_hoa,
                   SUM(ct.so_luong) AS total_qty,
                   SUM(ct.so_luong * ct.don_gia) AS total_revenue
            FROM chi_tiet_don_hang ct
            JOIN don_hang d ON ct.id_don_hang = d.id
            JOIN hoa h ON ct.id_hoa = h.id
            WHERE d.trang_thai IN ('CONFIRMED','SHIPPING','DONE')
            GROUP BY h.id, h.ten_hoa
            ORDER BY total_revenue DESC
            LIMIT ?
            """;

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TopProductStats t = new TopProductStats();
                    t.setId(rs.getInt("id"));
                    t.setTen(rs.getString("ten_hoa"));
                    t.setTongSoLuong(rs.getInt("total_qty"));
                    t.setTongDoanhThu(rs.getDouble("total_revenue"));
                    list.add(t);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
