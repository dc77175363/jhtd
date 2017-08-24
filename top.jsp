<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="utf-8">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <script language="JavaScript" src="js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            //顶部导航切换
            $(".nav li a").click(function () {
                $(".nav li a.selected").removeClass("selected")
                $(this).addClass("selected");
            })
        })
    </script>
</head>
<body style="background:url(images/topbg.gif) repeat-x;">
<div class="topleft" style="height: 80px;">
    <a href="index.jsp" target="_parent"><img style="margin-top: 5px;" src="images/logo.png" title="君海游戏"/></a>
</div>
<div class="topright" style="height: 80px;">
    <div class="user" style="margin-top: 25px;">
        <span><%=session.getAttribute("user")%></span>
        <i style="margin-right: 10px;"><a href="logout.jsp" target="_parent">退出</a></i>
    </div>
</div>
</body>
</html>
