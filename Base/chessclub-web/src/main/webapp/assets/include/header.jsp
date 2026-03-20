<%@ page import="com.johnnyconsole.chessclub.persistence.User" %>
<%@ page import="com.johnnyconsole.chessclub.persistence.interfaces.UserDao" %>
<%@ page import="com.johnnyconsole.chessclub.persistence.interfaces.GameDao" %>
<%@ page import="com.johnnyconsole.chessclub.persistence.interfaces.EventDao" %>
<html>
  <head>
    <title>ChessClub Web<% if(pageTitle != null) { %>: <%= pageTitle %> <% } %></title>
    <link rel="stylesheet" href="/chessclub/assets/style/main.css">
  </head>
  <body>
    <% User signedInUser = (User) session.getAttribute("SignedInUser");
       UserDao userDao = (UserDao) session.getAttribute("UserDao");
       GameDao gameDao = (GameDao) session.getAttribute("GameDao");
       EventDao eventDao = (EventDao) session.getAttribute("EventDao");
       if(userDao == null || gameDao == null || eventDao == null) response.sendRedirect("/chessclub/GetDaosServlet");%>
    <header>
      <h1>ChessClub Web<% if(pageTitle != null) { %>: <%= pageTitle %> <% } %></h1>
    </header>
    <%@ include file="nav.jsp" %>
  <main>