package com.johnnyconsole.chessclub.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/SignOutServlet")
public class SignOutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().removeAttribute("SignedInUser");
        request.getSession().setAttribute("status", HttpServletResponse.SC_ACCEPTED);
        response.sendRedirect("/chessclub");
    }
}