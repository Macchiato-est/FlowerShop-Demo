<%-- 
    Document   : index
    Created on : Nov 18, 2025, 9:22:19 AM
    Author     : 06052
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    request.setAttribute("pageTitle", "Dashboard");
    request.setAttribute("contentPage", "/admin/dashboard-content.jsp");
%>
<jsp:forward page="/admin/layout/admin-layout.jsp"/>
