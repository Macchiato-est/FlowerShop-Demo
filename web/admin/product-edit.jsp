<%-- 
    Document   : product-edit
    Created on : Nov 19, 2025, 4:39:57 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product, model.Category" %>

<%
    Product p = (Product) request.getAttribute("product");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Sửa sản phẩm</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid mt-4">

                <h3>Sửa sản phẩm</h3>

                <form action="<%=request.getContextPath()%>/admin/product-edit"
                      method="post" enctype="multipart/form-data">

                    <input type="hidden" name="id" value="<%=p.getId()%>">
                    <input type="hidden" name="oldImage" value="<%=p.getHinhAnh()%>">

                    <div class="row">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label>Tên sản phẩm</label>
                                <input type="text" name="ten" class="form-control"
                                       value="<%=p.getTen()%>" required>
                            </div>

                            <div class="form-group">
                                <label>Loại hoa</label>
                                <select name="maLoai" class="form-control" required>
                                    <% for (Category c : categories) { %>
                                        <option value="<%=c.getId()%>"
                                            <%= (c.getId() == p.getMaLoai() ? "selected" : "") %>>
                                            <%=c.getTenLoai()%>
                                        </option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Giá bán</label>
                                <input type="number" name="gia" step="1000" class="form-control"
                                       value="<%=p.getGia()%>" required>
                            </div>

                            <div class="form-group">
                                <label>Giá gốc</label>
                                <input type="number" name="giaGoc" step="1000" class="form-control"
                                       value="<%=p.getGiaGoc()%>">
                            </div>

                            <div class="form-group">
                                <label>Số lượng</label>
                                <input type="number" name="soLuong" class="form-control"
                                       value="<%=p.getSoLuong()%>" required>
                            </div>

                            <div class="form-group">
                                <label>Mô tả</label>
                                <textarea name="moTa" rows="4" class="form-control"><%=p.getMoTa()%></textarea>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Ảnh hiện tại</label><br>
                                <img src="<%=request.getContextPath()%>/images/<%=p.getHinhAnh()%>"
                                     style="width:120px;height:120px;object-fit:cover;border:1px solid #ccc;">
                            </div>

                            <div class="form-group">
                                <label>Đổi ảnh (nếu muốn)</label>
                                <input type="file" name="anh" class="form-control-file">
                            </div>
                        </div>
                    </div>
                                     
                        <div class="form-check">
                            <input class="form-check-input"
                                   type="checkbox"
                                   id="isRecommended"
                                   name="isRecommended"
                                   ${product != null && product.recommended ? "checked" : ""}>
                            <label class="form-check-label" for="isRecommended">
                                Gợi ý hôm nay
                            </label>
                        </div>

         
                    <button class="btn btn-primary">Cập nhật</button>
                    <a href="<%=request.getContextPath()%>/admin/products"
                       class="btn btn-secondary">Hủy</a>
                </form>

            </div>
        </section>
    </div>

</div>
</body>
</html>
