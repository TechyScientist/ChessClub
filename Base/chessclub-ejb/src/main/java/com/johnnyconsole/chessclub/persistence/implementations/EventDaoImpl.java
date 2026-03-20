package com.johnnyconsole.chessclub.persistence.implementations;

import com.johnnyconsole.chessclub.persistence.Event;
import com.johnnyconsole.chessclub.persistence.interfaces.EventDao;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class EventDaoImpl implements EventDao {

    @PersistenceContext(unitName="event")
    private EntityManager manager;


    @Override
    public Event getEvent(long id) {
        try {
            return (Event) manager.createNamedQuery("Event.FindById")
                    .setParameter("id", id)
                    .getSingleResult();
        } catch(Exception e) {
            return null;
        }
    }

    @Override
    public long count() {
        try {
            return (long) manager.createNamedQuery("Event.Count")
                    .getSingleResult();
        } catch(Exception e) {
            return 0;
        }
    }

    @Override
    public boolean addEvent(Event event) {
        try {
            manager.persist(event);
            return true;
        } catch(Exception e) {
            return false;
        }
    }

    @Override
    public boolean updateEvent(Event event) {
        try {
            manager.merge(event);
            return true;
        } catch(Exception e) {
            return false;
        }
    }

    @Override
    public boolean deleteEvent(Event event) {
        try {
            manager.remove((manager.contains(event) ? event : manager.merge(event)));
            return true;
        }
        catch(Exception e) {
            return false;
        }
    }

    @Override
    public List<Event> all() {
        try {
            return (List<Event>) manager.createNamedQuery("Event.FindAll").getResultList();
        } catch (Exception e) {
            return null;
        }
    }
}
