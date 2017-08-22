<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<%@ page language="java" import="java.io.*,java.util.zip.*"%> 
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ include file="cksession.jsp" %>
<%

	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String type=request.getParameter("type");
	if(type==null){
		type="tc";
	}
	String user="";
	//project参数从cookie获取
	try{
	user=session.getAttribute("name").toString();
	}catch(Exception e){
	
	}	
	String project="";
	try{
	project=session.getAttribute("project").toString();
	}catch(Exception e){
	
	}	
	if(project.equals("")){
		project="1";
	}	
	String project_name="";
	sql="select * from project where id='"+project+"'";
		rs=stmt.executeQuery(sql);
		if(rs.next()){
			project_name=rs.getString("project");
		}
%>
<html>
	<head>
	<style type="text/css">

      /*主页面样式*/

      .leftNav {

        width: 80%;

        height:100%;

       // border:#B9E0F7 1px solid;

        margin-left: 0%;

        margin-right: 1%;

    }

      #footer {

      color:#808080;

      line-height: 1.6em;

      padding: 0 0 1em 0;

    }

    /*我的树样式表*/

    .treeDiv {

      color: #636363;

      font-size: 14px;

      font-weight: normal;

      background-color: #fff;

      color: black;

      overflow: auto;

      padding: 0 0 1em 0;

      overflow-x: hidden;

    }

    

    .treeNode {

      white-space: nowrap;

      text-indent: -14px;

      margin: 6px 2px 5px 14px;

    }

    

    a.treeUnselected:hover, a.treeSelected:hover {

      background-color: #BFD9ED;

      text-decoration: none;

    }

    

    a.treeUnselected, a.treeSelected {

      color: black;

      padding: 1px 3px 1px 0;

      text-decoration: none;

    }

    a.treeSelected {

      background-color: #B9E0F7;

    }

    a.treeUnselected {

      background-color: transparent;

    }

    

    .treeSubnodes {

      display: block;

    }

    .treeSubnodesHidden {

      display: none;

    }

    .treeNode img.treeNoLinkImage, .treeNode img.treeLinkImage {

      //height: 15px;

      margin-left: 0px;

      margin-right: 0px;

      width: 15px;

    }

    .treeNode img.treeLinkImage {

      cursor: pointer;

    }

    

    div.treeNode a, div.treeNode span.apiRoot {

      display: inline-block;

      margin-left: 24px;

      text-indent: 0;

      white-space: normal;

      width: 95%;

      word-wrap: break-word;

    }

    

    div.treeNode span.category {

      cursor: pointer;

    }
    div.treeNode a.category {

      cursor: pointer;

    }
  </style>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <!--<link href="css/style.css" rel="stylesheet" type="text/css"/>-->
    <script language="JavaScript" src="js/jquery-2.1.3.min.js"></script>
<script type="text/javascript">

var treeSelected = null;//选中的树节点

var imgPlus = new Image();

imgPlus.src="images/open.jpg";
imgPlus.src="images/close.jpg";

var imgMinus = new Image();

imgMinus.src="images/close.jpg";
imgMinus.src="images/open.jpg";
//父节点展开事件

function expandCollapse(el)

{

    //如果父节点有字节点（class 属性为treeSubnodesHidden），展开所有子节点

    if (el.className!= "treeNode"){

        return;    //判断父节点是否为一个树节点，如果树节点不能展开，请检查是否节点的class属性是否为treeNode

    }    

    var child;

    var imgEl;//图片子节点，在树展开时更换图片

    for(var i=0; i < el.childNodes.length; i++)

    {

        child = el.childNodes[i];

        if (child.src)

        {

            imgEl = child;

        }

        else if (child.className == "treeSubnodesHidden")

        {

            child.className = "treeSubnodes";//原来若隐藏，则展开

            imgEl.src = imgMinus.src;//更换图片

            break;

        }

        else if (child.className == "treeSubnodes")

        {

            child.className = "treeSubnodesHidden";//原来若展开，则隐藏

            imgEl.src = imgPlus.src;//更换图片

            break;

        }

    }

}

//子节点点击事件，设置选中节点的样式

function clickAnchor(el)

{

    selectNode(el.parentNode);

    el.blur();

}

function selectNode(el)

{

    if (treeSelected != null)

    {

        setSubNodeClass(treeSelected, 'A', 'treeUnselected');

    }

    setSubNodeClass(el, 'A', 'treeSelected');

    treeSelected = el;

}

function setSubNodeClass(el, nodeName, className)

{

    var child;

    for (var i=0; i < el.childNodes.length; i++)

    {

        child = el.childNodes[i];

        if (child.nodeName == nodeName)

        {

            child.className = className;

            break;

        }

    }

}

</script>		
		<script language="JavaScript">
		//window.onload=set_tc_id() 
		function set_tc_id(){
			
			var tc_id=getCookie("tc_id");
			if(tc_id==null){
				tc_id=0;
			}
			tc_id=parseInt(tc_id)+1
			//alert(tc_id)
				document.getElementById("tc_id").value=tc_id;
				//alert(document.getElementById("tc_id").value)
				document.getElementById("name").focus()
			
		}
		
		
		function setCookie(name,value)
		{
			var Days = 30;
			var exp = new Date();
			exp.setTime(exp.getTime() + Days*24*60*60*1000);
			document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
		}
		
		function getCookie(name)
		{
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
		if(arr=document.cookie.match(reg))
		return unescape(arr[2]);
		else
		return null;
		}
		
		
			function newfold(){
				var name = prompt("输入文件名", ""); //将输入的内容赋给变量 name ，  
  
        //这里需要注意的是，prompt有两个参数，前面是提示的话，后面是当对话框出来后，在对话框里的默认值  
	        if (name)//如果返回的有内容  
	        {  
						if(typeof(EventSource)!=="undefined"){ 
					  	var source=new EventSource("new_fold.jsp?name="+name+"&id=<%=id%>&type=<%=type%>&project=<%=project%>");							  	
				  			source.onopen=function(event)
									{
										//alert('11g');
									//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};

								source.onmessage=function(event)
								  {
								  	//alert(event.data);
								  //document.getElementById(x).innerHTML=event.data;
								  document.body.innerHTML+=event.data;
								  source.close();
								  }
				  			source.onerror=function(event)
									{
										//alert("新增文件夹失败");
										//document.getElementById(x).innerHTML=event.data;
										//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};		  	
				  	
					  }else{
					  	alert("浏览器不支持事件");
					  	}
        	} 
				
				}
			function newtestcase(){
				//var name = prompt("输入文件名", ""); //将输入的内容赋给变量 name ，  
  				var name=document.getElementById("name").value
  				var tc_id=document.getElementById("tc_id").value
  				var description=document.getElementById("description").value
  				
        //这里需要注意的是，prompt有两个参数，前面是提示的话，后面是当对话框出来后，在对话框里的默认值  
	        if (name!=='')//如果不为空  
	        {  
						if(typeof(EventSource)!=="undefined"){ 
					  	var source=new EventSource("new_testcase.jsp?name="+name+"&tc_id="+tc_id+"&father_id=<%=id%>&act=new&user=<%=user%>&description="+description);							  	
				  			source.onopen=function(event)
									{
										//alert('11g');
									//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};

								source.onmessage=function(event)
								  {
								  	//alert(event.data);
								  //document.getElementById(x).innerHTML=event.data;
								  document.body.innerHTML+=event.data;
								  source.close();
								  setCookie("tc_id",tc_id);
								   location.replace(location)
								   //location.reload()//刷新当前页面
								   //document.execCommand('Refresh')
								  //document.getElementById("<%=id%>newtc").style.display="none"
								  }
				  			source.onerror=function(event)
									{
										//alert("新增文件夹失败");
										//document.getElementById(x).innerHTML=event.data;
										//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};		  	
				  	
					  }else{
					  	alert("浏览器不支持事件");
					  	}
        	} 
				
				}			

		function updatetestrun(x,st){
				//var name = prompt("输入文件名", ""); //将输入的内容赋给变量 name ，  
  				var description=document.getElementById("trdescription"+x).value
  				if(description=="null"){
  						description="";
  				}
  				var act="update"
  				if(st=="del"){
  					act="del";
  				}
  				  				
        //这里需要注意的是，prompt有两个参数，前面是提示的话，后面是当对话框出来后，在对话框里的默认值  
	        if (name!=='')//如果不为空  
	        {  
						if(typeof(EventSource)!=="undefined"){ 
					  	var source=new EventSource("new_testrun.jsp?id="+x+"&state="+st+"&description="+description+"&act="+act+"&user=<%=user%>");							  	
				  			source.onopen=function(event)
									{
										//alert('11g');
									//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};

								source.onmessage=function(event)
								  {
								  	//alert(event.data);
								  //document.getElementById(x).innerHTML=event.data;
								  document.body.innerHTML+=event.data;
								  source.close();
								  if(st=="del"){
								  	location.replace(location)
								  }
								  if(st!=="" && st!=="del"){
								  	document.getElementById("state"+x).innerHTML=st;
								  }
								  document.getElementById("trdescription"+x).value=description;
								   //location.replace(location)
								   //location.reload()//刷新当前页面
								   //document.execCommand('Refresh')
								  //document.getElementById("<%=id%>newtc").style.display="none"
								  }
				  			source.onerror=function(event)
									{
										//alert("新增文件夹失败");
										//document.getElementById(x).innerHTML=event.data;
										//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};		  	
				  	
					  }else{
					  	alert("浏览器不支持事件");
					  	}
        	} 
				
				}			
		
		function newtestrun(){
				//var name = prompt("输入文件名", ""); //将输入的内容赋给变量 name ，  
  				var tc_fold_id=document.getElementById("tc_fold_id").value  				
        //这里需要注意的是，prompt有两个参数，前面是提示的话，后面是当对话框出来后，在对话框里的默认值  
	        if (tc_fold_id!=='')//如果不为空  
	        {  
						if(typeof(EventSource)!=="undefined"){ 
					  	var source=new EventSource("new_testrun.jsp?tc_fold_id="+tc_fold_id+"&father_id=<%=id%>&act=new&user=<%=user%>");							  	
				  			source.onopen=function(event)
									{
										//alert('11g');
									//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};

								source.onmessage=function(event)
								  {
								  	//alert(event.data);
								  //document.getElementById(x).innerHTML=event.data;
								  document.body.innerHTML+=event.data;
								  source.close();
								   location.replace(location)
								   //location.reload()//刷新当前页面
								   //document.execCommand('Refresh')
								  //document.getElementById("<%=id%>newtc").style.display="none"
								  }
				  			source.onerror=function(event)
									{
										//alert("新增文件夹失败");
										//document.getElementById(x).innerHTML=event.data;
										//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};		  	
				  	
					  	}else{
					  		alert("浏览器不支持事件");
					  	}
        	} 
				
				}			

			function updatetestcase(id,act){
				//alert(id)
				//var name = prompt("输入文件名", ""); //将输入的内容赋给变量 name ，  
  				var name=document.getElementById("name"+id).value
  				var tc_id=document.getElementById("tc_id"+id).value
  				var description=document.getElementById("description"+id).value
  				if(!act){
  					act="update"
  				}
  				
        //这里需要注意的是，prompt有两个参数，前面是提示的话，后面是当对话框出来后，在对话框里的默认值  
	        if (name!=='')//如果不为空  
	        {  
						if(typeof(EventSource)!=="undefined"){ 
					  	var source=new EventSource("new_testcase.jsp?name="+name+"&id="+id+"&tc_id="+tc_id+"&father_id=<%=id%>&act="+act+"&user=<%=user%>&description="+description);							  	
				  			source.onopen=function(event)
									{
										//alert('11g');
									//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};
								source.onmessage=function(event)
								  {
								  	//alert(event.data);
								  //document.getElementById(x).innerHTML=event.data;
								  //document.body.innerHTML+=event.data;
								  source.close();
								   location.replace(location)
								   //location.reload()//刷新当前页面
								   //document.execCommand('Refresh')
								  //document.getElementById("<%=id%>newtc").style.display="none"
								  }
				  			source.onerror=function(event)
									{
										//alert("新增文件夹失败");
										//document.getElementById(x).innerHTML=event.data;
										//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};		  	
				  	
					  }else{
					  	alert("浏览器不支持事件");
					  	}
        	} 
				
				}		

				function selectfoldstart(){
					document.getElementById("<%=id%>newtr").style.display="";

						document.getElementById("foldlisttr").style.display="none"	
						document.getElementById("foldlisttc").style.display=""		
					
					document.getElementById("dowith").innerHTML="添加";
					document.getElementById("dowith").onclick=newtestrun;
				}

				function movefoldstart(){
					document.getElementById("<%=id%>newtr").style.display="";
					if("<%=type%>"=="tc"){
						//alert("tc")
							document.getElementById("foldlisttr").style.display="none"			
					}else{
						//alert("tr")
						document.getElementById("foldlisttc").style.display="none"		
					}
					document.getElementById("dowith").innerHTML="移动到";
					document.getElementById("dowith").onclick=movefold;
				}
				function movefold(){
					alert("movefold")
					var tc_fold_id=document.getElementById("tc_fold_id").value
					updatefold(tc_fold_id)
				}
				
				
				function updatefold(new_father_id){

  				var name=document.getElementById("fold_name").value
  				
        //这里需要注意的是，prompt有两个参数，前面是提示的话，后面是当对话框出来后，在对话框里的默认值  
	        if (name!=='')//如果不为空  
	        {  
						if(typeof(EventSource)!=="undefined"){ 
							var source
							if(new_father_id){
								source=new EventSource("update_fold.jsp?father_id="+new_father_id+"&id=<%=id%>");	
							}else{
					  		source=new EventSource("update_fold.jsp?name="+name+"&id=<%=id%>");	
					  	}						  	
				  			source.onopen=function(event)
									{
										//alert('11g');
									//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};

								source.onmessage=function(event)
								  {
								  	//alert(event.data);
								  //document.getElementById(x).innerHTML=event.data;
								  //document.body.innerHTML+=event.data;
								  source.close();
								   location.replace(location)
								   //location.reload()//刷新当前页面
								   //document.execCommand('Refresh')
								  //document.getElementById("<%=id%>newtc").style.display="none"
								  }
				  			source.onerror=function(event)
									{
										//alert("新增文件夹失败");
										//document.getElementById(x).innerHTML=event.data;
										//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};		  	
				  	
					  }else{
					  	alert("浏览器不支持事件");
					  	}
        	} 
				
				}	

			function get_son_fold(x,ty)
				  {
				  	//rightframe(x,ty)
				  	gettcfold(x)
				  	if(typeof(EventSource)!=="undefined"){ 
					  	var source=new EventSource("get_son_fold.jsp?id="+x+"&project=<%=project%>&type="+ty);							  	
				  			source.onopen=function(event)
									{
										//alert('11g');
									//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};
								source.onmessage=function(event)
								  {
								  	if(ty=='tr' && x==0){
								  		document.getElementById(ty+x).innerHTML=event.data;
								  	}else{
								  		document.getElementById(x).innerHTML=event.data;
								  }
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
				function gettcfold(x){
					document.getElementById("tc_fold_id").value=x
					a=document.getElementById(x)
					var previousnode = a.previousElementSibling;
					var b=previousnode.innerHTML;
					b=b.substr(b.indexOf(">")+1);
					document.getElementById("tc_fold_name").value=b
				}
				
				

			</script>

		</head>
	<body>
		<%
		String location="测试用例";
		if(type.equals("tr")){
			location="执行记录";
		}
		if(id.equals("0")){
			sql="select * from fold where id='"+id+"'";
		}else{
			sql="select * from fold where id='"+id+"' and project_id='"+project+"'";
		}
		rs=stmt.executeQuery(sql);
		if(rs.next()){
		%>
		
		<div>当前位置:<%=project_name%>><%=location%>><input type="text" id="fold_name" value="<%=rs.getString("name")%>" onchange="updatefold()"/></div>
		<%}%>
		<table border=1>
			<tr>
				<td><a onclick='newfold()'>新增文件夹</a></td>
				<!--tc可以新增测试案例-->
				<%if(type.equals("tc")){%>
				
				<td><a onClick='document.getElementById("<%=id%>newtc").style.display="";set_tc_id()'>新增用例</a>
					<script language="javascript">   
							document.body.onkeypress = function(e){
							
							var e = e||event;              //判断兼容
							//alert(e.keyCode)
							if(e.keyCode==45){        //判断按钮							       
										//newtestcase()
										document.getElementById("<%=id%>newtc").style.display="";
										set_tc_id()
							}
							} 
					 </script>
					<div id="<%=id%>newtc" style="display: none;width:400px; height:250px; border:0px solid black;position:fixed;top:20%;left:10%;background-color:#FFFFFF;" >
					<table border=1>
						<tr>
							<td>用例ID</td>
							<td><input type="text" id="tc_id" value=""/></td>
						</tr>		
						<tr>
							<td>用例名称</td>
							<td><input type="text" id="name" value="" /></td>
						</tr>	
						<tr>
							<td>描述or预期</td>
							<td><textarea id="description" cols=30 rows=5></textarea></td>
						</tr>
						<tr>
							<td colspan="2"  align="center"><a onclick='newtestcase()'>提交</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a onClick='document.getElementById("<%=id%>newtc").style.display="none"'>取消</a></td>
						</tr>
					</table>
					 <script language="javascript">   
							document.getElementById("<%=id%>newtc").onkeypress = function(e){
							
							var e = e||event;              //判断兼容
							
							if(e.keyCode==13){        //判断按钮							       
										newtestcase()
							}
							} 
					 </script>
					</div>
					</td>
					<%}%>
			<!--tr可以新增测试集合-->
				<%if(type.equals("tr")){%>
				<td><a onClick='selectfoldstart()'>选择执行案例</a>
				<%}%>
					<div id="<%=id%>newtr" style="display: none;width:400px; height:100%; border:1px solid black;position:fixed;top:1%;left:60%;background-color:#FFFFFF;overflow:auto" >
							<div><input type="text" id="tc_fold_id" value="" size=8/><input type="text" id="tc_fold_name" value="" size=10/><a onclick='newtestrun()' id="dowith">添加</a></div>
							<div class="leftNav">
							
							    <div id="samplesToc">
							
							        <div id="tree" style="top: 35px; left: 0px;" class="treeDiv">
							
							          <div id="treeRoot" onselectstart="return false" ondragstart="return false">
							
							            <div class="treeNode" id="foldlisttc">
							              <span onclick="expandCollapse(this.parentNode);get_son_fold(0,'tc')" class="category" ><img src="images/close.jpg" onclick="expandCollapse(this.parentNode);get_son_fold(0,'tc')" class="treeLinkImage" />测试用例</span>
						
							              <div class="treeSubnodesHidden" id='0'>						
							
							              </div>
							
							            </div>
			            <div class="treeNode" id="foldlisttr">			
			            <span onclick="expandCollapse(this.parentNode);get_son_fold(0,'tr')" class="category"> <img src="images/close.jpg" onclick="expandCollapse(this.parentNode);get_son_fold(0,'tr')" class="treeLinkImage">
						              测试执行</span>			
			              <div class="treeSubnodesHidden" id='tr0'>
			              </div> 
			              </div>   
					</td>
					
				<td><a onclick='location.replace(location)'>刷新</a></td>
				<td><a onClick='movefoldstart()'>移动到</a></td>
			</tr>
			
			</table>
			<%if(type.equals("tc")){%>
			<table border=1>
						<tr>
							<td>序号</td>
							<td>tc_id</td>
							<td>案例名称</td>
							<td>案例描述or预期结果</td>
							<td>用户</td>
							<td>操作</td>
							<td>创建时间</td>
							<td>更新时间</td>
						</tr>				
			<%
				int xuhao=0;
        	sql="select * from testcase where father_id='"+id+"' and x_state=1 order by tc_id,id";
					//out.println(sql);
					rs=stmt.executeQuery(sql);
				while(rs.next()){
				xuhao=xuhao+1;
        %>
						<tr>
							<td><%=xuhao%></td>
							<td><input type="text" id="tc_id<%=rs.getString("id")%>" value="<%=rs.getString("tc_id")%>" onchange="updatetestcase(<%=rs.getString("id")%>)"/></td>
							<td><input type="text" id="name<%=rs.getString("id")%>" value="<%=rs.getString("name")%>" onchange="updatetestcase(<%=rs.getString("id")%>)"/></td>
							<td>
								<textarea id="description<%=rs.getString("id")%>" onchange="updatetestcase(<%=rs.getString("id")%>)" cols=40 rows=3><%=rs.getString("description")%></textarea>
								
							
							<td><%=rs.getString("user")%></td>
							<td><font color="red"><a onclick="updatetestcase(<%=rs.getString("id")%>,'del')">删除</a></font></td>	
							<td><%=rs.getString("new_time")%></td>
							<td><%=rs.getString("update_time")%></td>
						</tr>
						<%}%>			
				
			</table>
			<%}%>
	
	<%if(type.equals("tr")){%>
			<table border=1>
						<tr>
							<td>序号</td>
							<td>tc_id</td>
							<td>案例名称</td>
							<td>执行状态</td>	
							<td>执行</td>
						<td>备注</td>
							<td width="10%">案例描述or预期结果</td>
							<td>用户</td>
							<td>操作</td>

							<td width="10%">更新时间</td>
						</tr>				
			<%
				int xuhao=0;
        	sql="select r.*,c.tc_id as tc_id1,c.name,c.description as description1 from testrun r,testcase c where r.father_id='"+id+"' and r.tc_id=c.id and r.x_state=1 and c.x_state=1 order by c.tc_id,r.id";
					//out.println(sql);
					rs=stmt.executeQuery(sql);
				while(rs.next()){
				xuhao=xuhao+1;	
				%>
										<tr>
							<td><%=xuhao%></td>
							<td><%=rs.getString("tc_id1")%></td>
							<td><%=rs.getString("name")%></td>
							<td id="state<%=rs.getString("id")%>"><%=rs.getString("state")%></td>
							<td>
							<a onclick="updatetestrun(<%=rs.getString("id")%>,'成功')">成功</a><br>
							<a onclick="updatetestrun(<%=rs.getString("id")%>,'失败')">失败</a><br>
							<a onclick="updatetestrun(<%=rs.getString("id")%>,'NA')">NA</a><br>
							</td>
							<td><input type="text" onchange="updatetestrun(<%=rs.getString("id")%>,'')" id="trdescription<%=rs.getString("id")%>" value="<%=rs.getString("description")%>"/>
							
							<td><font size=1px><%=rs.getString("description1")%></font></td>	
							<td><%=rs.getString("user")%></td>				
							<td><font color="red"><a onclick="updatetestrun(<%=rs.getString("id")%>,'del')">删除</a></font></td>				
							<td><%=rs.getString("update_time")%></td>
						</tr>			
			
								<%}%>
			</table>
			<%}%>
				温馨提示：<br>
				1.在当前页面按Insert键，直接调起新增测试案例<br>
				2.在案例编写界面，直接按Enter，直接提交新增。
			
	</body>
</html> 

<%
stmt.close();
conn.close();
%>