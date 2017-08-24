<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<%@ include file="cksession.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	//获取参数user、project参数
	String user="";	
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
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<style type="text/css">

      /*菜单栏样式*/

      .leftNav {

        width: 100%;

        /*height:500px;*/
        height:100%;

        border:#B9E0F7 1px solid;

        margin-left: 0%;

        margin-right: 1%;
		box-sizing: border-box;
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

      /*white-space: nowrap;*/

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

     // width: 15px;

    }

    .treeNode img.treeLinkImage {

      cursor: pointer;

    }

    

    div.treeNode a, div.treeNode span.apiRoot {

      display: inline-block;

      //margin-left: 24px;

      text-indent: 0;

      white-space: normal;

      width: 95%;

      word-wrap: break-word;

    }

    

    div.treeNode span.category {
			//padding:0px 10px 10px 0px;
      cursor: pointer;

    }
    div.treeNode a.category {

      cursor: pointer;

    }
    .category:hover{
    	background-color: #eee;
    }
  </style>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
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

        if (child.className=="category")

        {

            imgEl = child.children[0];

        }

        if (child.className == "treeSubnodesHidden")

        {
            child.className = "treeSubnodes";//原来若隐藏，则展开

            imgEl.src = imgMinus.src;//更换图片
            break;

        }

        if (child.className == "treeSubnodes")

        {

            child.className = "treeSubnodesHidden";//原来若展开，则隐藏

            imgEl.src = imgPlus.src;//更换图片
            //event.stopPropagation(); //阻止事件冒泡  

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
     <script language="javascript">     	   
     	
     	
				 function change(y,a)
				  {
						x=document.getElementById(y);
				    if(x.style.display=="none")  //展开树形的子节点
				     {
				     	//alert("11");
				     	rightframe(y)
				     	get_son_fold(y,a);  
				       x.style.display="";   
				       x.style.position=relative;
				       x.style.left ="1000px";
				       //x.styple.left=offsetLeft
				     }
				     else if(x.style.display=="") //收缩树形的子节点
				      {
				       x.style.display="none";    
				      } 
				  }
				  function get_son_fold(x,ty)
				  {
				  	rightframe(x,ty)
				  	if(typeof(EventSource)!=="undefined"){ 
					  	var source=new EventSource("get_son_fold.jsp?id="+x+"&project=<%=project%>&type="+ty);							  	
				  			source.onopen=function(event)
									{
										//alert('11g');
									//document.getElementById(x).innerHTML+="error<br />";//不论是用JSP还是SPRING做后台，都会每次调到这个方法。包括W3SHOOL的例子，我加上ONERROR事件后都会每次必调到。
									};

								source.onmessage=function(event)
								  {
								  	//alert(event.data);
								  	if(ty=='tr' && x==0){
								  		document.getElementById(ty+x).innerHTML=event.data;
								  	}else{
								  		document.getElementById(x).innerHTML=event.data;
								  	}
								  	document.getElementById(x).class="treeNode";
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
				  function rightframe(x,ty){
				  	//alert("rightframe")
				  	if(!ty){
				  		ty="tc";
				  	}
				  	window.parent.rightFrame.location.href="list.jsp?id="+x+"&type="+ty;
				  	
				  	}
  
</script>    

    
    
</head>
<body style="background:#f0f9fd;min-width: auto;width: 187px;">

<div class="leftNav">

    <div id="samplesToc">

        <div id="tree" style="top: 35px; left: 0px;" class="treeDiv">

          <div id="treeRoot" onselectstart="return false" ondragstart="return false">

            <div class="treeNode">
            <span onclick="expandCollapse(this.parentNode);get_son_fold(0,'tc')" class="category">
              <img src="images/close.jpg" onclick="expandCollapse(this.parentNode);get_son_fold(0,'tc')" class="treeLinkImage"/>
              测试用例</span>
             <!-- <span onclick="expandCollapse(this.parentNode)" class="category">测试用例</span>-->

              <div class="treeSubnodesHidden" id='0'>


              </div>

            </div>

            <!--end block-->

            <div class="treeNode">

            <span onclick="expandCollapse(this.parentNode);get_son_fold(0,'tr')" class="category"> <img src="images/close.jpg" onclick="expandCollapse(this.parentNode);get_son_fold(0,'tr')" class="treeLinkImage">

              测试执行</span>

              <div class="treeSubnodesHidden" id='tr0'>



              </div>             


            </div>

            <!--end block-->

          </div>

        </div>

    </div> <!-- end samplesToc -->

</div> <!-- end leftNav -->





</body>
</html>
