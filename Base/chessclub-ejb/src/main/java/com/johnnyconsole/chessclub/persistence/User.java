package com.johnnyconsole.chessclub.persistence;

import jdk.jfr.Name;

import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.*;
import java.sql.Date;
import java.time.LocalDate;

@Entity
@Table(name="chessclub_users")
@NamedQueries({
        @NamedQuery(name="User.FindById", query="SELECT u FROM User u WHERE u.id = :id"),
        @NamedQuery(name="User.FindByUsername", query="SELECT u FROM User u WHERE u.username = :username"),
        @NamedQuery(name="User.FindAllExcept", query="SELECT u FROM User u WHERE u.id <> :id"),
        @NamedQuery(name="User.Count", query="SELECT COUNT(u) AS count FROM User u")
})
public class User {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    public int id;
    public String lastName, firstName, username;
    @JsonbTransient private String password;
    public int rating, gamesPlayed;
    public Date effectiveDate;
    public boolean isArbiter, isOrganizer, isAdministrator;

    public User(String lastName, String firstName, String username,
                String password, int rating, int gamesPlayed, Date effectiveDate,
                boolean isArbiter, boolean isOrganizer, boolean isAdministrator) {
        this.lastName = lastName;
        this.firstName = firstName;
        this.username = username;
        this.password = password;
        this.rating = rating;
        this.gamesPlayed = gamesPlayed;
        this.effectiveDate = effectiveDate;
        this.isArbiter = isArbiter;
        this.isOrganizer = isOrganizer;
        this.isAdministrator = isAdministrator;
    }

    public User(String lastName, String firstName, String username, String password) {
        this(lastName, firstName, username, password, 1200, 0,
                Date.valueOf(LocalDate.now()), false, false, false);
    }

    public String getDisplayId() {
        return String.format("AUCC-%04d", id);
    }

    @JsonbTransient
    public String getPassword() {
        return password;
    }

    @JsonbTransient
    public void setPassword(String password) {
        this.password = password;
    }

}
