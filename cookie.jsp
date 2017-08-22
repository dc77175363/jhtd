
<%@ include file="connectionc.jsp" %>
<%
String user1="";
Cookie cookies1[]=request.getCookies();
if(cookies1!=null){
for(int i=0;i<cookies1.length;i++){
if(cookies1[i].getName().equals("user")){
	user1=cookies1[i].getValue();
		sqlc="select * from user where user='"+user1+"'";
//out.println(sqlc);
rsc=stmtc.executeQuery(sqlc);
if(rsc.next()){
	session.setAttribute("user",user1);
	session.setAttribute("name",rsc.getString("name"));
	session.setAttribute("flag","ok");
//out.println(user);
						}
					}else
					{
					//out.println("no  equals user cookie");
					}
				}
		}else
		{
		//out.println("no  any cookie");
		}
		
		
stmtc.close();
connc.close();

		%>