<%-- 
    Document   : order-detail
    Created on : Nov 19, 2025, 4:08:36 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderItem" %>
<%@ page import="java.util.List" %>

<%
    Order order = (Order) request.getAttribute("order");
    List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="hold-transition sidebar-mini">

<div class="wrapper">

    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid mt-4">

                <h3 class="mb-3">Chi tiết đơn hàng #<%=order.getId()%></h3>

                <div class="card mb-4">
                    <div class="card-body">
                        <p><strong>Người nhận:</strong> <%=order.getHoTenNhan()%></p>
                        <p><strong>Điện thoại:</strong> <%=order.getDienThoaiNhan()%></p>
                        <p><strong>Địa chỉ:</strong> <%=order.getDiaChiNhan()%></p>
                        <p><strong>Email:</strong> <%=order.getEmail()%></p>
                        <p><strong>Ngày lập:</strong> <%=order.getNgayLap()%></p>
                        <p><strong>Tổng tiền:</strong> <%=String.format("%,.0f đ", order.getTongTien())%></p>
                        <p><strong>Trạng thái:</strong> <%=order.getTrangThai()%></p>
                    </div>
                </div>

                <h5>Sản phẩm trong đơn hàng</h5>

                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                    <tr>
                        <th>Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (items != null) {
                        for (OrderItem it : items) { %>
                        <tr>
                            <td>
                                <img src="<%=request.getContextPath()%>/images/<%=it.getImage()%>"
                                     alt="" style="width:60px;height:60px;object-fit:cover;">
                            </td>
                            <td><%=it.getProductName()%></td>
                            <td><%=String.format("%,.0f đ", it.getDonGia())%></td>
                            <td><%=it.getSoLuong()%></td>
                            <td><%=String.format("%,.0f đ", it.getDonGia() * it.getSoLuong())%></td>
                        </tr>
                    <% } } %>
                    </tbody>
                </table>

                <form action="<%=request.getContextPath()%>/admin/order-update" method="post" class="mt-3">
                    <input type="hidden" name="id" value="<%=order.getId()%>">
                    <input type="hidden" name="from" value="detail">

                    <% String st = order.getTrangThai();
                       if ("PENDING".equals(st)) { %>
                        <button name="action" value="confirm" class="btn btn-primary">Xác nhận</button>
                        <button name="action" value="cancel" class="btn btn-danger">Hủy đơn</button>
                    <% } else if ("CONFIRMED".equals(st)) { %>
                        <button name="action" value="ship" class="btn btn-info">Chuyển sang đang giao</button>
                    <% } else if ("SHIPPING".equals(st)) { %>
                        <button name="action" value="done" class="btn btn-success">Hoàn thành đơn</button>
                    <% } %>

                    <a href="<%=request.getContextPath()%>/admin/orders"
                       class="btn btn-secondary ml-2">Quay lại danh sách</a>
                </form>

            </div>
        </section>
    </div>

</div>

</body>
</html>
