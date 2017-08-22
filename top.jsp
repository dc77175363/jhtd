<%@ page contentType="text/html;charset=GB2312" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="GB2312">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <script language="JavaScript" src="js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            //椤堕儴瀵艰埅鍒囨崲
            $(".nav li a").click(function () {
                $(".nav li a.selected").removeClass("selected")
                $(this).addClass("selected");
            })
        })
    </script>
</head>
<body style="background:url(images/topbg.gif) repeat-x;">
<div class="topleft">
    <a href="index.jsp" target="_parent"><img src="images/logo.png" title="系统首页"/></a>
</div>
<div class="topright">
    <div class="user">
        <span><%=session.getAttribute("user")%></span>
        <i><a href="logout.jsp" target="_parent">退出</a></i>
    </div>
</div>
</body>
</html>
