<nav>
  <a href="/chessclub/" <% if(pageName.equals("home")) { %> id="current" <% } %>>Home</a>
  <a href="/chessclub/players.jsp" <% if(pageName.equals("players")) { %> id="current" <% } %>>Player List</a>
  <a href="/chessclub/events.jsp" <% if(pageName.equals("events")) { %> id="current" <% } %>>Event Listing</a>
  <% if(signedInUser == null) { %>
        <a href="/chessclub/signin.jsp" <% if(pageName.equals("signin")) { %> id="current" <% } %>>Sign In</a>
 <% } else { %>
        <a href="/chessclub/dashboard.jsp" <% if(pageName.equals("dashboard")) { %> id="current" <% } %>>Dashboard</a>
      <% if(signedInUser.isArbiter) { %> <a href="/chessclub/arbiters.jsp" <% if(pageName.equals("arbiters")) { %> id="current" <% } %>>Arbiters' Menu</a> <% }
         if(signedInUser.isOrganizer) { %> <a href="/chessclub/organizers.jsp" <% if(pageName.equals("organizers")) { %> id="current" <% } %>>Organizers' Menu</a> <% }
         if(signedInUser.isAdministrator) { %> <a href="/chessclub/administrators.jsp" <% if(pageName.equals("administrators")) { %> id="current" <% } %>>Administrators' Menu</a> <% } %>
  <a href="/chessclub/SignOutServlet">Sign Out</a>
  <% } %>
</nav>