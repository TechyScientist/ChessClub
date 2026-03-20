package com.johnnyconsole.chessclub.persistence;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name="chessclub_games")
@NamedQueries({
        @NamedQuery(name="Game.FindById", query="SELECT g FROM Game g WHERE g.id = :id"),
        @NamedQuery(name="Game.FindAll", query="SELECT g FROM Game g"),
        @NamedQuery(name="Game.PlayedByUser.Chronological", query="SELECT g FROM Game g WHERE g.whitePlayer = :player OR g.blackPlayer = :player ORDER BY g.datePlayed"),
        @NamedQuery(name="Game.PlayedByUser.ReverseChronological", query="SELECT g FROM Game g WHERE g.whitePlayer = :player OR g.blackPlayer = :player ORDER BY g.datePlayed DESC"),
        @NamedQuery(name="Game.GamesForEvent", query="SELECT g FROM Game g WHERE g.eventID = :id"),
        @NamedQuery(name="Game.Count.All", query="SELECT COUNT(g) as count FROM Game g"),
        @NamedQuery(name="Game.Count.PlayedByUser", query="SELECT COUNT(g) as count FROM Game g WHERE g.whitePlayer = :player OR g.blackPlayer = :player"),
        @NamedQuery(name="Game.Count.FromEvent", query="SELECT COUNT(g) AS count FROM Game g WHERE g.eventID = :id")
})
public class Game {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    public int id;
    public int eventID, whitePlayer, whitePrevRating, whiteK, whiteNewRating,
            blackPlayer, blackPrevRating, blackK, blackNewRating;
    public double whiteE, blackE;
    public Timestamp datePlayed;
    public String result;

    public Game() {}

    public Game(int eventID, int whitePlayer, int whitePrevRating, int whiteK, double whiteE, int whiteNewRating,
                int blackPlayer, int blackPrevRating, int blackK, double blackE, int blackNewRating,
                String result, Timestamp datePlayed) {
        this.eventID = eventID;
        this.whitePlayer = whitePlayer;
        this.whitePrevRating = whitePrevRating;
        this.whiteK = whiteK;
        this.whiteE = whiteE;
        this.whiteNewRating = whiteNewRating;
        this.blackPlayer = blackPlayer;
        this.blackPrevRating = blackPrevRating;
        this.blackK = blackK;
        this.blackE = blackE;
        this.blackNewRating = blackNewRating;
        this.result = result;
        this.datePlayed = datePlayed;
    }

    //TODO: Remove this method -- used only for testing
    @Override
    public String toString() {
        return new StringBuilder()
                .append("Game {\n\tid: ").append(id)
                .append("\n\tdatePlayed: ").append(datePlayed.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd MMMM yyyy hh:mm:ss A")))
                .append("\n\tresult: ").append(result)
                .append("\n\twhitePlayer: ").append(whitePlayer)
                .append("\n\twhitePrevRating: ").append(whitePrevRating)
                .append("\n\twhiteK: ").append(whiteK)
                .append("\n\twhiteE: ").append(String.format("%.5f", whiteE))
                .append("\n\twhiteNewRating: ").append(whiteNewRating)
                .append("\n\tblackPlayer: ").append(blackPlayer)
                .append("\n\tblackPrevRating: ").append(blackPrevRating)
                .append("\n\tblackK: ").append(blackK)
                .append("\n\tblackE: ").append(String.format("%.5f", blackE))
                .append("\n\tblackNewRating: ").append(blackNewRating)
                .append("\n}").toString();
    }

}
