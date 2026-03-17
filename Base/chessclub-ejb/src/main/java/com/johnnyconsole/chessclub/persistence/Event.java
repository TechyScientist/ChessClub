package com.johnnyconsole.chessclub.persistence;

import javax.persistence.*;
import java.sql.Date;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name="chessclub_events")
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
