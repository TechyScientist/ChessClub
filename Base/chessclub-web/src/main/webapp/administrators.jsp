<%@ page import="static javax.servlet.http.HttpServletResponse.*" %>
<%
    // Metadata strings for dynamic UI elements
    String pageName = "administrators",
            pageTitle = "Administrators' Menu";
%>
<%@ include file="assets/include/header.jsp" %>

<% if(signedInUser == null) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    response.sendRedirect("index.jsp");
} else if(!signedInUser.isOrganizer) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    session.setAttribute("role", "Administrator");
    response.sendRedirect("dashboard.jsp");
} %>

<h3>User Management</h3>
<a href="add-user.jsp">Create a new user profile</a><br/><br/>
<a href="edit-user.jsp">Edit an existing user profile</a><br/><br/>

<h3>Event Management</h3>
<a href="delete-event.jsp">Delete an existing event</a><br/><br/>

<h3>Game Management</h3>
<a href="delete-game.jsp">Delete an existing game</a>

<%@ include file="assets/include/footer.jsp" %>
