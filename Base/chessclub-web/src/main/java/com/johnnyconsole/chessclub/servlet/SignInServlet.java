package com.johnnyconsole.chessclub.servlet;

import com.johnnyconsole.chessclub.persistence.User;
import com.johnnyconsole.chessclub.persistence.interfaces.UserDao;

import javax.ejb.EJB;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {

    @EJB
    private UserDao userDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if(request.getParameter("signin-submit") == null) {
            request.getSession().setAttribute("status", HttpServletResponse.SC_BAD_REQUEST);
            response.sendRedirect("/chessclub/signin.jsp");
        }

        String username = request.getParameter("username"),
                password = request.getParameter("password");
        User user = userDao.getUser(username);

        if(username.isEmpty() || password.isEmpty()) {
            request.getSession().setAttribute("status", HttpServletResponse.SC_NOT_ACCEPTABLE);
            response.sendRedirect("/chessclub/signin.jsp");
        }

        if(user == null) {
            request.getSession().setAttribute("status", HttpServletResponse.SC_NOT_FOUND);
            response.sendRedirect("/chessclub/signin.jsp");
        }

        if(!userDao.verifyUserPassword(user, password)) {
            request.getSession().setAttribute("status", HttpServletResponse.SC_UNAUTHORIZED);
            response.sendRedirect("/chessclub/signin.jsp");
        }

        request.getSession().setAttribute("SignedInUser", user);
        response.sendRedirect("/chessclub/dashboard.jsp");

    }
}