<%@ page import="static javax.servlet.http.HttpServletResponse.*" %>
<%
    // Metadata strings for dynamic UI elements
    String pageName = "dashboard",
            pageTitle = "Dashboard";
%>
<%@ include file="assets/include/header.jsp" %>

<% if(signedInUser == null) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    response.sendRedirect("index.jsp");
}
else {
    int status = session.getAttribute("status") == null ? SC_OK : (int)session.getAttribute("status");
    if(status == SC_UNAUTHORIZED) { %>
        <p id="error"><strong>Error</strong>: You must have the role <strong><em><%= session.getAttribute("role") %></em></strong> to do that.</p>
    <% } %>

    <h3>Signed in as: <%= signedInUser.lastName %>, <%= signedInUser.firstName %></h3>

<% } %>
<%@ include file="assets/include/footer.jsp" %>
