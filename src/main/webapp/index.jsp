<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Home</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <p>
                    Sito di gestione delle proprietà e degli affitti degli appartamenti.
                    Dal menu (o dalle caselle qui sotto) si possono eseguire le operazioni richieste.
                </p>
                <div class="caselle">
                    <div class="casella">
                        <h3>Nuovo proprietario</h3>
                        <p>Inserimento di un nuovo proprietario (nome, cognome, citta, telefono).</p>
                        <a href="inserisciProprietario.jsp">Vai alla pagina &rarr;</a>
                    </div>
                    <div class="casella">
                        <h3>Nuovo appartamento</h3>
                        <p>Inserimento di un nuovo appartamento dopo aver selezionato un proprietario esistente.</p>
                        <a href="inserisciAppartamento.jsp">Vai alla pagina &rarr;</a>
                    </div>
                    <div class="casella">
                        <h3>Nuovo affitto</h3>
                        <p>Inserimento di un nuovo importo di affitto dopo aver selezionato l'appartamento.</p>
                        <a href="inserisciAffitto.jsp">Vai alla pagina &rarr;</a>
                    </div>
                    <div class="casella">
                        <h3>Ricerca per citta</h3>
                        <p>Selezionata una citta, visualizzazione di tutti gli appartamenti che si trovano in quella citta.</p>
                        <a href="cercaCitta.jsp">Vai alla pagina &rarr;</a>
                    </div>
                    <div class="casella">
                        <h3>Appartamenti di un proprietario</h3>
                        <p>Dato un proprietario (a scelta tra quelli esistenti), visualizzazione di tutti gli appartamenti posseduti.</p>
                        <a href="cercaProprietario.jsp">Vai alla pagina &rarr;</a>
                    </div>
                    <div class="casella">
                        <h3>Elimina proprietario</h3>
                        <p>Eliminazione di un proprietario con eliminazione automatica degli appartamenti ad esso associati.</p>
                        <a href="eliminaProprietario.jsp">Vai alla pagina &rarr;</a>
                    </div>
                </div>
            </div>
            <div class="footer">Verifica di Informatica - database PROPRIETARI / APPARTAMENTI / AFFITTI</div>
        </div>
    </body>
</html>
