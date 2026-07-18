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

@WebServlet("/admin/export-revenue-7days")
public class ExportRevenue7DaysServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        OrderDAO dao = new OrderDAO();
        Map<String, Double> data = dao.getRevenueByDay();

        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Doanh thu 7 ngày");

        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("Ngày (YYYY-MM-DD)");
        header.createCell(1).setCellValue("Doanh thu (VND)");

        int rowIdx = 1;
        for (String day : data.keySet()) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(day);
            row.createCell(1).setCellValue(data.get(day));
        }

        resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        resp.setHeader("Content-Disposition", "attachment; filename=revenue-7days.xlsx");

        wb.write(resp.getOutputStream());
        wb.close();
    }
}
