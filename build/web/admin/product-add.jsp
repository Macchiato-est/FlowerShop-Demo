<%-- 
    Document   : product-add
    Created on : Nov 19, 2025, 4:45:41 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>

<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm</title>

    <!-- AdminLTE + Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

</head>

<body class="hold-transition sidebar-mini">
<div class="wrapper">


    <!-- CONTENT -->
    <div class="content-wrapper p-4">

        <h3 class="mb-4">Thêm sản phẩm mới</h3>

        <form action="<%=request.getContextPath()%>/admin/product-add"
              method="post"
              enctype="multipart/form-data"
              class="card p-4">

            <div class="row">

                <!-- CỘT TRÁI -->
                <div class="col-md-8">

                    <div class="form-group mb-3">
                        <label>Tên sản phẩm</label>
                        <input type="text" name="ten" class="form-control" required>
                    </div>

                    <div class="form-group mb-3">
                        <label>Loại hoa</label>
                        <select name="maLoai" class="form-control" required>
                            <% for (Category c : categories) { %>
                                <option value="<%=c.getId()%>"><%=c.getTenLoai()%></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-group mb-3">
                        <label>Giá bán</label>
                        <input type="number" name="gia" class="form-control" step="1000" required>
                    </div>

                    <div class="form-group mb-3">
                        <label>Giá gốc (nếu có)</label>
                        <input type="number" name="giaGoc" class="form-control" step="1000" value="0">
                    </div>

                    <div class="form-group mb-3">
                        <label>Số lượng</label>
                        <input type="number" name="soLuong" class="form-control" value="0" required>
                    </div>

                    <div class="form-group mb-3">
                        <label>Mô tả</label>
                        <textarea name="moTa" class="form-control" rows="4"></textarea>
                    </div>

                </div>

                <!-- CỘT PHẢI -->
                <div class="col-md-4">

                    <div class="form-group mb-3">
                        <label>Ảnh sản phẩm</label>
                        <input type="file" name="anh" class="form-control-file" accept="image/*">
                    </div>

                    <div class="border p-2 text-center bg-light">
                        <p class="text-muted mb-2">Xem trước ảnh</p>
                        <img id="preview"
                             src="<%=request.getContextPath()%>/images/no-image.png"
                             style="width:150px;height:150px;object-fit:cover;border:1px solid #ccc;">
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


         
                </div>
            </div>

            <button class="btn btn-primary mt-3">
                <i class="fas fa-save"></i> Lưu sản phẩm
            </button>

            <a href="<%=request.getContextPath()%>/admin/products"
               class="btn btn-secondary mt-3 ml-2">
                <i class="fas fa-arrow-left"></i> Hủy
            </a>

        </form>

    </div>

</div>

<!-- JS preview ảnh -->
<script>
    document.querySelector("input[name='anh']").addEventListener("change", function (e) {
        const file = e.target.files[0];
        if (file) {
            document.getElementById("preview").src = URL.createObjectURL(file);
        }
    });
</script>

</body>
</html>
