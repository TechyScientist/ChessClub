<%@ page import="com.johnnyconsole.chessclub.persistence.User" %>
<html>
  <head>
    <title>ChessClub Web<% if(pageTitle != null) { %>: <%= pageTitle %> <% } %></title>
    <link rel="stylesheet" href="/chessclub/assets/style/main.css">
  </head>
  <body>
    <% User signedInUser = (User) session.getAttribute("SignedInUser"); %>
    <header>
      <h1>ChessClub Web<% if(pageTitle != null) { %>: <%= pageTitle %> <% } %></h1>
    </header>
    <%@ include file="nav.jsp" %>
  <main>