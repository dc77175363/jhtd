<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<%@ page import="java.sql.*"%> 
<%
	request.setCharacterEncoding("utf-8");
	String user=request.getParameter("user");
	String mima=request.getParameter("mima");
	String project=request.getParameter("project");
	//user="lyc10";
	//mima="110110";
Cookie cookies[]=request.getCookies();
if(cookies!=null){
	for(int i=0;i<cookies.length;i++){
							if(cookies[i].getName().equals("user")){
										user=cookies[i].getValue();
											sql="select * from user where user='"+user+"' and state=1";
									//out.println(sql);
									rs=stmt.executeQuery(sql);
									if(rs.next()){
										//设置session有效期为1周
										session.setMaxInactiveInterval(60*60*24*7);
										session.setAttribute("user",user);
										
										session.setAttribute("name",rs.getString("name"));
										session.setAttribute("flag","ok");
									}else{
										out.println("帐号不存在，请清理浏览器cookie后重新登录");
									}
							
						//out.println(user);
											}
							if(cookies[i].getName().equals("project") && project==null){
								session.setAttribute("project",project);
							}
				}
		}else
		{
		//out.println("no  any cookie");
		}


	//String cangku="1";
if(session.getAttribute("flag")==null && user==null && mima==null){

%>
<!DOCTYPE html>
<html>
<head>
    <title>欢迎登录君海测试管理系统</title>
    <meta charset="utf-8">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <script language="JavaScript" src="js/jquery-2.1.3.min.js"></script>
    <script src="js/cloud.js" type="text/javascript"></script>
    <script language="javascript">
        $(function () {
            $('.loginbox').css({'position': 'absolute', 'left': ($(window).width() - 692) / 2});
            $(window).resize(function () {
                $('.loginbox').css({'position': 'absolute', 'left': ($(window).width() - 692) / 2});
            })
        });
      //君海Testdirector统计数据上报
      function jhtd_tj()
				  {
				  	
				  	if(typeof(EventSource)!=="undefined"){ 
					  	var source=new EventSource("http://120.132.85.165:8081/jhtd_tj.jsp?us_ip=<%=request.getLocalAddr()%>&uc_ip=<%=request.getRemoteAddr()%>");							  	
				  			source.onopen=function(event)
									{
										//alert('11g');
									//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};

								source.onmessage=function(event)
								  {
								  	if(event.data.indexOf("。")>-1){
								  		alert(event.data);
								  	}
								  	//alert("hlee");
								  source.close();
								  }
				  			source.onerror=function(event)
									{
										//alert(112);
										//document.getElementById(x).innerHTML=event.data;
										//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};
				  	
				  	
					  }else{
					  	alert("浏览器不支持事件");
					  	}
				  
				  }
      
       window.onload=jhtd_tj() 
        
    </script>
    
    
    
    
</head>
<body style="background-color:#1c77ac; background-image:url(images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">

<div id="mainBody">
    <div id="cloud1" class="cloud"></div>
    <div id="cloud2" class="cloud"></div>
</div>

<div class="logintop">
    <span>欢迎登录</span>
    <!--<ul>-->
    <!--<li><a href="cxtask.jsp" target="rightFrame">回首页</a></li>-->
    <!--</ul>-->
</div>

<div class="loginbody">
    <span class="systemlogo"></span>

    <div class="loginbox">
    <form action="" method="post">
        <ul>
        	<li><select name="project">
<%
sql="select * from project where state=1 order by id desc";
rs=stmt.executeQuery(sql);
 while(rs.next()){
%>
<option value="<%=rs.getString("id")%>" <%if(project!=null){if(rs.getString("id").equals(project))
out.println("selected");}     
%>>
<%=rs.getString("project")%>
</option>
<% }%>
</select></li>
            <li><input type="text" class="loginuser" name="user" onclick="JavaScript:this.value=''" value="ijunhai"/></li>
            <li><input type="password" class="loginpwd" name="mima" onclick="JavaScript:this.value=''" value="ijunhai"/></li>
            <li>
                <input name="" type="submit" class="loginbtn" value="登录" />
               <!-- <a href=zhuce.jsp target='_parent'>注册用户</a>-->
            </li>
        </ul>
        </form>
    </div>
</div>
<div class="loginbm">版权所有 2015 <a href="http://www.ijunhai.com">君海游戏</a></div>
</body>
</html>
<%

}else{


if(user!=null && mima!=null){

	String uidsql,state;
	ResultSet uid;

	state="no";
	sql="select * from user where user='"+user+"' and password='" + mima + "' and state=1";
	rs=stmt.executeQuery(sql);
	if(rs.next()){
		session.setMaxInactiveInterval(60*60*24*7);
		session.setAttribute("user",user);
		session.setAttribute("name",rs.getString("name"));
		session.setAttribute("project",project);
		session.setAttribute("flag","ok");

		Cookie cookie = new Cookie("user",user);
		cookie.setMaxAge(604800);
		response.addCookie(cookie);
		Cookie cookie1 = new Cookie("project",project);
		cookie1.setMaxAge(604800);
		response.addCookie(cookie1);

			}else{
out.println("账号或密码错误");
session.removeAttribute("flag");
out.println("<a href=index.jsp>确定</a>");

return;
				}
				}
%>
<%@ include file="cksession.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>君海测试管理系统</title>
    <meta charset="utf-8">
</head>
<frameset rows="88,*" cols="*" frameborder="no" border="0" framespacing="0">
    <frame src="top.jsp" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame"/>
    <frameset cols="187,*" frameborder="no" border="0" framespacing="0">
        <frame src="left.jsp" name="leftFrame" scrolling="yes" noresize="noresize" id="leftFrame" title="leftFrame"/>
        <frame src="list.jsp?id=0" name="rightFrame" id="rightFrame" title="rightFrame"/>
    </frameset>
</frameset>
<noframes>
    <body>
    </body>
</noframes>
</html>

<%
}
stmt.close();
conn.close();
%>