<%@ page contentType="text/html;charset=GB2312" %>
<%
session.removeAttribute("flag");
session.removeAttribute("name");
session.removeAttribute("user");
Cookie cookies1[]=request.getCookies();
if(cookies1!=null){
for(int l=0;l<cookies1.length;l++){
if(cookies1[l].getName().equals("user")){
	cookies1[l].setMaxAge(0);
	response.addCookie(cookies1[l]) ;
//out.println(cangku);
					}

				}
		}
%>
<html>
<head><title>退出成功页面</title>
</head>
<body>
<center>
<p>退出成功!</p>
<%
response.setHeader("Refresh","2;URL=index.jsp");	
%>
<a href="index.jsp" target="_parent">首页</a>
</center>
</body>
</html>
