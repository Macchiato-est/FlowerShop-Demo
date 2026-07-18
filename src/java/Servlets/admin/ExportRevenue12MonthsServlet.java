/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/export-revenue-12months")
public class ExportRevenue12MonthsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1) Lấy dữ liệu từ DAO
        OrderDAO dao = new OrderDAO();
        Map<String, Double> data = dao.getRevenueByMonth();  // Key: YYYY-MM

        // 2) Tạo workbook + sheet
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Doanh thu 12 tháng");

        // 3) Header
        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("Tháng (YYYY-MM)");
        header.createCell(1).setCellValue("Doanh thu (VND)");

        // 4) Ghi dữ liệu vào sheet
        int rowIdx = 1;
        for (String month : data.keySet()) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(month);
            row.createCell(1).setCellValue(data.get(month));
        }

        // 5) Set kiểu file trả về
        resp.setContentType(
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        );
        resp.setHeader(
                "Content-Disposition",
                "attachment; filename=revenue_12months.xlsx"
        );

        // 6) Xuất file
        wb.write(resp.getOutputStream());
        wb.close();
    }
}

