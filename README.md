# ProvaAppartamenti

Sito per la gestione di proprietari, appartamenti e affitti, realizzato per la verifica di Informatica
seguito lo stesso schema del progetto **web5A26** (pagine JSP + classe `FunzioniDB` + MySQL), senza servlet.

## Database di riferimento

Le tre tabelle richieste dalla verifica (database `appartamento` su MySQL/MariaDB locale, utente `root`, password vuota):

```
PROPRIETARI    (codProprietario varchar(50) PK, nome, cognome, citta, telefono)
APPARTAMENTI   (codAppartamento int AUTO_INCREMENT PK, superficie, vani, citta, codProprietario)
AFFITTI        (idAffitto int AUTO_INCREMENT PK, data, importo, codAppartamento)
```

Per creare/ricaricare il database: eseguire lo script `sql/appartamenti.sql`
(istruzioni PHPMyAdmin o riga di comando `mysql`).

La connessione al DB viene aperta in `src/main/webapp/connessione.jsp` (oggetto `FunzioniDB`
memorizzato in sessione, come nel progetto web5A26).

## Funzionalita implementate

| Richiesta della verifica | Pagina form | Pagina di elaborazione |
|---|---|---|
| Inserimento di un nuovo proprietario | `inserisciProprietario.jsp` | `salvaProprietario.jsp` |
| Inserimento di un nuovo appartamento dopo aver selezionato un proprietario esistente | `inserisciAppartamento.jsp` | `salvaAppartamento.jsp` |
| Inserimento di un nuovo importo di affitto (dopo aver selezionato l'appartamento) | `inserisciAffitto.jsp` | `salvaAffitto.jsp` |
| Selezionata una citta, visualizzare tutti gli appartamenti che si trovano in quella citta | `cercaCitta.jsp` | `risultatoCitta.jsp` |
| Dato un proprietario, visualizzare tutti gli appartamenti posseduti | `cercaProprietario.jsp` | `risultatoProprietario.jsp` |
| Eliminazione di un proprietario con eliminazione automatica degli appartamenti associati | `eliminaProprietario.jsp` | `eliminaConferma.jsp` poi `eliminaDefinitiva.jsp` |

`index.jsp` e' la home con il menu di tutte le funzionalita; `menu.jsp` e `stile.css`
definiscono la navigazione e il layout comune di tutte le pagine.

## Struttura

```
src/main/java/esempio/FunzioniDB.java  -> classe di utilita per il database (copia identica di web5A26)
src/main/webapp/*.jsp                  -> il sito (solo JSP, nessuna servlet)
src/main/webapp/stile.css              -> stile del sito
sql/appartamenti.sql                   -> script di creazione del database con i dati di prova
```

## Compilazione e avvio

1. Compilare il war (serve JDK 17):

   ```
   set JAVA_HOME=C:\Program Files\Java\jdk-17.0.2
   mvnw.cmd package
   ```

2. Copiare `target/ProvaAppartamenti-1.0-SNAPSHOT.war` dentro la cartella
   `webapps` di Tomcat 10.1 (es. quello presente in `Desktop\Informatica 5AI\apache-tomcat-10.1.61`),
   rinominandolo in `ProvaAppartamenti.war`, e avviare Tomcat.

3. Aprire nel browser: http://localhost:8080/ProvaAppartamenti/index.jsp
