<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Risultato ricerca per citta</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Appartamenti trovati</h2>

                <%
                    //leggo la citta scelta nella pagina di ricerca
                    String citta=request.getParameter("citta");
                    if(citta==null) citta="";

                    if (citta.trim().equals("")) {
                        out.println("<p class='msg-errore'>Errore: non e' stata selezionata nessuna citta.</p>");
                        out.println("<a class='bottone' href='cercaCitta.jsp'>Torna alla pagina di ricerca</a>");
                    } else {
                        citta=citta.trim();

                        //cercare tutti gli appartamenti che si trovano nella citta scelta
                        String sql = "SELECT * FROM appartamenti WHERE citta=" + funzioni.fc(citta) + " ORDER BY codAppartamento";
                        ResultSet rs = funzioni.select(sql);

                        if (rs == null) {
                            out.println("<p class='msg-errore'>Errore di accesso al database. Controllare il file error.log.</p>");
                        } else {
                            //contare e visualizzare gli appartamenti trovati
                            int numeroAppartamenti = 0;
                %>
                <p class="msg-info">Appartamenti nella citta di <b><%= citta %></b>:</p>

                <table class="dati">
                    <tr>
                        <th>Codice appartamento</th>
                        <th>Superficie (mq)</th>
                        <th>Vani</th>
                        <th>Citta</th>
                        <th>Cod. proprietario</th>
                    </tr>
                    <%
                            while (rs.next()) {
                                numeroAppartamenti++;
                    %>
                    <tr>
                        <td><%= rs.getInt("codAppartamento") %></td>
                        <td><%= rs.getInt("superficie") %></td>
                        <td><%= rs.getInt("vani") %></td>
                        <td><%= rs.getString("citta") %></td>
                        <td><%= rs.getString("codProprietario") %></td>
                    </tr>
                    <%
                            }
                            funzioni.closeResultSet(rs);

                            if (numeroAppartamenti == 0) {
                    %>
                </table>
                <p class="msg-info">Nessun appartamento si trova nella citta di <b><%= citta %></b>.</p>
                    <%
                            } else {
                    %>
                </table>
                <p class="msg-ok">Trovati <b><%= numeroAppartamenti %></b> appartamenti nella citta di <b><%= citta %></b>.</p>
                    <%
                            }
                    %>
                <a class="bottone" href="cercaCitta.jsp">Nuova ricerca per citta</a>
                    <%
                        }
                    }
                %>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
