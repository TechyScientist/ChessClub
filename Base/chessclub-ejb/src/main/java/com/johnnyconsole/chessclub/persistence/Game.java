package com.johnnyconsole.chessclub.persistence;

import javax.persistence.*;
import java.sql.Date;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name="chessclub_games")
public class Game {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    public int id;
    public int eventID, whitePlayer, whitePrevRating, whiteK, whiteNewRating,
            blackPlayer, blackPrevRating, blackK, blackNewRating;
    public double whiteE, blackE;
    public Date datePlayed;
    public String result;

    public Game() {}

    public Game(int eventID, int whitePlayer, int whitePrevRating, int whiteK, double whiteE, int whiteNewRating,
                int blackPlayer, int blackPrevRating, int blackK, double blackE, int blackNewRating,
                String result, Date datePlayed) {
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
                .append("\n\tdatePlayed: ").append(datePlayed.toLocalDate().format(DateTimeFormatter.ofPattern("dd MMMM yyyy")))
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
