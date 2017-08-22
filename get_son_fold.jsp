<%@ page contentType="text/event-stream;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<%@ page language="java" import="java.io.*,java.util.zip.*"%> 
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%

	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String type=request.getParameter("type");
	String project=request.getParameter("project");
	//int floor=Integer.parseInt(request.getParameter("floor"));
	//floor=floor+1;
				response.setContentType("text/event-stream"); //设置contentType
			response.setHeader("Cache-Control", "no-cache"); //设置不缓存
			response.setHeader("Pragma","no-cache");
			response.setDateHeader("Expires",0);
			PrintWriter pw = response.getWriter();
			pw.print("data:");
			String data="";
		if(project==null){
			sql="select * from fold where father_id="+id+" and type='"+type+"' order by name";
		}else{
			sql="select * from fold where father_id="+id+" and type='"+type+"' and project_id='"+project+"' order by name";
		}
		rs=stmt.executeQuery(sql);
		while(rs.next()){
 			pw.print("<div class='treeNode'>");
			data="<span onclick='expandCollapse(this.parentNode);get_son_fold("+rs.getString("id")+",\""+type+"\")' class='category'><img src='images/close.jpg' onclick='expandCollapse(this.parentNode);get_son_fold("+rs.getString("id")+",\""+type+"\")' class='treeLinkImage'/>";
			pw.print(data);
			data=rs.getString("name")+"</span>";
			pw.print(data);
			data="<div class='treeSubnodesHidden' id='"+rs.getString("id")+"'>";
			pw.print(data);
			data="</div>";
			pw.print(data);
			pw.print(data);
			}
		pw.print(data);
		pw.flush();



stmt.close();
conn.close();
%>
                 
                     
