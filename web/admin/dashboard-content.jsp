<%-- 
    Document   : dashboard-content
    Created on : Nov 20, 2025, 11:52:12 AM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    Map<String, Integer> stats = (Map<String, Integer>) request.getAttribute("stats");
%>

<h3 class="mb-3">Dashboard</h3>
<p class="text-muted">Tổng quan hệ thống</p>

<div class="row">

    <!-- 4 box thống kê nhanh -->
    <div class="col-lg-3 col-6">
        <div class="small-box bg-info">
            <div class="inner">
                <h3><%= stats.get("newOrders") %></h3>
                <p>Đơn hàng mới</p>
            </div>
            <div class="icon">
                <i class="fas fa-shopping-cart"></i>
            </div>
        </div>
    </div>

    <div class="col-lg-3 col-6">
        <div class="small-box bg-success">
            <div class="inner">
                <h3><%= stats.get("products") %></h3>
                <p>Sản phẩm</p>
            </div>
            <div class="icon">
                <i class="fas fa-box"></i>
            </div>
        </div>
    </div>

    <div class="col-lg-3 col-6">
        <div class="small-box bg-warning">
            <div class="inner">
                <h3><%= stats.get("shipping") %></h3>
                <p>Đơn đang giao</p>
            </div>
            <div class="icon">
                <i class="fas fa-shipping-fast"></i>
            </div>
        </div>
    </div>

    <div class="col-lg-3 col-6">
        <div class="small-box bg-danger">
            <div class="inner">
                <h3><%= stats.get("cancelled") %></h3>
                <p>Đơn bị hủy</p>
            </div>
            <div class="icon">
                <i class="fas fa-times-circle"></i>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Biểu đồ doanh thu -->
    <div class="row mt-4 w-100">

        <!-- Doanh thu 7 ngày -->
        <div class="col-md-6 mb-4">
            <div class="card p-3 report-card">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h5 class="mb-0">Doanh thu 7 ngày gần nhất</h5>

                    <a href="${pageContext.request.contextPath}/admin/export-revenue-7days"
                       class="btn btn-success btn-sm">
                        <i class="fas fa-file-excel"></i> Tải Excel
                    </a>
                </div>

                <canvas id="dailyChart"></canvas>
            </div>
        </div>

        <!-- Doanh thu 12 tháng -->
        <div class="col-md-6 mb-4">
            <div class="card p-3 report-card">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h5 class="mb-0">Doanh thu 12 tháng gần nhất</h5>

                    <a href="${pageContext.request.contextPath}/admin/export-revenue-12months"
                       class="btn btn-primary btn-sm">
                        <i class="fas fa-file-excel"></i> Tải Excel
                    </a>
                </div>

                <canvas id="monthlyChart"></canvas>
            </div>
        </div>

    </div>

    <!-- Top sản phẩm -->
    <div class="row mt-4 w-100">

        <!-- Top bán chạy 30 ngày gần nhất -->
        <div class="col-md-6 mb-4">
            <div class="card p-3 report-card">
                <h5 class="mb-3">Top sản phẩm bán chạy (30 ngày gần nhất)</h5>

                <table class="table table-sm mb-0">
                    <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th class="text-end">SL bán</th>
                        <th class="text-end">Doanh thu</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${topProducts30Days}">
                        <tr>
                            <td>${p.ten}</td>
                            <td class="text-end">${p.tongSoLuong}</td>
                            <td class="text-end">
                                <fmt:formatNumber value="${p.tongDoanhThu}" type="number"/>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty topProducts30Days}">
                        <tr>
                            <td colspan="3" class="text-center text-muted">
                                Chưa có dữ liệu đơn hàng.
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Top sản phẩm doanh thu cao nhất (toàn thời gian) -->
        <div class="col-md-6 mb-4">
            <div class="card p-3 report-card">
                <h5 class="mb-3">Top sản phẩm doanh thu cao nhất</h5>

                <table class="table table-sm mb-0">
                    <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th class="text-end">SL bán</th>
                        <th class="text-end">Doanh thu</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${topRevenueProducts}">
                        <tr>
                            <td>${p.ten}</td>
                            <td class="text-end">${p.tongSoLuong}</td>
                            <td class="text-end">
                                <fmt:formatNumber value="${p.tongDoanhThu}" type="number"/>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty topRevenueProducts}">
                        <tr>
                            <td colspan="3" class="text-center text-muted">
                                Chưa có dữ liệu đơn hàng.
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <script>
        // Dữ liệu từ servlet
        const dailyLabels = [
            <% for(String day : ((Map<String,Double>)request.getAttribute("dailyRevenue")).keySet()) { %>
                "<%= day %>",
            <% } %>
        ];

        const dailyData = [
            <% for(Double val : ((Map<String,Double>)request.getAttribute("dailyRevenue")).values()) { %>
                <%= val %>,
            <% } %>
        ];

        const monthlyLabels = [
            <% for(String m : ((Map<String,Double>)request.getAttribute("monthlyRevenue")).keySet()) { %>
                "<%= m %>",
            <% } %>
        ];

        const monthlyData = [
            <% for(Double val : ((Map<String,Double>)request.getAttribute("monthlyRevenue")).values()) { %>
                <%= val %>,
            <% } %>
        ];

        // Vẽ biểu đồ ngày
        new Chart(document.getElementById("dailyChart"), {
            type: "line",
            data: {
                labels: dailyLabels.reverse(),
                datasets: [{
                    label: "VNĐ",
                    data: dailyData.reverse(),
                    borderWidth: 2,
                    tension: 0.2
                }]
            }
        });

        // Vẽ biểu đồ tháng
        new Chart(document.getElementById("monthlyChart"), {
            type: "bar",
            data: {
                labels: monthlyLabels.reverse(),
                datasets: [{
                    label: "VNĐ",
                    data: monthlyData.reverse(),
                    borderWidth: 2
                }]
            }
        });
    </script>

</div>
