<%@ page import="static javax.servlet.http.HttpServletResponse.SC_OK" %>
<%@ page import="static javax.servlet.http.HttpServletResponse.SC_ACCEPTED" %>
<%
    // Metadata strings for dynamic UI elements
    String pageName = "home",
            pageTitle = null;
%>
<%@ include file="assets/include/header.jsp" %>
<% int status = session.getAttribute("status") == null ? SC_OK : (int)session.getAttribute("status");
    if(status == SC_ACCEPTED) { %>
<p id="success"><strong>You have been signed out.</strong></p>
<% } %>

<% session.removeAttribute("status"); %>
<%@ include file="assets/include/footer.jsp" %>
