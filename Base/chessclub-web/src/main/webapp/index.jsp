<%@ page import="static javax.servlet.http.HttpServletResponse.*" %>
<%
    // Metadata strings for dynamic UI elements
    String pageName = "home",
            pageTitle = null;
%>
<%@ include file="assets/include/header.jsp" %>
<% if(signedInUser != null) {
    response.sendRedirect("dashboard.jsp");
}

int status = session.getAttribute("status") == null ? SC_OK : (int)session.getAttribute("status");
if(status == SC_ACCEPTED) { %>
    <p id="success"><strong>You have been signed out.</strong></p>
<% } else if(status == SC_UNAUTHORIZED) { %>
    <p id="error"><strong>Error</strong>: You must be signed in to do that.</p>
<% }
session.removeAttribute("status"); %>
<%@ include file="assets/include/footer.jsp" %>
