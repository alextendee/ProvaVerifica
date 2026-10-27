<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Salvataggio affitto</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Salvataggio del nuovo affitto</h2>

                <%
                    //leggo i dati passati dal form
                    String codAppartamento=request.getParameter("codAppartamento");
                    String data=request.getParameter("data");
                    String importo=request.getParameter("importo");

                    if(codAppartamento==null) codAppartamento="";
                    if(data==null) data="";
                    if(importo==null) importo="";

                    codAppartamento=codAppartamento.trim();
                    data=data.trim();
                    importo=importo.trim();

                    //controllo che tutti i campi siano stati compilati
                    if (codAppartamento.equals("") || data.equals("") || importo.equals("")) {
                        out.println("<p class='msg-errore'>Errore: tutti i campi devono essere compilati (e va selezionato un appartamento dalla lista).</p>");
                        out.println("<a class='bottone' href='inserisciAffitto.jsp'>Torna al modulo di inserimento</a>");
                    } else {
                        //controllo che il codice dell'appartamento sia un numero e che l'appartamento esista
                        boolean codiceValido = true;
                        int numeroAppartamento = 0;
                        try {
                            numeroAppartamento = Integer.parseInt(codAppartamento);
                        } catch (NumberFormatException e) {
                            codiceValido = false;
                        }

                        String sqlVerifica = "SELECT * FROM appartamenti WHERE codAppartamento=" + numeroAppartamento;
                        if (!codiceValido || !funzioni.verificaEsistente(sqlVerifica)) {
                            out.println("<p class='msg-errore'>Errore: l'appartamento selezionato (cod. <b>" + codAppartamento + "</b>) non esiste nel database.</p>");
                            out.println("<a class='bottone' href='inserisciAffitto.jsp'>Torna al modulo di inserimento</a>");
                        } else {
                            //controllo che la data sia nel formato aaaa-mm-gg (quello del campo date del form)
                            boolean dataValida = data.matches("\\d{4}-\\d{2}-\\d{2}");

                            //controllo che l'importo sia un numero
                            boolean importoValido = true;
                            int numeroImporto = 0;
                            try {
                                numeroImporto = Integer.parseInt(importo);
                                if (numeroImporto < 1) importoValido = false;
                            } catch (NumberFormatException e) {
                                importoValido = false;
                            }

                            if (!dataValida || !importoValido) {
                                out.println("<p class='msg-errore'>Errore: la data non e' valida oppure l'importo non e' un numero positivo.</p>");
                                out.println("<a class='bottone' href='inserisciAffitto.jsp'>Torna al modulo di inserimento</a>");
                            } else {
                                //inserimento nella tabella affitti: la chiave idAffitto e' autoincrementante
                                String[] campi = {"idAffitto", "data", "importo", "codAppartamento"};
                                String[] valori = {
                                    "0",
                                    funzioni.fc(data),
                                    String.valueOf(numeroImporto),
                                    String.valueOf(numeroAppartamento)
                                };

                                boolean inserito = funzioni.update(campi, valori, "affitti", true, true);

                                if (inserito) {
                                    out.println("<p class='msg-ok'>Affitto inserito correttamente per l'appartamento n. <b>" + numeroAppartamento + "</b>: data <b>" + funzioni.cvDataIta(data) + "</b>, importo <b>" + numeroImporto + " euro</b>.</p>");
                                    out.println("<a class='bottone' href='inserisciAffitto.jsp'>Inserisci un altro affitto</a> ");
                                    out.println("<a class='bottone' href='index.jsp'>Torna alla home</a>");
                                } else {
                                    out.println("<p class='msg-errore'>Errore durante l'inserimento nel database. Controllare il file error.log.</p>");
                                    out.println("<a class='bottone' href='inserisciAffitto.jsp'>Torna al modulo di inserimento</a>");
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
