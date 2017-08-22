<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
//String db_url1="jdbc:mysql://localhost:3306/dinner?useUnicode=true&characterEncoding=GBK";
String db_url1="jdbc:mysql://192.168.1.250:3306/jhtd?useUnicode=true&characterEncoding=utf-8";
String db_user1="root";
String db_password1="password";


Connection connc=DriverManager.getConnection(db_url1,db_user1,db_password1);
Statement	stmtc=connc.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
//Statement stmtc = connc.createStatement();
ResultSet rsc;
String sqlc;

%>
