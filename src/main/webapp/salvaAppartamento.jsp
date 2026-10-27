<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Salvataggio appartamento</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Salvataggio del nuovo appartamento</h2>

                <%
                    //leggo i dati passati dal form
                    String codProprietario=request.getParameter("codProprietario");
                    String superficie=request.getParameter("superficie");
                    String vani=request.getParameter("vani");
                    String citta=request.getParameter("citta");

                    if(codProprietario==null) codProprietario="";
                    if(superficie==null) superficie="";
                    if(vani==null) vani="";
                    if(citta==null) citta="";

                    codProprietario=codProprietario.trim();
                    superficie=superficie.trim();
                    vani=vani.trim();
                    citta=citta.trim();

                    //controllo che tutti i campi siano stati compilati
                    if (codProprietario.equals("") || superficie.equals("") || vani.equals("") || citta.equals("")) {
                        out.println("<p class='msg-errore'>Errore: tutti i campi devono essere compilati (e va selezionato un proprietario dalla lista).</p>");
                        out.println("<a class='bottone' href='inserisciAppartamento.jsp'>Torna al modulo di inserimento</a>");
                    } else {
                        //controllo se il proprietario scelto esiste
                        String sqlVerifica = "SELECT * FROM proprietari WHERE codProprietario=" + funzioni.fc(codProprietario);

                        if (!funzioni.verificaEsistente(sqlVerifica)) {
                            out.println("<p class='msg-errore'>Errore: il proprietario selezionato (cod. <b>" + codProprietario + "</b>) non esiste nel database.</p>");
                            out.println("<a class='bottone' href='inserisciAppartamento.jsp'>Torna al modulo di inserimento</a>");
                        } else {
                            //controllo che superficie e vani siano valori numerici
                            boolean numeriValidi = true;
                            int superficieMq = 0;
                            int numeroVani = 0;
                            try {
                                superficieMq = Integer.parseInt(superficie);
                                numeroVani = Integer.parseInt(vani);
                                if (superficieMq < 1 || numeroVani < 1) numeriValidi = false;
                            } catch (NumberFormatException e) {
                                numeriValidi = false;
                            }

                            if (!numeriValidi) {
                                out.println("<p class='msg-errore'>Errore: superficie e numero di vani devono essere numeri interi positivi.</p>");
                                out.println("<a class='bottone' href='inserisciAppartamento.jsp'>Torna al modulo di inserimento</a>");
                            } else {
                                //inserimento nella tabella appartamenti: la chiave codAppartamento e' autoincrementante
                                String[] campi = {"codAppartamento", "superficie", "vani", "citta", "codProprietario"};
                                String[] valori = {
                                    "0",
                                    String.valueOf(superficieMq),
                                    String.valueOf(numeroVani),
                                    funzioni.fc(citta),
                                    funzioni.fc(codProprietario)
                                };

                                boolean inserito = funzioni.update(campi, valori, "appartamenti", true, true);

                                if (inserito) {
                                    //rileggo il codice assegnato automaticamente all'appartamento
                                    int nuovoCodice = 0;
                                    ResultSet rs = funzioni.select("SELECT MAX(codAppartamento) FROM appartamenti WHERE codProprietario=" + funzioni.fc(codProprietario));
                                    if (rs.next()) {
                                        nuovoCodice = rs.getInt(1);
                                    }
                                    funzioni.closeResultSet(rs);

                                    out.println("<p class='msg-ok'>Appartamento inserito correttamente con codice <b>" + nuovoCodice + "</b> (citta <b>" + citta + "</b>, superficie " + superficieMq + " mq, " + numeroVani + " vani) e assegnato al proprietario <b>" + codProprietario + "</b>.</p>");
                                    out.println("<a class='bottone' href='inserisciAffitto.jsp'>Inserisci un affitto per questo appartamento</a> ");
                                    out.println("<a class='bottone' href='cercaProprietario.jsp'>Vedi gli appartamenti del proprietario</a> ");
                                    out.println("<a class='bottone' href='index.jsp'>Torna alla home</a>");
                                } else {
                                    out.println("<p class='msg-errore'>Errore durante l'inserimento nel database. Controllare il file error.log.</p>");
                                    out.println("<a class='bottone' href='inserisciAppartamento.jsp'>Torna al modulo di inserimento</a>");
                                }
                            }
                        }
                    }
                %>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
