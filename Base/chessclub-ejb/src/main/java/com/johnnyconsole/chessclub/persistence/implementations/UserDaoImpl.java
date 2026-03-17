package com.johnnyconsole.chessclub.persistence.implementations;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.johnnyconsole.chessclub.persistence.Game;
import com.johnnyconsole.chessclub.persistence.User;
import com.johnnyconsole.chessclub.persistence.interfaces.UserDao;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class UserDaoImpl implements UserDao {

    @PersistenceContext(unitName="user")
    private EntityManager manager;

    @Override
    public User getUser(int id) {
        try {
            return (User) (manager.createNamedQuery("User.FindById")
                    .setParameter("id", id)
                    .getSingleResult());
        } catch(Exception e) {
            return null;
        }
    }

    @Override
    public User getUser(String username) {
        try {
            return (User) (manager.createNamedQuery("User.FindByUsername")
                    .setParameter("username", username)
                    .getSingleResult());
        } catch(Exception e) {
            return null;
        }
    }

    @Override
    public boolean usernameExists(String username) {
        return getUser(username) != null;
    }

    @Override
    public long count() {
        try {
            return (long) (manager.createNamedQuery("User.Count").getSingleResult());
        } catch(Exception e) {
            return 0;
        }
    }

    @Override
    public long gamesPlayed(User user) {
        try {
            return (long) (manager.createNamedQuery("User.GamesPlayed")
                    .setParameter("id", user.id)
                    .getSingleResult());
        } catch(Exception e) {
            return 0;
        }
    }

    @Override
    public List<User> getUsersExcept(int id) {
        try {
            return (List<User>)(manager.createNamedQuery("User.FindAllExcept")
                    .setParameter("id", id)
                    .getResultList());
        } catch(Exception e) {
            return null;
        }
    }

    @Override
    public List<User> getUsers(int limit, int page) {
        try {
            return (List<User>) (manager.createNamedQuery("User.FindAll")
                    .setMaxResults(limit)
                    .setFirstResult((page - 1) * limit)
                    .getResultList());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean addUser(User user) {
        try {
            manager.persist(user);
            return true;
        } catch(Exception e) {
            return false;
        }
    }

    @Override
    public boolean updateUser(User user) {
        try {
            manager.merge(user);
            return true;
        } catch(Exception e) {
            return false;
        }
    }

    @Override
    public boolean deleteUser(User user, String myUsername) {
        try {
            if(user.username.equals(myUsername)) {
                return false;
            }
            manager.remove((manager.contains(user) ? user : manager.merge(user)));
            return true;
        }
        catch(Exception e) {
            return false;
        }
    }

    @Override
    public boolean verifyUserPassword(User user, String password) {
        try {
            return BCrypt.verifyer()
                    .verify(password.getBytes(), user.getPassword().getBytes())
                    .verified;
        } catch(Exception e) {
            return false;
        }
    }

    @Override
    public List<Game> getGames(User user) {
        try {
            return  (List<Game>) (manager.createNamedQuery("User.FindGames")
                    .setParameter("id", user.id)
                    .getResultList());
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Game getLatestGame(User user) {
        try {
            return (Game) (manager.createNamedQuery("User.FindGames")
                    .setParameter("id", user.id)
                    .getResultList().get(0));
        }
        catch(Exception e) {
            return null;
        }
    }

}
