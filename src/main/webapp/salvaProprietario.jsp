<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Salvataggio proprietario</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="connessione.jsp" %>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Salvataggio del nuovo proprietario</h2>

                <%
                    //leggo i dati passati dal form
                    String cod=request.getParameter("codProprietario");
                    String nome=request.getParameter("nome");
                    String cognome=request.getParameter("cognome");
                    String citta=request.getParameter("citta");
                    String telefono=request.getParameter("telefono");

                    if(cod==null) cod="";
                    if(nome==null) nome="";
                    if(cognome==null) cognome="";
                    if(citta==null) citta="";
                    if(telefono==null) telefono="";

                    cod=cod.trim();
                    nome=nome.trim();
                    cognome=cognome.trim();
                    citta=citta.trim();
                    telefono=telefono.trim();

                    //controllo che tutti i campi siano stati compilati
                    if (cod.equals("") || nome.equals("") || cognome.equals("") || citta.equals("") || telefono.equals("")) {
                        out.println("<p class='msg-errore'>Errore: tutti i campi del modulo devono essere compilati.</p>");
                        out.println("<a class='bottone' href='inserisciProprietario.jsp'>Torna al modulo di inserimento</a>");
                    } else {
                        //controllo se esiste gia' un proprietario con lo stesso codice
                        String sqlVerifica = "SELECT * FROM proprietari WHERE codProprietario=" + funzioni.fc(cod);

                        if (funzioni.verificaEsistente(sqlVerifica)) {
                            out.println("<p class='msg-errore'>Errore: esiste gia' un proprietario con il codice <b>" + cod + "</b>.</p>");
                            out.println("<a class='bottone' href='inserisciProprietario.jsp'>Torna al modulo di inserimento</a>");
                        } else {
                            //inserimento nella tabella proprietari (la chiave non e' autoincrementante)
                            String[] campi = {"codProprietario", "nome", "cognome", "citta", "telefono"};
                            String[] valori = {
                                funzioni.fc(cod),
                                funzioni.fc(nome),
                                funzioni.fc(cognome),
                                funzioni.fc(citta),
                                funzioni.fc(telefono)
                            };

                            boolean inserito = funzioni.update(campi, valori, "proprietari", true, false);

                            if (inserito) {
                                out.println("<p class='msg-ok'>Proprietario <b>" + nome + " " + cognome + "</b> (cod. <b>" + cod + "</b>) inserito correttamente.</p>");
                                out.println("<a class='bottone' href='inserisciProprietario.jsp'>Inserisci un altro proprietario</a> ");
                                out.println("<a class='bottone' href='inserisciAppartamento.jsp'>Inserisci un appartamento per lui</a> ");
                                out.println("<a class='bottone' href='index.jsp'>Torna alla home</a>");
                            } else {
                                out.println("<p class='msg-errore'>Errore durante l'inserimento nel database. Controllare il file error.log.</p>");
                                out.println("<a class='bottone' href='inserisciProprietario.jsp'>Torna al modulo di inserimento</a>");
                            }
                        }
                    }
                %>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
