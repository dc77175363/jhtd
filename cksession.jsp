
<%@ include file="cookie.jsp" %>
<%
if(session.getAttribute("user")==null || session.getAttribute("name")==null){
out.println("session timeout,please refresh");
session.setAttribute("flag",null);
out.println("<a href=index.jsp target='_parent'>OK</a>");
return;
}
%>
