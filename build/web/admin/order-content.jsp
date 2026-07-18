<%-- 
    Document   : order-content
    Created on : Nov 20, 2025, 11:59:14 AM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<div class="content-header">
    <h3 class="mb-4">Quản lý đơn hàng</h3>
</div>

<section class="content">

    <div class="card">
        <div class="card-body">

            <table class="table table-bordered table-hover">
                <thead class="table-secondary">
                <tr>
                    <th>ID</th>
                    <th>Khách hàng</th>
                    <th>Email</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Ngày lập</th>
                    <th style="width:180px;">Hành động</th>
                </tr>
                </thead>

                <tbody>
                <% if (orders != null) {
                       for (Order o : orders) { 
                           String st = o.getTrangThai();
                %>

                <tr>
                    <td><%=o.getId()%></td>
                    <td><%=o.getHoTenNhan()%></td>
                    <td><%=o.getEmail()%></td>
                    <td><%=String.format("%,.0f đ", o.getTongTien())%></td>

                    <td>
                        <% if ("PENDING".equals(st)) { %>
                            <span class="badge badge-warning">Chờ xác nhận</span>
                        <% } else if ("CONFIRMED".equals(st)) { %>
                            <span class="badge badge-info">Đã xác nhận</span>
                        <% } else if ("SHIPPING".equals(st)) { %>
                            <span class="badge badge-primary">Đang giao</span>
                        <% } else if ("DONE".equals(st)) { %>
                            <span class="badge badge-success">Hoàn thành</span>
                        <% } else if ("CANCELLED".equals(st)) { %>
                            <span class="badge badge-danger">Đã hủy</span>
                        <% } %>
                    </td>

                    <td><%=o.getNgayLap()%></td>

                    <td class="text-center">

                        <!-- Xem chi tiết -->
                        <a class="btn btn-sm btn-outline-secondary mb-1"
                           href="<%=request.getContextPath()%>/admin/order-detail?id=<%=o.getId()%>">
                            Chi tiết
                        </a>

                        <!-- Form cập nhật trạng thái -->
                        <form action="<%=request.getContextPath()%>/admin/order-update"
                              method="post" style="display:inline">

                            <input type="hidden" name="id" value="<%=o.getId()%>"/>

                            <% if ("PENDING".equals(st)) { %>
                                <button name="action" value="confirm"
                                        class="btn btn-sm btn-primary mb-1">
                                    Xác nhận
                                </button>
                                <button name="action" value="cancel"
                                        class="btn btn-sm btn-danger mb-1">
                                    Hủy
                                </button>

                            <% } else if ("CONFIRMED".equals(st)) { %>
                                <button name="action" value="ship"
                                        class="btn btn-sm btn-info mb-1">
                                    Giao hàng
                                </button>

                            <% } else if ("SHIPPING".equals(st)) { %>
                                <button name="action" value="done"
                                        class="btn btn-sm btn-success mb-1">
                                    Hoàn thành
                                </button>
                            <% } %>

                        </form>

                    </td>
                </tr>

                <% } } %>

                </tbody>

            </table>

        </div>
    </div>

</section>
