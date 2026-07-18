<%-- 
    Document   : user-content
    Created on : Nov 20, 2025, 12:02:16 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>

<%
    List<User> users = (List<User>) request.getAttribute("users");
%>

<div class="content-header">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">Quản lý người dùng</h3>
        <a href="<%=request.getContextPath()%>/admin/user-add"
           class="btn btn-primary">
            <i class="fas fa-user-plus"></i> Thêm người dùng
        </a>
    </div>
</div>

<section class="content">

    <div class="card">
        <div class="card-body">

            <table class="table table-bordered table-hover">
                <thead class="table-secondary">
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Email</th>
                    <th>SĐT</th>
                    <th>Địa chỉ</th>
                    <th>Quyền</th>
                    <th style="width:150px;">Hành động</th>
                </tr>
                </thead>

                <tbody>
                <% if (users != null) {
                       for (User u : users) { %>

                    <tr>
                        <td><%=u.getId()%></td>
                        <td><%=u.getName()%></td>
                        <td><%=u.getEmail()%></td>
                        <td><%=u.getPhone()%></td>
                        <td><%=u.getAddress()%></td>
                        <td><%=u.getRole()%></td>

                        <td class="text-center">

                            <a href="<%=request.getContextPath()%>/admin/user-edit?id=<%=u.getId()%>"
                               class="btn btn-sm btn-warning">
                                Sửa
                            </a>

                            <a href="<%=request.getContextPath()%>/admin/user-delete?id=<%=u.getId()%>"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Xóa người dùng này?');">
                                Xóa
                            </a>

                        </td>
                    </tr>

                <% } } %>
                </tbody>

            </table>

        </div>
    </div>

</section>
