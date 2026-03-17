<%
    // Metadata strings for dynamic UI elements
    String pageName = "signin",
            pageTitle = "Sign In";
%>
<%@ page import="static javax.servlet.http.HttpServletResponse.SC_OK" %>
<%@ page import="static javax.servlet.http.HttpServletResponse.SC_BAD_REQUEST" %>
<%@ page import="static javax.servlet.http.HttpServletResponse.SC_NOT_ACCEPTABLE" %>
<%@ page import="static javax.servlet.http.HttpServletResponse.SC_UNAUTHORIZED" %>
<%@ page import="static javax.servlet.http.HttpServletResponse.SC_NOT_FOUND" %>
<%@ page import="static javax.servlet.http.HttpServletResponse.SC_ACCEPTED" %>

<%@ include file="assets/include/header.jsp" %>

<style>
    .form-field {
        position: relative;
        margin: 20px 0;
    }

    .form-field label {
        position: absolute;
        top: -12px;
        left: 10px;
        padding: 0 5px;
        background: var(--color-background);
    }
</style>

<% int status = session.getAttribute("status") == null ? SC_OK : (int)session.getAttribute("status");
if(status == SC_ACCEPTED) { %>
    <p id="success"><strong>You have been signed out.</strong></p>
<% }
else if(status != SC_OK) { %>
    <p id="error"><strong>Error</strong>:
        <% switch(status) {
                case SC_BAD_REQUEST: %>
                    That action must be done by the sign in form.
        <%          break;
                case SC_NOT_ACCEPTABLE: %>
                    Missing or empty parameter.
        <%          break;
                case SC_NOT_FOUND:
                case SC_UNAUTHORIZED: %>
                    Invalid credentials, please try again.
        <%          break;
           } %>
    </p>
<% } %>
<h3>Sign In</h3>
<form action="SignInServlet" method="post">
    <div class="form-field">
        <label for="username">Username</label>
        <input type="text" name="username" required/>
    </div>
    <div class="form-field">
        <label for="password">Password</label>
        <input type="password" name="password" required/>
    </div>
    <input type="submit" name="signin-submit" value="Sign In"/>
</form>

<% session.removeAttribute("status"); %>
<%@ include file="assets/include/footer.jsp" %>
