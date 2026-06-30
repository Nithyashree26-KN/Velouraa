package com.tap.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet implementation class RegisterServlet
 * Handles user registration form submissions
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterServlet() {
        super();
    }

    /**
     * Handles GET — redirect to registration page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("registration.html");
    }

    /**
     * Handles POST — process registration form data
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("fname");
        String lastName  = request.getParameter("lname");
        String email     = request.getParameter("email");
        String phone     = request.getParameter("phone");
        String password  = request.getParameter("password");

        // Combine names into username
        String username = firstName + " " + lastName;

        com.tap.model.User user = new com.tap.model.User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("customer");
        // Use phone number or empty string as placeholder address for registration
        user.setAddress(phone); 

        com.tap.DAOImpl.UserDAOImpl userDAO = new com.tap.DAOImpl.UserDAOImpl();
        userDAO.addUser(user);

        // After successful registration, redirect to login page
        response.sendRedirect("login.html");
    }
}
