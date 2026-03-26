package com.johnnyconsole.chessclub.servlet;

import com.johnnyconsole.chessclub.persistence.Event;
import com.johnnyconsole.chessclub.persistence.Game;
import com.johnnyconsole.chessclub.persistence.User;
import com.johnnyconsole.chessclub.persistence.interfaces.EventDao;
import com.johnnyconsole.chessclub.persistence.interfaces.GameDao;
import com.johnnyconsole.chessclub.persistence.interfaces.UserDao;

import javax.ejb.EJB;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import static javax.servlet.http.HttpServletResponse.*;

@WebServlet("/EnterResultsServlet")
public class EnterResultsServlet extends HttpServlet {

    @EJB
    private UserDao userDao;

    @EJB
    private GameDao gameDao;

    @EJB
    private EventDao eventDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("SignedInUser") == null) {
            session.setAttribute("status", SC_UNAUTHORIZED);
            response.sendRedirect("/chessclub/index.jsp");
        } else if (!((User) session.getAttribute("SignedInUser")).isArbiter) {
            session.setAttribute("status", SC_UNAUTHORIZED);
            session.setAttribute("role", "Arbiter");
            response.sendRedirect("/chessclub/dashboard.jsp");
        } else if (request.getParameter("enter-results-submit") == null) {
            session.setAttribute("status", SC_BAD_REQUEST);
            response.sendRedirect("/chessclub/enter-results.jsp");
        } else {
            int event = Integer.parseInt(request.getParameter("event")),
                    whiteId = Integer.parseInt(request.getParameter("white")),
                    blackId = Integer.parseInt(request.getParameter("black")),
                    whiteC, blackC, whiteK, blackK, whitePrev, blackPrev, whiteNew, blackNew;
            String result = request.getParameter("result");
            Timestamp start = Timestamp.valueOf(LocalDateTime.parse(request.getParameter("start")));
            double whiteScore = Double.parseDouble(result.substring(0, result.indexOf('-'))),
                    blackScore = Double.parseDouble(result.substring(result.indexOf('-') + 1)),
                    whiteE, blackE;

            Event e = eventDao.getEvent(event);
            if((whiteId == blackId) || start.before(e.startDate) || start.after(e.endDate)) {
                session.setAttribute("status", SC_CONFLICT);
                response.sendRedirect("/chessclub/enter-results.jsp?event=" + event);
            }
            else {
                User white = userDao.getUser(whiteId),
                        black = userDao.getUser(blackId);
                List<Game> whiteGames = gameDao.gamesFor(white),
                        blackGames = gameDao.gamesFor(black);
                whiteC = whiteGames == null ? 0 : whiteGames.size();
                blackC = blackGames == null ? 0 : blackGames.size();

                whiteK = whiteC <= 20 ? 40 : 20;
                blackK = blackC <= 20 ? 40 : 20;
                Game latestWhite = gameDao.latestGameFor(white),
                        latestBlack = gameDao.latestGameFor(black);
                System.out.println(latestWhite);
                System.out.println(latestBlack);
                whitePrev = latestWhite == null ? 1200 :
                        latestWhite.whitePlayer == white.id ? latestWhite.whiteNewRating : latestWhite.blackNewRating;
                blackPrev = latestBlack == null ? 1200 :
                        latestBlack.whitePlayer == black.id ? latestBlack.whiteNewRating : latestBlack.blackNewRating;
                whiteE = 1 / (1 + Math.pow(10, (blackPrev - whitePrev) / 400.0));
                blackE = 1 / (1 + Math.pow(10, (whitePrev - blackPrev) / 400.0));

                whiteNew = (int) Math.round(whitePrev + (whiteK * (whiteScore - whiteE)));
                blackNew = (int) Math.round(blackPrev + (blackK * (blackScore - blackE)));

                if (whiteScore == 0 && blackScore == 0) {
                    whiteNew = whitePrev;
                    blackNew = blackPrev;
                }
                if (whiteNew < 100) whiteNew = 100;
                if (blackNew < 100) blackNew = 100;

                gameDao.addGame(
                        new Game(event, whiteId, whitePrev, whiteNew,
                                blackId, blackPrev, blackNew,
                                result, start
                        ));

                session.setAttribute("status", SC_CREATED);
                response.sendRedirect("/chessclub/enter-results.jsp");
            }
        }
    }
}
