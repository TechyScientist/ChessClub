package com.johnnyconsole.chessclub.persistence;

import javax.persistence.*;
import java.sql.Date;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name="chessclub_events")
@NamedQueries({
        @NamedQuery(name="Event.FindById", query="SELECT e FROM Event e WHERE e.id = :id"),
        @NamedQuery(name="Event.FindAll", query="SELECT e FROM Event e"),@NamedQuery(name="Event.FindAll.Current", query="SELECT e FROM Event e WHERE e.startDate <= CURRENT_DATE AND e.endDate >= CURRENT_DATE ORDER BY e.startDate"),
        @NamedQuery(name="Event.FindAll.Future", query="SELECT e FROM Event e WHERE e.startDate > CURRENT_DATE ORDER BY e.startDate"),
        @NamedQuery(name="Event.FindAll.Past", query="SELECT e FROM Event e WHERE e.endDate < CURRENT_DATE ORDER BY e.endDate DESC"),
        @NamedQuery(name="Event.Count", query="SELECT COUNT(e) AS count FROM Event e")
})
public class Event {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    public int id;
    public String name, formatString, playSystem;
    public Integer chiefOrganizer, chiefArbiter;
    public Date startDate, endDate;


    public Event() {}

    public Event(String name, String formatString, String playSystem,
                 Integer chiefOrganizer, Integer chiefArbiter, Date startDate, Date endDate) {
        this.name = name;
        this.formatString = formatString;
        this.playSystem = playSystem;
        this.chiefOrganizer = chiefOrganizer;
        this.chiefArbiter = chiefArbiter;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Event(String name, String formatString, String playSystem, Date startDate, Date endDate) {
        this(name, formatString, playSystem, null, null,  startDate, endDate);
    }

    //TODO: Remove this method -- used only for testing
    @Override
    public String toString() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM yyyy");
        return new StringBuilder()
                .append("Event {\n\tid: ").append(id)
                .append("\n\tname: ").append(name)
                .append("\n\tformat: ").append(formatString)
                .append("\n\tsystem: ").append(playSystem)
                .append("\n\tchiefOrganizer: ").append(chiefOrganizer == null ? "--" : chiefOrganizer.toString())
                .append("\n\tchiefArbiter: ").append(chiefArbiter ==  null ? "--" : chiefArbiter.toString())
                .append("\n\tstart: ").append(startDate.toLocalDate().format(formatter))
                .append("\n\tend: ").append(endDate.toLocalDate().format(formatter))
                .append("\n}").toString();
    }

}
