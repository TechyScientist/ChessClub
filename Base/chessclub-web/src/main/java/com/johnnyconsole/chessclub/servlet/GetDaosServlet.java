package com.johnnyconsole.chessclub.servlet;

import com.johnnyconsole.chessclub.persistence.interfaces.GameDao;
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

    @EJB
    private GameDao gameDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().setAttribute("UserDao", userDao);
        request.getSession().setAttribute("GameDao", gameDao);
        response.sendRedirect(request.getHeader("Referer"));
    }

}
