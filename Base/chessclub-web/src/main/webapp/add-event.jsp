<%@ page import="static javax.servlet.http.HttpServletResponse.*" %>
<%@ page import="java.util.List" %>
<%
    // Metadata strings for dynamic UI elements
    String pageName = "organizers",
            pageTitle = "Add an Event";
%>
<%@ include file="assets/include/header.jsp" %>

<% if(signedInUser == null) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    response.sendRedirect("index.jsp");
} else if(!signedInUser.isOrganizer) {
    session.setAttribute("status", SC_UNAUTHORIZED);
    session.setAttribute("role", "Organizer");
    response.sendRedirect("dashboard.jsp");
} %>

<h3>Add an Event</h3>
<% List<User> organizers = userDao.organizers(),
    arbiters = userDao.arbiters();
%>
<form action="" method="POST">
    <label for="name">Event Name</label>
    <input type="text" id="name" name="name"/><br/><br/>
    <fieldset>
        <legend>Play Information</legend>
        <label for="time">Game Time (Minutes)</label>
        <input type="number" id="time" name="time"/><br/><br/>
        <label for="increment">Increment (Seconds per Move)</label>
        <input type="number" id="increment" name="increment" value="0"/><br/><br/>
        <label for="delay">Delay (Seconds per Move)</label>
        <input type="number" id="delay" name="delay" value="0"/><br/><br/>
        <label for="pairing">Pairing System</label>
        <select id="pairing" name="pairing">
            <option>Round-Robin</option>
            <option>Swiss</option>
        </select><br/><br/>
        <label for="elimination">Elimination Style</label>
        <select id="elimination" name="elimination">
            <option>None</option>
            <option>Single Elimination</option>
            <option>Double Elimination</option>
        </select><br/><br/>
    </fieldset>
    <fieldset>
        <legend>Event Officials</legend>
        <label for="chief-organizer">Chief Organizer</label>
        <select id="chief-organizer" name="chief-organizer">
            <% for(User organizer : organizers) { %>
                <option value="<%= organizer.id %>"><%= organizer.getDisplayId() %><%= organizer.lastName %>, <%= organizer.firstName %></option>
            <% } %>
        </select><br/><br/>
        <legend>Event Officials</legend>
        <label for="chief-arbiter">Chief Arbiter</label>
        <select id="chief-arbiter" name="chief-arbiter">
            <% for(User arbiter : arbiters) { %>
                <option value="<%= arbiter.id %>"><%= arbiter.getDisplayId() %><%= arbiter.lastName %>, <%= arbiter.firstName %></option>
            <% } %>
        </select><br/><br/>
    </fieldset>
    <label for="start">Start Date</label>
    <input type="date" id="start" name="start"/><br/><br/>
    <label for="end">End Date</label>
    <input type="date" id="end" name="end"/><br/><br/>
    <input type="submit" name="add-event-submit" value="Submit"/>
</form>

<%@ include file="assets/include/footer.jsp" %>
