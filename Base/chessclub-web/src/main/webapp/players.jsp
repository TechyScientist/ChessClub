<%@ page import="com.johnnyconsole.chessclub.persistence.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.johnnyconsole.chessclub.persistence.interfaces.UserDao" %>
<%@ page import="com.johnnyconsole.chessclub.persistence.Game" %>
<%
    // Metadata strings for dynamic UI elements
    String pageName = "players",
            pageTitle = "Players";
%>
<%@ include file="assets/include/header.jsp" %>

<style>
    table {
        border-collapse: collapse;
    }

    td, th {
        padding: 10px;
        border: 1px solid black;
        text-align: center;
    }

    input[type=number] {
        background: var(--color-background);
        border: none;
    }

    input[type=number]:focus {
        border: none;
    }

    input[type=number]::-webkit-inner-spin-button,
    input[type=number]::-webkit-outer-spin-button {
        opacity: 1;
        color: var(--color-primary);
    }
</style>
<% UserDao userDao = (UserDao) session.getAttribute("UserDao");
    if(userDao == null) response.sendRedirect("/chessclub/GetUserDaoServlet");
    else {
        int pageNumber;
        try {
            pageNumber = Integer.parseInt(request.getParameter("page"));
        } catch(Exception e) {
            pageNumber = 1;
        }

        int userCount = (int) userDao.count();
        int pageCount = userCount % 10 == 0 ? userCount / 10 : (userCount / 10) + 1;
        if(pageNumber < 1 || pageNumber > pageCount) pageNumber = 1;
        List<User> users = userDao.getUsers(10, pageNumber); %>


    <!-- TODO: Create custom up/down controls, create GO control, implement action -->
    <!-- <p>Go To page <input type="number" min="1" max="<%= pageCount %>" name="page" id="page" value="<%= pageNumber %>"/> <button>Go</button> </p> -->
    <p><% if(pageNumber != 1) { %> <a href="?page=<%= pageNumber - 1%>"><-- Previous Page</a> <% } if(pageNumber != pageCount) { %><a href="?page=<%= pageNumber + 1%>"> Next Page --></a> <% } %></p>
    <table>
        <tr>
            <th>AUCC ID</th>
            <th>CFC ID</th>
            <th>FIDE ID</th>
            <th>Name</th>
            <th>Rating</th>
            <th>Games Played</th>
            <th>Effective Date</th>
            <th>Arbiter</th>
            <th>Organizer</th>
            <th>Administrator</th>
        </tr>

     <%   for(User user: users) {
            List<Game> games = userDao.getGames(user);
            Game latestGame = userDao.getLatestGame(user); %>
           <tr>
               <td><%= user.getDisplayId() %></td>
               <td><% if(user.CFCID != null) { %> <a href="https://chess.ca/en/ratings/p/?id=<%= user.CFCID %>" target="_blank"> <%= user.CFCID %></a><% } else { %>"Not Registered" <% } %></td>
               <td><% if(user.FIDEID != null) { %> <a href="https://ratings.fide.com/profile/<%= user.FIDEID %>" target="_blank"><%= user.FIDEID %></a> <% } else { %> Not Registered <% } %> </td>
               <td><%= user.lastName%>, <%= user.firstName %></td>
               <td><%= latestGame == null ? 1200 : latestGame.whitePlayer == user.id ? latestGame.whiteNewRating : latestGame.blackNewRating %></td>
               <td><%= games == null ? 0 : games.size() %></td>
               <td><%= user.effectiveDate.toLocalDate().format(DateTimeFormatter.ofPattern("dd MMMM yyyy")) %></td>
               <td><img src="assets/img/<% if(user.isArbiter) { %>check<% } else { %>x<% } %>.png" alt="<% if(user.isArbiter) { %>User is an Arbiter<% } else { %>User is NOT an Arbiter<% } %>"/></td>
               <td><img src="assets/img/<% if(user.isOrganizer) { %>check<% } else { %>x<% } %>.png" alt="<% if(user.isOrganizer) { %>User is an Organizer<% } else { %>User is NOT an Organizer<% } %>"/></td>
               <td><img src="assets/img/<% if(user.isAdministrator) { %>check<% } else { %>x<% } %>.png" alt="<% if(user.isAdministrator) { %>User is an Administrator<% } else { %>User is NOT an Administrator<% } %>"/></td>
           </tr>
    <% } %>
    </table>
    <br/><p>Viewing page <%= pageNumber %> of <%= pageCount %></p>
<% } %>

<%@ include file="assets/include/footer.jsp" %>
