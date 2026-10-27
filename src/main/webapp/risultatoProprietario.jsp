<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Appartamenti del proprietario</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Appartamenti del proprietario</h2>

                <%
                    //leggo il proprietario scelto nella pagina di ricerca
                    String codProprietario=request.getParameter("codProprietario");
                    if(codProprietario==null) codProprietario="";

                    if (codProprietario.trim().equals("")) {
                        out.println("<p class='msg-errore'>Errore: non e' stato selezionato nessun proprietario.</p>");
                        out.println("<a class='bottone' href='cercaProprietario.jsp'>Torna alla pagina di ricerca</a>");
                    } else {
                        codProprietario=codProprietario.trim();

                        //controllo se il proprietario esiste
                        String sqlProprietario = "SELECT * FROM proprietari WHERE codProprietario=" + funzioni.fc(codProprietario);
                        ResultSet rs = funzioni.select(sqlProprietario);

                        if (rs == null) {
                            out.println("<p class='msg-errore'>Errore di accesso al database. Controllare il file error.log.</p>");
                        } else if (!rs.next()) {
                            out.println("<p class='msg-errore'>Errore: il proprietario con codice <b>" + codProprietario + "</b> non esiste nel database.</p>");
                            out.println("<a class='bottone' href='cercaProprietario.jsp'>Torna alla pagina di ricerca</a>");
                            funzioni.closeResultSet(rs);
                        } else {
                            //dati del proprietario
                            String nome=rs.getString("nome");
                            String cognome=rs.getString("cognome");
                            String cittaProprietario=rs.getString("citta");
                            String telefono=rs.getString("telefono");
                            funzioni.closeResultSet(rs);
                %>
                <p class="msg-info">
                    Dati del proprietario <b><%= cognome %>&nbsp;<%= nome %></b>
                    (cod. <b><%= codProprietario %></b>) - citta: <b><%= cittaProprietario %></b>, telefono: <b><%= telefono %></b>.
                </p>

                <%
                            //lista degli appartamenti posseduti dal proprietario
                            String sql = "SELECT * FROM appartamenti WHERE codProprietario=" + funzioni.fc(codProprietario) + " ORDER BY codAppartamento";
                            ResultSet rsApp = funzioni.select(sql);

                            if (rsApp == null) {
                                out.println("<p class='msg-errore'>Errore di accesso al database. Controllare il file error.log.</p>");
                            } else {
                                int numeroAppartamenti = 0;
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

                                if (numeroAppartamenti == 0) {
                    %>
                </table>
                <p class="msg-info">Il proprietario <b><%= cognome %>&nbsp;<%= nome %></b> attualmente non possiede nessun appartamento.</p>
                    <%
                                } else {
                    %>
                </table>
                <p class="msg-ok">Il proprietario <b><%= cognome %>&nbsp;<%= nome %></b> possiede <b><%= numeroAppartamenti %></b> appartamenti.</p>
                    <%
                                }
                    %>
                <a class="bottone" href="cercaProprietario.jsp">Nuova ricerca per proprietario</a>
                    <%
                            }
                        }
                    }
                %>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
