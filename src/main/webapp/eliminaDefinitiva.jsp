<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Eliminazione conclusa</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Esito dell'eliminazione</h2>

                <%
                    //leggo i parametri: il codice del proprietario e la conferma ricevuta dalla pagina precedente
                    String codProprietario=request.getParameter("codProprietario");
                    String conferma=request.getParameter("conferma");

                    if(codProprietario==null) codProprietario="";
                    if(conferma==null) conferma="";

                    codProprietario=codProprietario.trim();

                    if (!conferma.equals("SI") || codProprietario.equals("")) {
                        //senza conferma si torna alla pagina che seleziona il proprietario da eliminare
                        response.sendRedirect("eliminaProprietario.jsp");
                    } else {
                        //controllo se il proprietario esiste
                        String sqlVerifica = "SELECT * FROM proprietari WHERE codProprietario=" + funzioni.fc(codProprietario);

                        if (!funzioni.verificaEsistente(sqlVerifica)) {
                            out.println("<p class='msg-errore'>Errore: il proprietario con codice <b>" + codProprietario + "</b> non esiste nel database.</p>");
                            out.println("<a class='bottone' href='eliminaProprietario.jsp'>Torna alla pagina di eliminazione</a>");
                        } else {
                            //conto gli appartamenti e gli affitti che verranno eliminati
                            int numeroAppartamenti = 0;
                            int numeroAffitti = 0;

                            String sqlContaApp = "SELECT COUNT(*) FROM appartamenti WHERE codProprietario=" + funzioni.fc(codProprietario);
                            ResultSet rsApp = funzioni.select(sqlContaApp);
                            if (rsApp != null && rsApp.next()) {
                                numeroAppartamenti = rsApp.getInt(1);
                            }
                            funzioni.closeResultSet(rsApp);

                            String sqlContaAff = "SELECT COUNT(*) FROM affitti WHERE codAppartamento IN (SELECT codAppartamento FROM appartamenti WHERE codProprietario=" + funzioni.fc(codProprietario) + ")";
                            ResultSet rsAff = funzioni.select(sqlContaAff);
                            if (rsAff != null && rsAff.next()) {
                                numeroAffitti = rsAff.getInt(1);
                            }
                            funzioni.closeResultSet(rsAff);

                            //eliminazione con cancellazione a cascata:
                            //1) prima gli affitti degli appartamenti del proprietario
                            boolean okAffitti = true;
                            if (numeroAffitti > 0) {
                                String sqlDelAffitti = "DELETE FROM affitti WHERE codAppartamento IN (SELECT codAppartamento FROM appartamenti WHERE codProprietario=" + funzioni.fc(codProprietario) + ")";
                                okAffitti = funzioni.update(sqlDelAffitti);
                            }

                            //2) poi gli appartamenti del proprietario
                            boolean okAppartamenti = true;
                            if (numeroAppartamenti > 0) {
                                String sqlDelAppartamenti = "DELETE FROM appartamenti WHERE codProprietario=" + funzioni.fc(codProprietario);
                                okAppartamenti = funzioni.update(sqlDelAppartamenti);
                            }

                            //3) infine il proprietario
                            String sqlDelProprietario = "DELETE FROM proprietari WHERE codProprietario=" + funzioni.fc(codProprietario);
                            boolean okProprietario = funzioni.update(sqlDelProprietario);

                            if (okAffitti && okAppartamenti && okProprietario) {
                                out.println("<p class='msg-ok'>Eliminazione completata: il proprietario <b>" + codProprietario + "</b> e' stato cancellato insieme a <b>" + numeroAppartamenti + "</b> appartamenti e <b>" + numeroAffitti + "</b> affitti.</p>");
                            } else {
                                out.println("<p class='msg-errore'>Errore durante l'eliminazione. Controllare il file error.log e ripetere eventualmente l'operazione.</p>");
                            }

                            out.println("<a class='bottone' href='eliminaProprietario.jsp'>Elimina un altro proprietario</a> ");
                            out.println("<a class='bottone' href='index.jsp'>Torna alla home</a>");
                        }
                    }
                %>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
