package com.codegym.controller;

import com.codegym.DAO.CategoryDAO;
import com.codegym.DAO.ICategoryDAO;
import com.codegym.DAO.IProductDAO;
import com.codegym.DAO.ProductDAO;
import com.codegym.model.Category;
import com.codegym.model.Product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.BiConsumer;

@WebServlet(name = "ProductServlet", urlPatterns = "/products")
public class ProductServlet extends HttpServlet {
    private IProductDAO iProductDAO;
    private String errors = "";
    private ICategoryDAO iCategoryDAO;

    @Override
    public void init() throws ServletException {
        iProductDAO = new ProductDAO();
        iCategoryDAO = new CategoryDAO();
        if (this.getServletContext().getAttribute("listCategory") == null) {
            this.getServletContext().setAttribute("listCategory", iCategoryDAO.selectAllCategory());
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "create":
                    showNewForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    deleteProduct(req, resp);
                    break;

                default:
                    listProduct(req, resp);
                    break;

            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "create":
                    insertProduct(req, resp);
                    break;
                case "edit":
                    updateProduct(req, resp);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Product> listProduct = iProductDAO.selectAllProduct();
        request.setAttribute("listProduct", listProduct);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/product/listproduct.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        List<Category> listCategory = iCategoryDAO.selectAllCategory();
        request.setAttribute("listCategory", listCategory);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/product/createproduct.jsp");
        dispatcher.forward(request,response);
    }

    private void insertProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        String title = request.getParameter("title");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String color = request.getParameter("color");
        String description = request.getParameter("description");
        int category = Integer.parseInt(request.getParameter("category"));


        Product newProduct = new Product(title, price, quantity,color,description,category);
        iProductDAO.insertProduct(newProduct);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/product/createproduct.jsp");
        dispatcher.forward(request, response);


//        Product product = new Product();
//        boolean flag = true;
//        Map<String, String> hashMap = new HashMap<String, String>();
//        try {
//            product.setId(Integer.parseInt(request.getParameter("id")));
//            String title = request.getParameter("title");
//            product.setTitle(title);
//            int quantity = Integer.parseInt(request.getParameter("quantity"));
//            product.setQuantity(quantity);
//            double price = Double.parseDouble(request.getParameter("price"));
//            product.setPrice(price);
//            String description= request.getParameter("description");
//            product.setDescription(description);
//            String color = request.getParameter("color");
//            product.setColor(color);
//            int category = Integer.parseInt(request.getParameter("category"));
//
//
//
//            ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
//            Validator validator = validatorFactory.getValidator();
//
//            Set<ConstraintViolation<Product>> constraintViolations = validator.validate(product);
//
//            if (!constraintViolations.isEmpty()) {
//
//                errors = "<ul>";
//                // constraintViolations is has error
//                for (ConstraintViolation<Product> constraintViolation : constraintViolations) {
//                    errors += "<li>" + constraintViolation.getPropertyPath() + " " + constraintViolation.getMessage()
//                            + "</li>";
//                }
//                errors += "</ul>";
//
//
//                request.setAttribute("product", product);
//                request.setAttribute("errors", errors);
//
//                List<Category> listCategory = iCategoryDAO.selectAllCategory();
//                request.setAttribute("listCategory", listCategory);
//
//                request.getRequestDispatcher("/WEB-INF/admin/product/createproduct.jsp").forward(request, response);
//            } else {
//
//
//                if (flag) {
//                    // Create user susscess
//                    iProductDAO.insertProduct(product);
//
//
//                    Product p = new Product();
//                    request.setAttribute("product", p);
//                    request.getRequestDispatcher("/WEB-INF/admin/product/createproduct.jsp").forward(request, response);
//
//                } else {
//
//                    errors = "<ul>";
//
//                    hashMap.forEach(new BiConsumer<String, String>() {
//                        @Override
//                        public void accept(String keyError, String valueError) {
//                            errors += "<li>" + valueError
//                                    + "</li>";
//
//                        }
//                    });
//                    errors += "</ul>";
//
//                    request.setAttribute("product", product);
//                    request.setAttribute("errors", errors);
//
//                    request.getRequestDispatcher("/WEB-INF/admin/product/createproduct.jsp").forward(request, response);
//                }
//            }
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }
    }
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product existingUser = iProductDAO.selectProduct(id);


        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/product/editproduct.jsp");
        request.setAttribute("product", existingUser);
        dispatcher.forward(request, response);

    }
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String color = request.getParameter("color");
        String description = request.getParameter("description");
        int category = Integer.parseInt(request.getParameter("category"));

        Product book = new Product(id, title, price, quantity,color,description,category);
        iProductDAO.updateProduct(book);
        /*
         * RequestDispatcher dispatcher = request.getRequestDispatcher("user/edit.jsp");
         * dispatcher.forward(request, response);
         */
        response.sendRedirect("/products");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        iProductDAO.deleteProduct(id);

        List<Product> listProduct = iProductDAO.selectAllProduct();
        request.setAttribute("listProduct", listProduct);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/product/listproduct.jsp");
        dispatcher.forward(request, response);
    }

}
