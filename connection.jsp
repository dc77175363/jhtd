<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
//String db_url="jdbc:mysql://localhost:3306/dinner?useUnicode=true&characterEncoding=GBK";
String db_url="jdbc:mysql://192.168.1.250:3306/jhtd?useUnicode=true&characterEncoding=utf-8";
String db_user="root";
String db_password="password";

Connection conn=DriverManager.getConnection(db_url,db_user,db_password);
Statement	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
//Statement stmt = conn.createStatement();
ResultSet rs;
String sql="";


%>
