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

    input[type=text], select {
        width: 250px;
    }

    #three-columns {
        display: grid;
        width: fit-content;
        grid-template-columns: auto auto auto;
        gap: 10px;
    }
</style>

<% int responseCode = session.getAttribute("status") == null ? SC_OK : (int) session.getAttribute("status");
    if(responseCode == SC_BAD_REQUEST) { %>
         <p id="error"><strong>Error</strong>: That action must be done by the Enter Results form.</p>
<% }  else if(responseCode == SC_CONFLICT) { %>
        <p id="error"><strong>Error</strong>: Game Start Date is not within the event's play period or both players are the same.</p>
<% } else if(responseCode == SC_CREATED) { %>
        <p id="success"><strong>The results have been saved.</strong></p>
<% }
    if(request.getParameter("event") == null) {
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
    Event event = eventDao.getEvent(Integer.parseInt(request.getParameter("event")));
    List<User> players = userDao.all(); %>
    <p>Event: <%= event.name %> (ID: <%= event.id %>)</p>
    <form action="EnterResultsServlet" method="POST">
        <input type="hidden" name="event" value="<%= event.id %>">
        <div class="form-field">
            <label for="start">Start Date/Time</label>
            <input type="datetime-local" id="start" name="start" required/>
        </div>
        <div id="three-columns">
            <div class="form-field">
                <label for="white">White Player</label>
                <select id="white" name="white">
                    <% for(User user : players) { %>
                        <option value="<%= user.id %>"><%= user.lastName %>, <%= user.firstName %> (ID: <%= user.getDisplayId() %>)</option>
                    <% } %>
                </select>
            </div>
            <div class="form-field">
                <label for="result">Result</label>
                <select id="result" name="result">
                    <option>0-0</option>
                    <option>1-0</option>
                    <option>0.5-0.5</option>
                    <option>0-1</option>
                </select>
            </div>
            <div class="form-field">
                <label for="black">Black Player</label>
                <select id="black" name="black">
                    <% for(User user : players) { %>
                        <option value="<%= user.id %>"><%= user.lastName %>, <%= user.firstName %> (ID: <%= user.getDisplayId() %>)</option>
                    <% } %>
                </select>
            </div>
        </div>
        <input type="submit" name="enter-results-submit" value="Submit"/>
    </form>
<% }
    session.removeAttribute("status");%>
<%@ include file="assets/include/footer.jsp" %>
