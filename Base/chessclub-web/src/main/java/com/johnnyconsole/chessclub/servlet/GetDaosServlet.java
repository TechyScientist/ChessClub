package com.johnnyconsole.chessclub.servlet;

import com.johnnyconsole.chessclub.persistence.interfaces.UserDao;

import javax.ejb.EJB;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("GetDaosServlet")
public class GetDaosServlet extends HttpServlet {

    @EJB
    private UserDao userDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().setAttribute("UserDao", userDao);
        response.sendRedirect(request.getHeader("Referer"));
    }

}
