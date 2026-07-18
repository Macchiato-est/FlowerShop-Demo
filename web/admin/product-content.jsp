<%-- 
    Document   : product-content
    Created on : Nov 20, 2025, 11:57:22 AM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="model.Product" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    Map<Integer,String> catMap = (Map<Integer,String>) request.getAttribute("catMap");
%>

<div class="content-header">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Quản lý sản phẩm</h3>

        <a href="<%=request.getContextPath()%>/admin/product-add"
           class="btn btn-primary">
            <i class="fas fa-plus"></i> Thêm sản phẩm
        </a>
    </div>
</div>

<section class="content">

    <div class="card">
        <div class="card-body">

            <table class="table table-bordered table-hover align-middle">
                <thead class="table-secondary">
                <tr>
                    <th>Ảnh</th>
                    <th>Tên</th>
                    <th>Loại</th>
                    <th>Giá</th>
                    <th>Giá gốc</th>
                    <th>SL</th>
                    <th style="width:150px;">Hành động</th>
                </tr>
                </thead>

                <tbody>
                <% if (products != null) {
                       for (Product p : products) { %>

                    <tr>
                        <td>
                            <img src="<%=request.getContextPath()%>/images/<%=p.getHinhAnh()%>"
                                 style="width:60px;height:60px;object-fit:cover;">
                        </td>

                        <td><%=p.getTen()%></td>

                        <td><%=catMap.getOrDefault(p.getMaLoai(), "N/A")%></td>

                        <td><%=String.format("%,.0f đ", p.getGia())%></td>

                        <td>
                            <%=p.getGiaGoc() > 0
                                   ? String.format("%,.0f đ", p.getGiaGoc())
                                   : "-" %>
                        </td>

                        <td><%=p.getSoLuong()%></td>

                        <td class="text-center">
                            <a href="<%=request.getContextPath()%>/admin/product-edit?id=<%=p.getId()%>"
                               class="btn btn-sm btn-outline-info">
                                <i class="fas fa-edit"></i> Sửa
                            </a>

                            <a href="<%=request.getContextPath()%>/admin/product-delete?id=<%=p.getId()%>"
                               class="btn btn-sm btn-outline-danger"
                               onclick="return confirm('Xóa sản phẩm này?');">
                                <i class="fas fa-trash"></i> Xóa
                            </a>
                        </td>
                    </tr>

                <% } } %>
                </tbody>

            </table>

        </div>
    </div>

</section>
