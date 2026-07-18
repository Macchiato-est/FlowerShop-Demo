<%-- 
    Document   : leftmenu
    Created on : Nov 20, 2025, 10:13:32 PM
    Author     : 06052
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="leftmenu-wrapper">
    <div class="left-menu">
        <h5 class="mb-3">Danh mục</h5>

        <ul class="list-group">
            <c:forEach var="c" items="${categories}">
                <li class="list-group-item">
                    <a href="${pageContext.request.contextPath}/index?cat=${c.id}#products-section"
                       class="text-decoration-none">
                        ${c.tenLoai}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
</aside>
