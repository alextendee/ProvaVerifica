/*
 * Created on 29-ott-2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package esempio;


import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;




/**
 * @author depietro
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
/**
 * @author depietro
 *
 * Attenzione modificare i parametri di connessione.
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

public class FunzioniDB {

	private Connection cn;
	private String connectionString;
	protected static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");





	public FunzioniDB(String connectionString, String user, String password){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");


            cn = DriverManager.getConnection(connectionString,user,password);

        } catch (SQLException | ClassNotFoundException ex) {
        	saveLogError("FunzioniDB.FunzioniDB", ex.getMessage());
        	throw new RuntimeException("Impossibile connettersi al database: " + ex.getMessage(), ex);
        }

	}




	public String fc(String campo)
	{
		campo="'"+ campo.replaceAll("'","''")+ "'";
		return campo;
	}

	public String nn(String campo){
	    if (campo.equals("null")) campo="";
	    return campo;
	}



	/**Funzione di conversione date.
	 * @param data Accetta una data nel formato gg/mm/aaaa
	 * @return Restituisce la data nel formato aaaa-mm-gg
	 */
	public String cvData(String data){
		String param[]=data.split("/");
		//return param[2]+"-"+param[1]+"-"+param[0];
		if (param[1].length()==1) param[1]="0"+param[1];
		if (param[0].length()==1) param[0]="0"+param[0];
		return param[2]+param[1]+param[0];
	}

	/**Funzione di conversione date.
	 * @param data Accetta una data nel formato aaaa-mm-gg
	 * @return Restituisce la data nel formato gg/mm/aaaa
	 */
	public String cvDataIta(String data){
	    //return data.substring(6)+"/"+data.substring(4,6)+"/"+data.substring(0,4);
	    String param[]=data.split("-");
		return param[2]+"/"+param[1]+"/"+param[0];
	}

        /**
         * Metodo che accetta un anno nel formato gg/mm/aa e lo restituisce nel formato gg/mm/aaaa
         * Il confronto viene fatto sulle due cifre, se superano 50 allora viene aggiunto 19 altrimenti 20
         * @param data
         * @return
         */
        public String anno2CifreToAnno4Cifre(String data){
            if(data.length()==10)
                return data;

            int anno=Integer.parseInt(data.substring(data.lastIndexOf("/")+1));
            if (anno>50)
                anno=1900+anno;
            else
                anno=2000+anno;
            String dataModificata=data.substring(0, data.lastIndexOf("/")+1)+Integer.toString(anno);

            return dataModificata;
        }

	public ResultSet select(String sql){
		ResultSet rs;
		Statement stmt;
		try {

			 stmt = cn.createStatement();
			 rs=stmt.executeQuery(sql);
			 //stmt.close();
			 //pool.freeConnection(cn);
			 return rs;
			}
		catch (Exception e) {
			// TODO Auto-generated catch block
			saveLogError("FunzioniDB.select", e.getMessage());
			return null;
		}

	}

	public void closeConnection() throws SQLException{
		cn.close();
	}

	public void closeResultSet(ResultSet rs) {
		if (rs != null) {
			try {
				Statement stmt = rs.getStatement();
				rs.close();
				if (stmt != null) stmt.close();
			} catch (SQLException e) {
				saveLogError("FunzioniDB.closeResultSet", e.getMessage());
			}
		}
	}

	public ResultSet selectDynamic(String sql){
		ResultSet rs;
		Statement stmt;
		try {

			 stmt = cn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                     ResultSet.CONCUR_UPDATABLE);
			 rs=stmt.executeQuery(sql);
			 //stmt.close();

			 return rs;
			}
		catch (Exception e) {
			// TODO Auto-generated catch block
			saveLogError("FunzioniDB.selectDynamic", e.getMessage());
			return null;
		}

	}

	/**
			* Converte una data dal formato italiano "dd-MM-yyyy HH:mm:ss"
			* al formato MySQL "yyyy-MM-dd HH:mm:ss"
			* @param dateStr Data nel formato dd-MM-yyyy HH:mm:ss
 			* @return Data nel formato yyyy-MM-dd HH:mm:ss, o null se la stringa è nulla/vuota
 	*/
	public String toMySQLDate(String dateStr) {
		if (dateStr == null || dateStr.trim().isEmpty()) return null;
		try {
			DateTimeFormatter input  = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
			DateTimeFormatter output = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			return LocalDateTime.parse(dateStr.trim(), input).format(output);
		} catch (Exception e) {
			saveLogError("FunzioniDB.toMySQLDate", "Formato data non valido: " + dateStr + " - " + e.getMessage());
			return null;
		}
	}

	public boolean update(String sql){
		Statement stmt;
		try{
			int righeModificate;
		    //modifica i dati

			stmt = cn.createStatement();
			righeModificate=stmt.executeUpdate(sql);
			stmt.close();

			if (righeModificate==0) return false;
			else return true;
		}
		catch (Exception e){
			saveLogError("FunzioniDB.update", e.getMessage());
			return false;
		}

	}

	/**Funzione di aggiornamento dati.
	 * @param campi Array di stringhe contenente tutti i nomi dei campi.
	 * @param valori Array di stringhe contenente tutti i valori dei campi.
	 * @param tabella Il nome della tabella interessata dalla query.
	 * @param inserimento Indicare true se si vuole eseguire una INSERT, false se si vuole eseguire un UPDATE.
	 * @param codiceAutoIncrement Valore booleano. Indicare true se la chiave primaria � autoincrementante e quindi non va inserita nella query sql di inserimento
	 * @return Restituisce un valore booleano che indica se l'operazione � andata a buon fine.
	 */
	public boolean update (String[] campi,String[] valori,String tabella,boolean inserimento,boolean codiceAutoIncrement){
		String sql;
		byte i;
		byte inizio;

		if (codiceAutoIncrement)
		{
			inizio=1;
		}
		else
		{
			inizio=0;
		}

		if (inserimento)
		{
			//inserimento
			sql="INSERT INTO "+tabella+" (";
			for (i=inizio;i<(campi.length)-1;i++)
			{
				sql+=campi[i]+",";
			}
			sql+=campi[i]+") VALUES (";

			for (i=inizio;i<(valori.length)-1;i++)
			{
				sql+=valori[i]+",";
			}
			sql+=valori[i]+")";

		}

		else
		{
			//aggiornamento
			sql="UPDATE "+tabella+" SET ";
			for (i=1;i<(valori.length)-1;i++)
			{
				sql+=campi[i]+"="+valori[i]+",";
			}
			sql+=campi[i]+"="+valori[i]+" WHERE "+campi[0]+"="+valori[0];
		}

		return update(sql);

	}

	/**
	 * Converte una data dal formato MySQL "yyyy-MM-dd HH:mm:ss"
	 * al formato compatibile con la classe Transazioni "dd-MM-yyyy HH:mm:ss"
	 * @param dateStr Data nel formato yyyy-MM-dd HH:mm:ss
	 * @return Data nel formato dd-MM-yyyy HH:mm:ss, o null se la stringa è nulla/vuota
	 */
	public String fromMySQLDate(String dateStr) {
		if (dateStr == null || dateStr.trim().isEmpty()) return null;
		try {
			DateTimeFormatter input  = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			DateTimeFormatter output = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
			return LocalDateTime.parse(dateStr.trim(), input).format(output);
		} catch (Exception e) {
			saveLogError("FunzioniDB.fromMySQLDate", "Formato data non valido: " + dateStr + " - " + e.getMessage());
			return null;
		}
	}

    public Connection getConnection() {
        return cn;
    }

    public String getConnectionString() {
        return connectionString;
    }




    /**
     *  *
     *
     * Metodo che verifica se un record � gi� presente.
     * @param sql Query di interrogazione. Preferibilmente con ricerca su chiave primaria
     * @return true se il record esiste altrimenti false
     */

	public boolean verificaEsistente(String sql) {
		ResultSet rs = null;
		try {
			rs = select(sql);
			return rs != null && rs.next();
		} catch (SQLException e) {
			saveLogError("FunzioniDB.verificaEsistente", e.getMessage());
			return false;
		} finally {
			closeResultSet(rs);
		}
	}

	public void saveLogError(String classeMetodo, String messaggio){
		LocalDateTime data=LocalDateTime.now();
		messaggio = messaggio.replace('\n', ' ').replace('\r', ' ');
		DateTimeFormatter formatter=DateTimeFormatter.ofPattern("dd/MM/yyyy hh:mm");
		String rigaLog="\n"+data.format(formatter)+" - "+ classeMetodo + " - "+ messaggio;
		File logDir = new File(System.getProperty("user.dir"));
		File logFile = new File(logDir, "error.log");
		try (FileWriter file = new FileWriter(logFile, true)) { // 'true' = append mode, 'try-with-resources' chiude il file automaticamente
			file.append(rigaLog);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("Errore salvataggio su errorLog");
		}



	}

	public static void saveLogErrorStatic(String classeMetodo, String messaggio){
		LocalDateTime data=LocalDateTime.now();
		messaggio = messaggio.replace('\n', ' ').replace('\r', ' ');
		DateTimeFormatter formatter=DateTimeFormatter.ofPattern("dd/MM/yyyy hh:mm");
		String rigaLog="\n"+data.format(formatter)+" - "+ classeMetodo + " - "+ messaggio;
		File logDir = new File(System.getProperty("user.dir"));
		File logFile = new File(logDir, "error.log");

		try (FileWriter file = new FileWriter(logFile, true)) {
			file.append(rigaLog);
		} catch (IOException e) {
			System.err.println("Errore salvataggio su errorLog (Statico): " + e.getMessage());
		}



	}








}
