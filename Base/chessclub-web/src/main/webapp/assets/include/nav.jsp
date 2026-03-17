<nav>
  <a href="/chessclub/" <% if(pageName.equals("home")) { %> id="current" <% } %>>Home</a>
  <a href="/chessclub/players.jsp" <% if(pageName.equals("players")) { %> id="current" <% } %>>Player List</a>
  <a href="/chessclub/events.jsp" <% if(pageName.equals("events")) { %> id="current" <% } %>>Event Listing</a>
  <% if(signedInUser == null) { %>
        <a href="/chessclub/signin.jsp" <% if(pageName.equals("signin")) { %> id="current" <% } %>>Sign In</a>
 <% } else {
         if(signedInUser.isArbiter) { %> <% } %>
         if(signedInUser.isOrganizer) { %> <% } %>
         if(signedInUser.isAdministrator) { %> <% } %>
  <a href="/chessclub/SignOutServlet">Sign Out</a>
  <% } %>
</nav>