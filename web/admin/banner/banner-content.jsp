<%-- 
    Document   : banner-content
    Created on : Nov 20, 2025, 12:22:25 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Banner" %>

<%
    List<Banner> banners = (List<Banner>) request.getAttribute("banners");
%>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h3>Quản lý Banner</h3>
    <a href="${pageContext.request.contextPath}/admin/banner-add"
       class="btn btn-primary">
        <i class="fas fa-plus"></i> Thêm banner
    </a>
</div>

<table class="table table-bordered table-hover">
    <thead class="table-secondary">
    <tr>
        <th>Ảnh</th>
        <th>Tiêu đề</th>
        <th>Trạng thái</th>
        <th style="width: 150px;">Hành động</th>
    </tr>
    </thead>

    <tbody>
    <% if (banners != null) {
           for (Banner b : banners) { %>

        <tr>
            <td>
                <img src="<%=request.getContextPath()%>/images/banner/<%=b.getHinhAnh()%>"
                     style="width:140px;height:70px;object-fit:cover;border-radius:6px;">
            </td>

            <td><%=b.getTieuDe()%></td>

            <td>
                <% if ("SHOW".equals(b.getTrangThai())) { %>
                    <span class="badge badge-success">Hiển thị</span>
                <% } else { %>
                    <span class="badge badge-secondary">Ẩn</span>
                <% } %>
            </td>

            <td class="text-center">
                <a href="${pageContext.request.contextPath}/admin/banner-edit?id=<%=b.getId()%>"
                   class="btn btn-sm btn-warning">
                    <i class="fas fa-edit"></i> Sửa
                </a>

                <a href="${pageContext.request.contextPath}/admin/banner-delete?id=<%=b.getId()%>"
                   onclick="return confirm('Xóa banner này?');"
                   class="btn btn-sm btn-danger">
                    <i class="fas fa-trash"></i> Xóa
                </a>
            </td>
        </tr>

    <% } } %>
    </tbody>
</table>
