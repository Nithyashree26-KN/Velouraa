package com.tap.servlet;

import com.tap.DAO.UserDAO;
import com.tap.DAOImpl.UserDAOImpl;
import com.tap.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet: LoginServlet
 * Maps to /LoginServlet
 * Authenticates user via DB and creates a session on success
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    /** GET — redirect to login page */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.html");
    }

    /** POST — authenticate credentials against DB */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        // Authenticate via DAO
        UserDAO dao  = new UserDAOImpl();
        User    user = dao.login(email, password);

        if (user != null) {
            // Success — store user in session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            // Redirect to restaurant listing
            response.sendRedirect(request.getContextPath() + "/home");

        } else {
            // Failure — go back to login with error parameter
            response.sendRedirect("login.html?error=1");
        }
    }
}

