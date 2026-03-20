package com.johnnyconsole.chessclub.persistence.implementations;

import com.johnnyconsole.chessclub.persistence.Event;
import com.johnnyconsole.chessclub.persistence.Game;
import com.johnnyconsole.chessclub.persistence.User;
import com.johnnyconsole.chessclub.persistence.interfaces.GameDao;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class GameDaoImpl implements GameDao {

    @PersistenceContext(unitName="game")
    private EntityManager manager;


    @Override
    public Game getGame(long id) {
        try {
            return (Game) manager.createNamedQuery("Game.FindById")
                    .setParameter("id", id)
                    .getSingleResult();
        } catch(Exception e) {
            return null;
        }
    }

    @Override
    public long count() {
        try {
            return (long) manager.createNamedQuery("Game.Count.All")
                    .getSingleResult();
        } catch(Exception e) {
            return 0;
        }
    }

    @Override
    public boolean addGame(Game game) {
        try {
            manager.persist(game);
            return true;
        } catch(Exception e) {
            return false;
        }
    }

    @Override
    public boolean updateGame(Game game) {
        try {
            manager.merge(game);
            return true;
        } catch(Exception e) {
            return false;
        }
    }

    @Override
    public boolean deleteGame(Game game) {
        try {
            manager.remove((manager.contains(game) ? game : manager.merge(game)));
            return true;
        }
        catch(Exception e) {
            return false;
        }
    }

    @Override
    public List<Game> all() {
        try {
            return (List<Game>) manager.createNamedQuery("Game.FindAll").getResultList();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Game> gamesFor(User user) {
        try {
            return (List<Game>) manager.createNamedQuery("Game.PlayedByUser.Chronological")
                    .setParameter("player", user.id)
                    .getResultList();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Game latestGameFor(User user) {
        try {
            return (Game) manager.createNamedQuery("Game.PlayedByUser.ReverseChronological")
                    .setParameter("player", user.id)
                    .getResultList().get(0);
        }  catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Game> gamesFor(Event event) {
        try {
            return (List<Game>) manager.createNamedQuery("Game.GamesForEvent")
                    .setParameter("id", event.id)
                    .getResultList();
        } catch (Exception e) {
            return null;
        }
    }
}
