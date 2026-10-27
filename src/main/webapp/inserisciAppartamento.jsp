<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Nuovo appartamento</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Inserimento di un nuovo appartamento</h2>

                <form class="modulo" action="salvaAppartamento.jsp" method="post">
                    <label for="codProprietario">Proprietario (a scelta tra quelli esistenti)</label>
                    <select name="codProprietario" id="codProprietario" required>
                        <option value="">--- seleziona un proprietario ---</option>
                        <%
                            //elenco dei proprietari esistenti
                            ResultSet rs = funzioni.select("SELECT * FROM proprietari ORDER BY cognome, nome");
                            while (rs.next()) {
                        %>
                        <option value="<%= rs.getString("codProprietario") %>">
                            <%= rs.getString("cognome") + " " + rs.getString("nome") + " - citta: " + rs.getString("citta") %> (cod. <%= rs.getString("codProprietario") %>)
                        </option>
                        <%
                            }
                            funzioni.closeResultSet(rs);
                        %>
                    </select>

                    <label for="superficie">Superficie (mq)</label>
                    <input type="number" id="superficie" name="superficie" min="1" max="100000" required>

                    <label for="vani">Numero di vani</label>
                    <input type="number" id="vani" name="vani" min="1" max="50" required>

                    <label for="citta">Citta dove si trova l'appartamento</label>
                    <input type="text" id="citta" name="citta" maxlength="50" required>

                    <br>
                    <input type="submit" value="Inserisci appartamento">
                </form>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
