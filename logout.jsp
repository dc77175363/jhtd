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
<head><title>�˳��ɹ�ҳ��</title>
</head>
<body>
<center>
<p>�˳��ɹ�!</p>
<%
response.setHeader("Refresh","2;URL=index.jsp");	
%>
<a href="index.jsp" target="_parent">��ҳ</a>
</center>
</body>
</html>
