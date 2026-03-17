<%@ page import="com.johnnyconsole.chessclub.persistence.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.johnnyconsole.chessclub.persistence.interfaces.UserDao" %>
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

    <p>Viewing page <%= pageNumber %> of <%= pageCount %></p>
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
            <th>Arb/Org/Admin</th>
        </tr>

     <%   for(User user: users) { %>
           <tr>
               <td><%= user.getDisplayId() %></td>
               <td><% if(user.CFCID != null) { %> <a href="https://chess.ca/en/ratings/p/?id=<%= user.CFCID %>" target="_blank"> <%= user.CFCID %></a><% } else { %>"Not Registered" <% } %></td>
               <td><% if(user.FIDEID != null) { %> <a href="https://ratings.fide.com/profile/<%= user.FIDEID %>" target="_blank"><%= user.FIDEID %></a> <% } else { %> Not Registered <% } %> </td>
               <td><%= user.lastName%>, <%= user.firstName %></td>
               <td><%= user.rating %></td>
               <td><%= userDao.gamesPlayed(user) %></td>
               <td><%= user.effectiveDate.toLocalDate().format(DateTimeFormatter.ofPattern("dd MMMM yyyy")) %></td>
               <td><%= user.isArbiter ? "Arb" : "" %> <%= user.isOrganizer ? "Org" : "" %> <%= user.isAdministrator ? "Admin" : "" %></td>
           </tr>
    <% } %>
    </table>
<% } %>

<%@ include file="assets/include/footer.jsp" %>
