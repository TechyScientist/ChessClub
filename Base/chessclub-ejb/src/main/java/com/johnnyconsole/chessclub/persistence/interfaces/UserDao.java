package com.johnnyconsole.chessclub.persistence.interfaces;

import com.johnnyconsole.chessclub.persistence.User;

import javax.ejb.Local;
import java.util.List;

@Local
public interface UserDao {
    User getUser(int id);
    User getUser(String username);
    boolean usernameExists(String username);
    long count();
    long gamesPlayed(User user);
    List<User> getUsersExcept(int id);
    List<User> getUsers(int limit, int page);
    boolean addUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(User user, String myUsername);
    boolean verifyUserPassword(User user, String password);
}
