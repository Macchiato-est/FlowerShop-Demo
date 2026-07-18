/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author 06052
 */


import java.sql.Timestamp;
import java.util.List;

public class Order {

    private int id;
    private int idNguoiDung;
    private String hoTenNhan;
    private String dienThoaiNhan;
    private String diaChiNhan;
    private String email;
    private Timestamp ngayLap;
    private String trangThai;
    private double tongTien;
    private List<OrderItem> items;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }

    public String getHoTenNhan() { return hoTenNhan; }
    public void setHoTenNhan(String hoTenNhan) { this.hoTenNhan = hoTenNhan; }

    public String getDienThoaiNhan() { return dienThoaiNhan; }
    public void setDienThoaiNhan(String dienThoaiNhan) { this.dienThoaiNhan = dienThoaiNhan; }

    public String getDiaChiNhan() { return diaChiNhan; }
    public void setDiaChiNhan(String diaChiNhan) { this.diaChiNhan = diaChiNhan; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public Timestamp getNgayLap() { return ngayLap; }
    public void setNgayLap(Timestamp ngayLap) { this.ngayLap = ngayLap; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public double getTongTien() { return tongTien; }
    public void setTongTien(double tongTien) { this.tongTien = tongTien; }

    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }
}