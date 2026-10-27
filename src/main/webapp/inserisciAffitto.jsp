<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Nuovo affitto</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Inserimento di un nuovo affitto</h2>

                <form class="modulo" action="salvaAffitto.jsp" method="post">
                    <label for="codAppartamento">Appartamento (a scelta tra quelli esistenti)</label>
                    <select name="codAppartamento" id="codAppartamento" required>
                        <option value="">--- seleziona un appartamento ---</option>
                        <%
                            //elenco degli appartamenti esistenti, con la citta per facilitarne il riconoscimento
                            ResultSet rs = funzioni.select("SELECT * FROM appartamenti ORDER BY codAppartamento");
                            while (rs.next()) {
                        %>
                        <option value="<%= rs.getInt("codAppartamento") %>">
                            Appartamento n. <%= rs.getInt("codAppartamento") %> - <%= rs.getString("citta") %> (<%= rs.getInt("superficie") %> mq, <%= rs.getInt("vani") %> vani)
                        </option>
                        <%
                            }
                            funzioni.closeResultSet(rs);
                        %>
                    </select>

                    <label for="data">Data dell'affitto</label>
                    <input type="date" id="data" name="data" required>

                    <label for="importo">Importo (euro)</label>
                    <input type="number" id="importo" name="importo" min="1" max="1000000" required>

                    <br>
                    <input type="submit" value="Inserisci affitto">
                </form>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
