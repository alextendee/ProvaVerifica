<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="stile.css">
        <title>Gestione Appartamenti - Nuovo proprietario</title>
    </head>
    <body>
        <div class="container">
            <h1 class="titolo">Gestione Appartamenti e Affitti</h1>
            <%@include file="menu.jsp" %>
            <div class="contenuto">
                <h2 class="sottotitolo">Inserimento di un nuovo proprietario</h2>

                <form class="modulo" action="salvaProprietario.jsp" method="post">
                    <label for="codProprietario">Codice proprietario</label>
                    <input type="text" id="codProprietario" name="codProprietario" maxlength="50" required>
                    <label for="nome">Nome</label>
                    <input type="text" id="nome" name="nome" maxlength="50" required>
                    <label for="cognome">Cognome</label>
                    <input type="text" id="cognome" name="cognome" maxlength="50" required>
                    <label for="citta">Citta</label>
                    <input type="text" id="citta" name="citta" maxlength="50" required>
                    <label for="telefono">Telefono</label>
                    <input type="text" id="telefono" name="telefono" maxlength="50" required>
                    <br>
                    <input type="submit" value="Inserisci proprietario">
                </form>

                <p class="msg-info">
                    Il codice proprietario identifica la persona nel database (ad esempio: rsma, bcgv, ...).
                </p>
            </div>
            <div class="footer">Verifica di Informatica - Gestione appartamenti e affitti</div>
        </div>
    </body>
</html>
