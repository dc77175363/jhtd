<%@ page contentType="text/event-stream;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<%@ page language="java" import="java.io.*,java.util.zip.*"%> 
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%

	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String father_id=request.getParameter("father_id");
	String tc_fold_id=request.getParameter("tc_fold_id");
	String tc_id=request.getParameter("tc_id");
	String name=request.getParameter("name");
	String user=request.getParameter("user");
	String description=request.getParameter("description");
	String act=request.getParameter("act");
	String state=request.getParameter("state");
				response.setContentType("text/event-stream"); //设置contentType
			response.setHeader("Cache-Control", "no-cache"); //设置不缓存
			response.setHeader("Pragma","no-cache");
			response.setDateHeader("Expires",0);
			PrintWriter pw = response.getWriter();
			
			String data="";
			
			if(act.equals("new")){			
				//把当前目录的案例加入到测试执行
				sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+tc_fold_id+"')";
			}
			if(act.equals("update")){
				if(state.equals("")){
					sql="update testrun set description='"+description+"',update_time=now(),user='"+user+"' where id='"+id+"'";
				}else{
					sql="update testrun set state='"+state+"',description='"+description+"',update_time=now(),user='"+user+"' where id='"+id+"'";
				}
			}			
			if(act.equals("del")){
				sql="update testrun set x_state=0 where id='"+id+"'";
			}			
			out.println(sql);
			
		try{
			stmt.executeUpdate(sql);
			if(act.equals("new")){
				//处理到5层子目录的案例
				//定义好操作数据库需要的数据库组件
				Statement	stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				Statement	stmt2=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				Statement	stmt3=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				Statement	stmt4=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				Statement	stmt5=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				Statement	stmt6=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				Statement	stmt7=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				Statement	stmt8=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				Statement	stmt9=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				Statement	stmt10=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs1,rs2,rs3,rs4,rs5,rs6,rs7,rs8,rs9,rs10;
				
				sql="select id from fold where father_id='"+tc_fold_id+"'";

					rs1=stmt1.executeQuery(sql);				
					while(rs1.next()){
						//当前子目录的案例加入到测试执行
						sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+rs1.getString("id")+"')";
						stmt.executeUpdate(sql);
						sql="select id from fold where father_id='"+rs1.getString("id")+"'";
						rs2=stmt2.executeQuery(sql);				
						while(rs2.next()){
							sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+rs2.getString("id")+"')";
							stmt.executeUpdate(sql);
							sql="select id from fold where father_id='"+rs2.getString("id")+"'";						
							rs3=stmt3.executeQuery(sql);				
							while(rs3.next()){
								sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+rs3.getString("id")+"')";
								stmt.executeUpdate(sql);
								sql="select id from fold where father_id='"+rs3.getString("id")+"'";						
								rs4=stmt4.executeQuery(sql);				
								while(rs4.next()){
									sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+rs4.getString("id")+"')";
									stmt.executeUpdate(sql);
									sql="select id from fold where father_id='"+rs4.getString("id")+"'";						
									rs5=stmt5.executeQuery(sql);				
									while(rs5.next()){
										sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+rs5.getString("id")+"')";
										stmt.executeUpdate(sql);									
										sql="select id from fold where father_id='"+rs5.getString("id")+"'";						
										rs6=stmt6.executeQuery(sql);				
										while(rs6.next()){
											sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+rs6.getString("id")+"')";
											stmt.executeUpdate(sql);									
											sql="select id from fold where father_id='"+rs6.getString("id")+"'";						
											rs7=stmt7.executeQuery(sql);				
											while(rs7.next()){
												sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+rs7.getString("id")+"')";
												stmt.executeUpdate(sql);									
												sql="select id from fold where father_id='"+rs7.getString("id")+"'";						
												rs8=stmt8.executeQuery(sql);				
												while(rs8.next()){
													sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+rs8.getString("id")+"')";
													stmt.executeUpdate(sql);									
													sql="select id from fold where father_id='"+rs8.getString("id")+"'";						
													rs9=stmt9.executeQuery(sql);				
													while(rs9.next()){
														sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+rs9.getString("id")+"')";
														stmt.executeUpdate(sql);									
														sql="select id from fold where father_id='"+rs9.getString("id")+"'";						
														rs10=stmt10.executeQuery(sql);				
														while(rs10.next()){
															sql="insert testrun (father_id,tc_id,user,new_time,description) (select '"+father_id+"' as father_id,id,'"+user+"' as user,now() as new_time,'' as description from testcase where father_id='"+rs10.getString("id")+"')";
															stmt.executeUpdate(sql);
															}
													}
												}
											}
										}
									}	
								}							
							}
						}
					}
				stmt1.close();
				stmt2.close();
				stmt3.close();
				stmt4.close();
				stmt5.close();
				stmt6.close();
				stmt7.close();
				stmt8.close();
				stmt9.close();
				stmt10.close();
			}			
			pw.print("data:");
			pw.print("更新案例'"+name+"'成功");
		}catch(Exception e){
			pw.print(e.toString());
			}	
		
		pw.flush();



stmt.close();
conn.close();
%>