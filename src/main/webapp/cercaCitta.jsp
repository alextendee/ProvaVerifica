<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Ricerca per citta</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Ricerca degli appartamenti per citta</h2>

                <p>Selezionare una citta: verra' visualizzato l'elenco di tutti gli appartamenti che si trovano in quella citta.</p>

                <form class="modulo" action="risultatoCitta.jsp" method="post">
                    <label for="citta">Citta</label>
                    <select name="citta" id="citta" required>
                        <option value="">--- seleziona una citta ---</option>
                        <%
                            //elenco delle citta in cui si trovano gli appartamenti
                            ResultSet rs = funzioni.select("SELECT DISTINCT citta FROM appartamenti ORDER BY citta");
                            while (rs.next()) {
                        %>
                        <option value="<%= rs.getString("citta") %>"><%= rs.getString("citta") %></option>
                        <%
                            }
                            funzioni.closeResultSet(rs);
                        %>
                    </select>

                    <br>
                    <input type="submit" value="Cerca appartamenti">
                </form>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
