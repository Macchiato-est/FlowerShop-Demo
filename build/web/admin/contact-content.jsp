<%-- 
    Document   : contact-content
    Created on : Nov 20, 2025, 12:04:33 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ContactMessage" %>

<%
    List<ContactMessage> list = (List<ContactMessage>) request.getAttribute("contacts");
%>

<div class="container-fluid">

    <div class="d-flex justify-content-between mb-3">
        <h3>Quản lý liên hệ</h3>
    </div>

    <table class="table table-bordered table-hover">
        <thead class="table-secondary">
        <tr>
            <th>ID</th>
            <th>Họ tên</th>
            <th>Email</th>
            <th>SĐT</th>
            <th>Tiêu đề</th>
            <th>Nội dung</th>
            <th>Ngày gửi</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
        </thead>

        <tbody>
        <% for (ContactMessage c : list) { %>
        <tr>
            <td><%=c.getId()%></td>
            <td><%=c.getHoTen()%></td>
            <td><%=c.getEmail()%></td>
            <td><%=c.getSoDienThoai()%></td>
            <td><%=c.getTieuDe()%></td>

            <!-- Nội dung -->
            <td style="max-width: 250px;">
                <div style="white-space: normal;"><%=c.getNoiDung()%></div>
            </td>

            <td><%=c.getNgayGui()%></td>

            <td>
                <% if ("NEW".equals(c.getTrangThai())) { %>
                    <span class="badge badge-warning">Chưa phản hồi</span>
                <% } else { %>
                    <span class="badge badge-success">Đã phản hồi</span>
                <% } %>
            </td>

            <td>
                <% if ("NEW".equals(c.getTrangThai())) { %>
                    <form action="<%=request.getContextPath()%>/admin/contact-update" method="post">
                        <input type="hidden" name="id" value="<%=c.getId()%>">
                        <button class="btn btn-sm btn-primary">Đánh dấu đã trả lời</button>
                    </form>
                <% } %>
            </td>

        </tr>
        <% } %>
        </tbody>
    </table>

</div>
