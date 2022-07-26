<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Product List | Nalika - Material Admin Template</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- favicon
		============================================ -->
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
    <!-- Google Fonts
		============================================ -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,700,900" rel="stylesheet">
    <!-- Bootstrap CSS
		============================================ -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Bootstrap CSS
		============================================ -->
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <!-- nalika Icon CSS
        ============================================ -->
    <link rel="stylesheet" href="css/nalika-icon.css">
    <!-- owl.carousel CSS
		============================================ -->
    <link rel="stylesheet" href="css/owl.carousel.css">
    <link rel="stylesheet" href="css/owl.theme.css">
    <link rel="stylesheet" href="css/owl.transitions.css">
    <!-- animate CSS
		============================================ -->
    <link rel="stylesheet" href="css/animate.css">
    <!-- normalize CSS
		============================================ -->
    <link rel="stylesheet" href="css/normalize.css">
    <!-- meanmenu icon CSS
		============================================ -->
    <link rel="stylesheet" href="css/meanmenu.min.css">
    <!-- main CSS
		============================================ -->
    <link rel="stylesheet" href="css/main.css">
    <!-- morrisjs CSS
		============================================ -->
    <link rel="stylesheet" href="css/morrisjs/morris.css">
    <!-- mCustomScrollbar CSS
		============================================ -->
    <link rel="stylesheet" href="css/scrollbar/jquery.mCustomScrollbar.min.css">
    <!-- metisMenu CSS
		============================================ -->
    <link rel="stylesheet" href="css/metisMenu/metisMenu.min.css">
    <link rel="stylesheet" href="css/metisMenu/metisMenu-vertical.css">
    <!-- calendar CSS
		============================================ -->
    <link rel="stylesheet" href="css/calendar/fullcalendar.min.css">
    <link rel="stylesheet" href="css/calendar/fullcalendar.print.min.css">
    <!-- style CSS
		============================================ -->
    <link rel="stylesheet" href="style.css">
    <!-- responsive CSS
		============================================ -->
    <link rel="stylesheet" href="css/responsive.css">
    <!-- modernizr JS
		============================================ -->
    <script src="js/vendor/modernizr-2.8.3.min.js"></script>
    <!--     css alert
    ============================-->
    <link rel="shortcut icon" href="assets\images\favicon.ico">
    <link href="assets/js/sweetalert2.min.css" rel="stylesheet" type="text/css">



</head>

<body>
<!--[if lt IE 8]>
<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade
    your browser</a> to improve your experience.</p>
<![endif]-->
<jsp:include page="/WEB-INF/admin/layout/navleft.jsp"></jsp:include>
<!-- Start Welcome area -->
<div class="all-content-wrapper">
    <jsp:include page="/WEB-INF/admin/layout/head.jsp"></jsp:include>
    <div class="product-status mg-b-30">
        <div class="container-fluid">

            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<%--                    <div class="add-product">--%>
<%--                        <a href="/products?action=create">Add Product</a>--%>
<%--                    </div>--%>
                    <div class="product-status-wrap">
                        <h4> Product List</h4>
                        <table>
                            <tr>
                                <th>Title</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Color</th>
                                <th>Category</th>
                                <th>Actions</th>
                            </tr>
                            <tbody id="myTable">
                            <c:forEach var="product" items="${listProduct}">
                                <tr>
                                    <td><c:out value="${product.getTitle()}"/></td>
                                    <td><fmt:formatNumber value="${product.getPrice()}" type="currency"
                                    /></td>
                                    <td><c:out value="${product.getQuantity()}"/></td>
                                    <td><c:out value="${product.getColor()}"/></td>
                                    <td>
                                        <c:forEach items="${applicationScope.listCategory }" var="category">
                                            <c:if test="${category.getId() == product.getCategory()}">
                                                <c:out value="${category.getCategory()}"/>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <button data-toggle="tooltip" title="Edit" class="pd-setting-ed"><a
                                                href="/products?action=edit&id=${product.id}"><i
                                                class="fa fa-pencil-square-o"
                                                aria-hidden="true"></i></a>
                                        </button>
                                        <button data-toggle="tooltip" title="Delete" class="pd-setting-ed"><a
                                                onclick=" showMessage(${product.id})"><i class="fa fa-trash-o"
                                                                                         aria-hidden="true"></i></a>
                                        </button>

                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <script>
                            function showMessage(id) {
                                // document.getElementById("dynamic-alert").addEventListener("click", () => {
                                //     Swal.fire ('Correct!', 'You got the answer right!', 'success');
                                // });

                                Swal.fire({
                                    title: 'Are you sure?',
                                    text: "You won't be able to revert this!",
                                    icon: 'warning',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    confirmButtonText: 'Yes, delete it!'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        window.location.href = "/products?action=delete&id=" + id;
                                    }
                                })
                            }
                        </script>
                        <%--                            <div class="custom-pagination">--%>
                        <%--								<ul class="pagination">--%>
                        <%--									<li class="page-item"><a class="page-link" href="#">Previous</a></li>--%>
                        <%--									<li class="page-item"><a class="page-link" href="#">1</a></li>--%>
                        <%--									<li class="page-item"><a class="page-link" href="#">2</a></li>--%>
                        <%--									<li class="page-item"><a class="page-link" href="#">3</a></li>--%>
                        <%--									<li class="page-item"><a class="page-link" href="#">Next</a></li>--%>
                        <%--								</ul>--%>
                        <%--                            </div>--%>
                        <%--                        <nav aria-label="Page navigation example">--%>
                        <%--                            <ul class="pagination">--%>

                        <%--                                <c:if test="${requestScope.currentPage != 1}">--%>
                        <%--                                    <li class="page-item"><a class="page-link"--%>
                        <%--                                                             href="/users?page=${requestScope.currentPage - 1}">Previous</a>--%>
                        <%--                                    </li>--%>
                        <%--                                </c:if>--%>
                        <%--                                <c:forEach begin="1" end="${noOfPages}" var="i">--%>
                        <%--                                    <c:choose>--%>
                        <%--                                        <c:when test="${requestScope.currentPage eq i}">--%>
                        <%--                                            <li class="page-item"><a class="page-link"--%>
                        <%--                                                                     href="/wines?page=${i}">${i}</a></li>--%>
                        <%--                                        </c:when>--%>
                        <%--                                        <c:otherwise>--%>
                        <%--                                            <li class="page-item"><a class="page-link"--%>
                        <%--                                                                     href="/wines?page=${i}">${i}</a></li>--%>
                        <%--                                        </c:otherwise>--%>
                        <%--                                    </c:choose>--%>
                        <%--                                </c:forEach>--%>
                        <%--                                <c:if test="${requestScope.currentPage lt requestScope.noOfPages}">--%>
                        <%--                                    <li class="page-item"><a class="page-link"--%>
                        <%--                                                             href="/wines?page=${requestScope.currentPage + 1}">Next</a>--%>
                        <%--                                    </li>--%>
                        <%--                                </c:if>--%>
                        <%--                            </ul>--%>
                        <%--                        </nav>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/admin/layout/footer.jsp"></jsp:include>
</div>

<!-- jquery
    ============================================ -->
<script src="js/vendor/jquery-1.12.4.min.js"></script>
<!-- bootstrap JS
    ============================================ -->
<script src="js/bootstrap.min.js"></script>
<!-- wow JS
    ============================================ -->
<script src="js/wow.min.js"></script>
<!-- price-slider JS
    ============================================ -->
<script src="js/jquery-price-slider.js"></script>
<!-- meanmenu JS
    ============================================ -->
<script src="js/jquery.meanmenu.js"></script>
<!-- owl.carousel JS
    ============================================ -->
<script src="js/owl.carousel.min.js"></script>
<!-- sticky JS
    ============================================ -->
<script src="js/jquery.sticky.js"></script>
<!-- scrollUp JS
    ============================================ -->
<script src="js/jquery.scrollUp.min.js"></script>
<!-- mCustomScrollbar JS
    ============================================ -->
<script src="js/scrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="js/scrollbar/mCustomScrollbar-active.js"></script>
<!-- metisMenu JS
    ============================================ -->
<script src="js/metisMenu/metisMenu.min.js"></script>
<script src="js/metisMenu/metisMenu-active.js"></script>
<!-- morrisjs JS
    ============================================ -->
<script src="js/sparkline/jquery.sparkline.min.js"></script>
<script src="js/sparkline/jquery.charts-sparkline.js"></script>
<!-- calendar JS
    ============================================ -->
<script src="js/calendar/moment.min.js"></script>
<script src="js/calendar/fullcalendar.min.js"></script>
<script src="js/calendar/fullcalendar-active.js"></script>
<!-- plugins JS
    ============================================ -->
<script src="js/plugins.js"></script>
<!-- main JS
    ============================================ -->
<script src="js/main.js"></script>
<!-- js alert
        ============================================ -->
<script src="assets/js/sweetalert2.min.js"></script>
<script src="assets\libs\toastr\toastr.min.js"></script>
<script src="assets\js\pages\toastr.init.js"></script>
</body>

</html>