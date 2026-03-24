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

    fieldset {
        display: inline-block;
        padding: 0 10px;
        margin: 0 0 10px 10px;
        vertical-align: top;
    }
    
    input[type=text], select {
        width: 250px;
    }

    .two-columns {
        display: grid;
        width: fit-content;
        grid-template-columns: auto auto;
        gap: 10px;
    }

    #three-columns {
        display: grid;
        width: fit-content;
        grid-template-columns: auto auto auto;
        gap: 10px;
    }

    #game-time {
        display: inline-block;
        vertical-align: middle;
    }
</style>

<h3>Add an Event</h3>
<% List<User> organizers = userDao.organizers(),
    arbiters = userDao.arbiters();
%>
<form action="" method="POST">
    <div class="form-field">
        <label for="name">Event Name</label>
        <input type="text" id="name" name="name" required/>
    </div>
    <div class="two-columns">
        <div class="form-field">
            <label for="start">Start Date</label>
            <input type="date" id="start" name="start" required/>
        </div>
        <div class="form-field">
            <label for="end">End Date</label>
            <input type="date" id="end" name="end" required/>
        </div>
    </div>
    <fieldset>
        <legend>Play Information</legend>
        <label>Game Time: </label>
        <div id="game-time">
            <div id="three-columns">
                <div class="form-field">
                    <label for="hours">Hours</label>
                    <input type="number" id="hours" name="hours" min="0" value="0" required/>
                </div>
                <div class="form-field">
                    <label for="minutes">Minutes</label>
                    <input type="number" id="minutes" name="minutes" min="0" value="0" required/>
                </div>
                <div class="form-field">
                    <label for="seconds">Seconds</label>
                    <input type="number" id="seconds" name="seconds" min="0" value="0" required/>
                </div>
            </div>
            <div class="two-columns">
                <div class="form-field">
                    <label for="increment">Increment</label>
                    <input type="number" id="increment" name="increment" min="0" value="0" required/>
                </div>
                <div class="form-field">
                    <label for="delay">Delay</label>
                    <input type="number" id="delay" name="delay" min="0" value="0" required/>
                </div>
            </div>
        </div>
        <div class="two-columns">
            <div class="form-field">
                <label for="pairing">Pairing System</label>
                <select id="pairing" name="pairing">
                    <option>Individual</option>
                    <option>Round-Robin</option>
                    <option>Swiss</option>
                </select>
            </div>
            <div class="form-field">
            <label for="elimination">Elimination Style</label>
            <select id="elimination" name="elimination">
                <option>None</option>
                <option>Single Elimination</option>
                <option>Double Elimination</option>
            </select>
            </div>
        </div>
    </fieldset>
    <fieldset>
        <legend>Event Officials</legend>
        <div class="form-field">
            <label for="chief-organizer">Chief Organizer</label>
            <select id="chief-organizer" name="chief-organizer">
                <% for(User organizer : organizers) { %>
                    <option value="<%= organizer.id %>"><%= organizer.getDisplayId() %>: <%= organizer.lastName %>, <%= organizer.firstName %></option>
                <% } %>
            </select>
        </div>
        <div class="form-field">
            <label for="chief-arbiter">Chief Arbiter</label>
            <select id="chief-arbiter" name="chief-arbiter">
                <% for(User arbiter : arbiters) { %>
                    <option value="<%= arbiter.id %>"><%= arbiter.getDisplayId() %>: <%= arbiter.lastName %>, <%= arbiter.firstName %></option>
                <% } %>
            </select>
        </div>
    </fieldset>
    <input type="submit" name="add-event-submit" value="Submit"/>
</form>

<%@ include file="assets/include/footer.jsp" %>
