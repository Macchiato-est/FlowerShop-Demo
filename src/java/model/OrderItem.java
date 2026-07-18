/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author 06052
 */



public class OrderItem {

    private int id;
    private int idDonHang;
    private int idHoa;
    private int soLuong;
    private double donGia;

    private String productName;  // ten_hoa
    private String image;        // anh

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdDonHang() { return idDonHang; }
    public void setIdDonHang(int idDonHang) { this.idDonHang = idDonHang; }

    public int getIdHoa() { return idHoa; }
    public void setIdHoa(int idHoa) { this.idHoa = idHoa; }

    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }

    public double getDonGia() { return donGia; }
    public void setDonGia(double donGia) { this.donGia = donGia; }

    public double getThanhTien() {
        return donGia * soLuong;
    }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}