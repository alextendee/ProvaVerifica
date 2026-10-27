<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Elimina proprietario</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Eliminazione di un proprietario</h2>

                <p class="msg-errore">
                    Attenzione: verranno eliminati il proprietario scelto, tutti gli appartamenti che possiede
                    e gli affitti collegati a quegli appartamenti.
                </p>

                <form class="modulo" action="eliminaConferma.jsp" method="post">
                    <label for="codProprietario">Proprietario da eliminare</label>
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

                    <br>
                    <input type="submit" value="Prosegui con l'eliminazione">
                </form>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
