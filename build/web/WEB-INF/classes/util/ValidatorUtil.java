/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author 06052
 */

public class ValidatorUtil {

    // Kiểm tra số điện thoại VN: bắt đầu bằng 0, 10–11 chữ số
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches("0[0-9]{9,10}");
    }

    // Kiểm tra email đơn giản, vd dạng a@a.com là đạt rùi
    public static boolean isValidEmail(String email) {
        if (email == null || email.isBlank()) return false;
        return email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    }
}
