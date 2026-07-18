<%-- 
    Document   : users
    Created on : Nov 19, 2025, 5:21:57 PM
    Author     : 06052
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    request.setAttribute("pageTitle", "Quản lý người dùng");
    request.setAttribute("contentPage", "/admin/user-content.jsp");
%>
<jsp:forward page="/admin/layout/admin-layout.jsp"/>
