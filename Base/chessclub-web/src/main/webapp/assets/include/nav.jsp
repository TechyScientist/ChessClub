<nav>
  <a href="/chessclub/" <% if(pageName.equals("home")) { %> id="current" <% } %>>Home</a>
  <a href="/chessclub/players.jsp" <% if(pageName.equals("players")) { %> id="current" <% } %>>Player List</a>
  <a href="/chessclub/events.jsp" <% if(pageName.equals("events")) { %> id="current" <% } %>>Event Listing</a>
  <a href="/chessclub/signin.jsp" <% if(pageName.equals("signin")) { %> id="current" <% } %>>Sign In</a>
</nav>