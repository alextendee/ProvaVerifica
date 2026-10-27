<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Conferma eliminazione</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Conferma dell'eliminazione</h2>

                <%
                    //leggo il proprietario da eliminare
                    String codProprietario=request.getParameter("codProprietario");
                    if(codProprietario==null) codProprietario="";

                    if (codProprietario.trim().equals("")) {
                        out.println("<p class='msg-errore'>Errore: non e' stato selezionato nessun proprietario.</p>");
                        out.println("<a class='bottone' href='eliminaProprietario.jsp'>Torna alla pagina di eliminazione</a>");
                    } else {
                        codProprietario=codProprietario.trim();

                        //controllo se il proprietario esiste
                        String sqlProprietario = "SELECT * FROM proprietari WHERE codProprietario=" + funzioni.fc(codProprietario);
                        ResultSet rs = funzioni.select(sqlProprietario);

                        if (rs == null) {
                            out.println("<p class='msg-errore'>Errore di accesso al database. Controllare il file error.log.</p>");
                        } else if (!rs.next()) {
                            out.println("<p class='msg-errore'>Errore: il proprietario con codice <b>" + codProprietario + "</b> non esiste nel database.</p>");
                            out.println("<a class='bottone' href='eliminaProprietario.jsp'>Torna alla pagina di eliminazione</a>");
                            funzioni.closeResultSet(rs);
                        } else {
                            //dati del proprietario da eliminare
                            String nome=rs.getString("nome");
                            String cognome=rs.getString("cognome");
                            String cittaProprietario=rs.getString("citta");
                            String telefono=rs.getString("telefono");
                            funzioni.closeResultSet(rs);
                %>
                <p>
                    Eliminazione del proprietario <b><%= cognome %>&nbsp;<%= nome %></b>
                    (cod. <b><%= codProprietario %></b>) - citta: <b><%= cittaProprietario %></b>, telefono: <b><%= telefono %></b>.
                </p>

                <p>Verranno eliminati automaticamente anche i seguenti appartamenti a lui associati
                    e i loro affitti:</p>

                <%
                            //lista degli appartamenti del proprietario che verranno eliminati
                            String sql = "SELECT * FROM appartamenti WHERE codProprietario=" + funzioni.fc(codProprietario) + " ORDER BY codAppartamento";
                            ResultSet rsApp = funzioni.select(sql);
                            int numeroAppartamenti = 0;

                            if (rsApp != null) {
                %>
                <table class="dati">
                    <tr>
                        <th>Codice appartamento</th>
                        <th>Superficie (mq)</th>
                        <th>Vani</th>
                        <th>Citta</th>
                    </tr>
                    <%
                                while (rsApp.next()) {
                                    numeroAppartamenti++;
                    %>
                    <tr>
                        <td><%= rsApp.getInt("codAppartamento") %></td>
                        <td><%= rsApp.getInt("superficie") %></td>
                        <td><%= rsApp.getInt("vani") %></td>
                        <td><%= rsApp.getString("citta") %></td>
                    </tr>
                    <%
                                }
                                funzioni.closeResultSet(rsApp);
                            }

                            //numero di affitti collegati agli appartamenti del proprietario
                            int numeroAffitti = 0;
                            String sqlAffitti = "SELECT COUNT(*) FROM affitti WHERE codAppartamento IN (SELECT codAppartamento FROM appartamenti WHERE codProprietario=" + funzioni.fc(codProprietario) + ")";
                            ResultSet rsAff = funzioni.select(sqlAffitti);
                            if (rsAff != null && rsAff.next()) {
                                numeroAffitti = rsAff.getInt(1);
                            }
                            funzioni.closeResultSet(rsAff);

                            if (rsApp == null) {
                                out.println("<p class='msg-errore'>Errore di accesso al database. Controllare il file error.log.</p>");
                            } else if (numeroAppartamenti == 0) {
                    %>
                <p>Questo proprietario non possiede nessun appartamento.</p>
                    <%
                            }
                    %>

                <p class="msg-errore">
                    In totale verranno eliminati: 1 proprietario, <b><%= numeroAppartamenti %></b> appartamenti
                    e <b><%= numeroAffitti %></b> affitti. L'operazione non e' annullabile!
                </p>

                <form action="eliminaDefinitiva.jsp" method="post">
                    <input type="hidden" name="codProprietario" value="<%= codProprietario %>">
                    <input type="hidden" name="conferma" value="SI">
                    <input type="submit" value="Elimina definitivamente">
                </form>

                <a class="bottone" href="eliminaProprietario.jsp">Annulla</a>
                    <%
                        }
                    }
                %>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
