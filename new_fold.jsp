<%@ page contentType="text/event-stream;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<%@ page language="java" import="java.io.*,java.util.zip.*"%> 
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%

	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String name=request.getParameter("name");
	String type=request.getParameter("type");
	String project=request.getParameter("project");
				response.setContentType("text/event-stream"); //设置contentType
			response.setHeader("Cache-Control", "no-cache"); //设置不缓存
			response.setHeader("Pragma","no-cache");
			response.setDateHeader("Expires",0);
			PrintWriter pw = response.getWriter();
			
			String data="";
		sql="insert fold (project_id,father_id,name,type,new_time) values ('"+project+"','"+id+"','"+name+"','"+type+"',now())";
		try{
			stmt.executeUpdate(sql);
			pw.print("data:");
			pw.print("新增文件夹'"+name+"'成功");
		}catch(Exception e){
			pw.print(e.toString());
			}	
		
		pw.flush();



stmt.close();
conn.close();
%>