<%
    // Metadata strings for dynamic UI elements
    String pageName = "signin",
            pageTitle = "Sign In";
%>
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

<h3>Sign In</h3>
<form action="" method="post">
    <div class="form-field">
        <label for="username">Username</label>
        <input type="text" name="username" id="username" required/>
    </div>
    <div class="form-field">
        <label for="password">Password</label>
        <input type="password" name="password" id="password" required/>
    </div>
    <input type="submit" name="id-submit" id="signin-submit" value="Sign In"/>
</form>

<%@ include file="assets/include/footer.jsp" %>
