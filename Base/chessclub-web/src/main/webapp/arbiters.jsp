<%@ page import="static javax.servlet.http.HttpServletResponse.*" %>
<%
    // Metadata strings for dynamic UI elements
    String pageName = "arbiters",
            pageTitle = "Arbiters' Menu";
%>
<%@ include file="assets/include/header.jsp" %>

<% if(signedInUser == null) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    response.sendRedirect("index.jsp");
} else if(!signedInUser.isOrganizer) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    session.setAttribute("role", "Arbiter");
    response.sendRedirect("dashboard.jsp");
} %>

<h3>Game Management</h3>
<a href="enter-results.jsp">Enter game results</a><br/><br/>
<a href="edit-results.jsp">Edit the results of an existing game</a>

<%@ include file="assets/include/footer.jsp" %>
