package com.johnnyconsole.chessclub.persistence.interfaces;

import com.johnnyconsole.chessclub.persistence.Event;
import com.johnnyconsole.chessclub.persistence.Game;
import com.johnnyconsole.chessclub.persistence.User;

import javax.ejb.Local;
import java.util.List;

@Local
public interface GameDao {
    Game getGame(long id);
    long count();
    boolean addGame(Game game);
    boolean updateGame(Game game);
    boolean deleteGame(Game game);
    List<Game> all();
    List<Game> gamesFor(User user);
    Game latestGameFor(User user);
    List<Game> gamesFor(Event event);
}
