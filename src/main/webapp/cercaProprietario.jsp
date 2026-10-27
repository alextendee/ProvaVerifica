<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Appartamenti di un proprietario</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Ricerca degli appartamenti di un proprietario</h2>

                <p>Selezionare un proprietario tra quelli esistenti: verra' visualizzato l'elenco di tutti gli appartamenti che possiede.</p>

                <form class="modulo" action="risultatoProprietario.jsp" method="post">
                    <label for="codProprietario">Proprietario</label>
                    <select name="codProprietario" id="codProprietario" required>
                        <option value="">--- seleziona un proprietario ---</option>
                        <%
                            //elenco dei proprietari esistenti
                            ResultSet rs = funzioni.select("SELECT * FROM proprietari ORDER BY cognome, nome");
                            while (rs.next()) {
                        %>
                        <option value="<%= rs.getString("codProprietario") %>">
                            <%= rs.getString("cognome") + " " + rs.getString("nome") %> (cod. <%= rs.getString("codProprietario") %>)
                        </option>
                        <%
                            }
                            funzioni.closeResultSet(rs);
                        %>
                    </select>

                    <br>
                    <input type="submit" value="Mostra appartamenti">
                </form>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
