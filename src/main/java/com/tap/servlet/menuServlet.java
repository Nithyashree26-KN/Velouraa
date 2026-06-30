package com.tap.servlet;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImpl.MenuDAOImpl;
import com.tap.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class menuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

        
        MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
        List<Menu> allMenusByRestaurant =
                menuDAOImpl.getAllMenusByRestaurant(restaurantId);

       
        for (Menu menu : allMenusByRestaurant) {
            System.out.println(menu);
        }

        
        req.setAttribute("allMenusByRestaurant", allMenusByRestaurant);

        RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
        rd.forward(req, resp);
    }
}