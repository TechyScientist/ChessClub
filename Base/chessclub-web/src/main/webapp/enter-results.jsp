<%@ page import="static javax.servlet.http.HttpServletResponse.*" %>
<%@ page import="com.johnnyconsole.chessclub.persistence.Event" %>
<%@ page import="java.util.List" %>
<%
    // Metadata strings for dynamic UI elements
    String pageName = "arbiters",
            pageTitle = "Enter Results";
%>
<%@ include file="assets/include/header.jsp" %>

<% if(signedInUser == null) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    response.sendRedirect("index.jsp");
} else if(!signedInUser.isArbiter) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    session.setAttribute("role", "Arbiter");
    response.sendRedirect("dashboard.jsp");
} %>

<% if(request.getParameter("event") == null) {
    List<Event> events = eventDao.all();
    if(events == null || events.isEmpty()) { %>
        <p id="error"><strong>Error</strong>: No Events Found</p>
<% }
    else { %>
<h3>Select Event</h3>
<form action="" method="GET">
    <label for="event">Event: </label>
    <select id="event" name="event">
        <% for(Event e : events) { %>
            <option value="<%= e.id %>"><%= e.name %> (ID: <%= e.id %>, Start: <%= e.startDate %>, End: <%= e.endDate %>)</option>
        <% } %>
    </select><br/><br/>
    <input type="submit" value="Select Event">
</form>
<%    }
} else {
    Event event = eventDao.getEvent(Long.parseLong(request.getParameter("event"))); %>
    <p>Event: <%= event.toString() %></p>
<% } %>
<%@ include file="assets/include/footer.jsp" %>
