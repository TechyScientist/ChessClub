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

<%@ include file="assets/include/footer.jsp" %>
