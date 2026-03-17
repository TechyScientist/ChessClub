package com.johnnyconsole.chessclub.persistence;

import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.*;
import java.sql.Date;
import java.time.LocalDate;

@Entity
@Table(name="chessclub_users")
@NamedQueries({
        @NamedQuery(name="User.FindById", query="SELECT u FROM User u WHERE u.id = :id"),
        @NamedQuery(name="User.FindAll", query="SELECT u FROM User u"),
        @NamedQuery(name="User.FindByUsername", query="SELECT u FROM User u WHERE u.username = :username"),
        @NamedQuery(name="User.FindAllExcept", query="SELECT u FROM User u WHERE u.id <> :id"),
        @NamedQuery(name="User.Count", query="SELECT COUNT(u) AS count FROM User u")
})
public class User {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    public int id;
    public String lastName, firstName, username, CFCID, FIDEID, chesscomUsername;
    @JsonbTransient private String password;
    public int rating;
    public Date effectiveDate;
    public boolean isArbiter, isOrganizer, isAdministrator;

    public User() {}

    public User(String lastName, String firstName, String username,
                String password, String CFCID, String FIDEID, String chesscomUsername,
                int rating, Date effectiveDate,
                boolean isArbiter, boolean isOrganizer, boolean isAdministrator) {
        this.lastName = lastName;
        this.firstName = firstName;
        this.username = username;
        this.password = password;
        this.CFCID = CFCID;
        this.FIDEID = FIDEID;
        this.chesscomUsername = chesscomUsername;
        this.rating = rating;
        this.effectiveDate = effectiveDate;
        this.isArbiter = isArbiter;
        this.isOrganizer = isOrganizer;
        this.isAdministrator = isAdministrator;
    }

    public User(String lastName, String firstName, String username, String password) {
        this(lastName, firstName, username, password, null, null, null,
                1200, Date.valueOf(LocalDate.now()), false,
                false, false);
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

    //TODO: Remove this method -- used only for testing
    @Override
    public String toString() {
        return new StringBuilder()
                .append("User {\n\tid: ").append(getDisplayId())
                .append("\n\tlastName: ").append(lastName)
                .append("\n\tfirstName: ").append(firstName)
                .append("\n\tusername: ").append(username)
                .append("\n\tCFCID: ").append(CFCID)
                .append("\n\tFIDEID: ").append(FIDEID)
                .append("\n\tchesscomUsername: ").append(chesscomUsername)
                .append("\n\trating: ").append(rating)
                .append("\n\teffectiveDate: ").append(effectiveDate)
                .append("\n\tisArbiter: ").append(isArbiter ? "Yes": "No")
                .append("\n\tisOrganizer: ").append(isOrganizer ? "Yes": "No")
                .append("\n\tisAdministrator: ").append(isAdministrator ? "Yes": "No")
                .append("\n}").toString();
    }

}
