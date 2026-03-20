package com.johnnyconsole.chessclub.persistence.interfaces;

import com.johnnyconsole.chessclub.persistence.Event;

import javax.ejb.Local;
import java.util.List;

@Local
public interface EventDao {
    Event getEvent(long id);
    long count();
    boolean addEvent(Event event);
    boolean deleteEvent(Event event);
    boolean updateEvent(Event event);
    List<Event> all();
}
