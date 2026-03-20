<%@ page import="static javax.servlet.http.HttpServletResponse.*" %>
<%
    // Metadata strings for dynamic UI elements
    String pageName = "organizers",
            pageTitle = "Organizers' Menu";
%>
<%@ include file="assets/include/header.jsp" %>

<% if(signedInUser == null) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    response.sendRedirect("index.jsp");
} else if(!signedInUser.isOrganizer) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    session.setAttribute("role", "Organizer");
    response.sendRedirect("dashboard.jsp");
} %>

<h3>Event Management</h3>
<a href="add-event.jsp">Create a new event</a><br/><br/>
<a href="edit-event.jsp">Edit an existing event</a>

<%@ include file="assets/include/footer.jsp" %>
