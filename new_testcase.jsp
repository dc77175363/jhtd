<%@ page contentType="text/event-stream;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<%@ page language="java" import="java.io.*,java.util.zip.*"%> 
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%

	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String father_id=request.getParameter("father_id");
	String tc_id=request.getParameter("tc_id");
	String name=request.getParameter("name");
	String user=request.getParameter("user");
	String description=request.getParameter("description");
	String act=request.getParameter("act");
				response.setContentType("text/event-stream"); //设置contentType
			response.setHeader("Cache-Control", "no-cache"); //设置不缓存
			response.setHeader("Pragma","no-cache");
			response.setDateHeader("Expires",0);
			PrintWriter pw = response.getWriter();
			
			String data="";
			
			if(act.equals("new")){
				sql="insert testcase (father_id,tc_id,name,user,description,new_time) values ('"+father_id+"','"+tc_id+"','"+name+"','"+user+"','"+description+"',now())";
			}
			if(act.equals("update")){
				sql="update testcase set tc_id='"+tc_id+"',name='"+name+"',description='"+description+"',update_time=now(),user='"+user+"' where id='"+id+"'";
			}			
			if(act.equals("del")){
				sql="update testcase set x_state=0 where id='"+id+"'";
			}				
			//out.println(sql);
		try{
			stmt.executeUpdate(sql);
			pw.print("data:");
			pw.print("更新案例'"+name+"'成功");
		}catch(Exception e){
			pw.print(e.toString());
			}	
		
		pw.flush();



stmt.close();
conn.close();
%>