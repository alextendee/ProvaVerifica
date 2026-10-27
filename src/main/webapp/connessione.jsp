<%@page import="java.sql.*" %>
<%@page import="esempio.FunzioniDB"%>
<%
    //il collegamento al database viene memorizzato in sessione per non riaprirlo ad ogni pagina
    FunzioniDB funzioni=(FunzioniDB)session.getAttribute("funzioni");
    if(funzioni==null){
                funzioni=new FunzioniDB("jdbc:mysql://localhost/appartamento","root","");
                session.setAttribute("funzioni", funzioni);
     }


%>
