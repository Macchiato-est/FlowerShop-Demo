<%-- 
    Document   : category-content
    Created on : Nov 20, 2025, 12:01:03 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<div class="content-header">
    <div class="d-flex justify-content-between mb-3">
        <h3>Quản lý loại hoa</h3>
        <a href="<%=request.getContextPath()%>/admin/category-add"
           class="btn btn-primary">Thêm loại hoa</a>
    </div>
</div>

<section class="content">

    <!-- THÔNG BÁO LỖI -->
    <c:if test="${not empty error}">
        <p class="text-danger mt-2">
            <i class="fas fa-exclamation-circle"></i>
            ${error}
        </p>
    </c:if>

    <!-- THÔNG BÁO THÀNH CÔNG -->
    <c:if test="${not empty success}">
        <p class="text-success mt-2">
            <i class="fas fa-check-circle"></i>
            ${success}
        </p>
    </c:if>

    <div class="card mt-3">
        <div class="card-body">

            <table class="table table-bordered table-hover">
                <thead class="table-secondary">
                <tr>
                    <th>ID</th>
                    <th>Tên loại</th>
                    <th style="width:150px;">Hành động</th>
                </tr>
                </thead>

                <tbody>
                <% for (Category c : categories) { %>
                <tr>
                    <td><%=c.getId()%></td>
                    <td><%=c.getTenLoai()%></td>

                    <td class="text-center">
                        <a href="<%=request.getContextPath()%>/admin/category-edit?id=<%=c.getId()%>"
                           class="btn btn-sm btn-warning">
                            Sửa
                        </a>

                        <a href="<%=request.getContextPath()%>/admin/category-delete?id=<%=c.getId()%>"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Xóa loại hoa này?');">
                            Xóa
                        </a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>

        </div>
    </div>

</section>
