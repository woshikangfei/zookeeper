<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="lib/jquery.js" type="text/javascript"></script>
<title>Insert title here</title>
<style type="text/css">
        .marsking
        {
          top:0;
          left:0;
          width:100%;
          height:100%;
          overflow:hidden;
          z-index:9999;
          background:#000000;
          opacity:0.5;
          filter: alpha(opacity=50);
          -moz-opacity:0.5;
          position:fixed;
        }
        .timespan
        {
          position:fixed;
          left:40%;
          top:45%;
          border:1px solid green;
          width:30%;
          text-align:center;  
          vertical-align:middle; 
          color:#fff;
          background-color:green;
          padding:20px;
          z-index:10000;
          border-radius:10px;
          -webkit-border-radius:10px;
        }
        .timespan span
        {
          color:#fff;
          font-size:20px;
          font-weight:bold;
          padding:0 5 0 5;   
        }
    </style>
    
    
<script type="text/javascript">

$(document).ready(function () {
	$(".time").html(0);
    $(".marsking").hide();
});

var ExecuteSpan = null;
function CalculateExecuteTime() {
ExecuteSpan = setInterval(function () {
  $(".time").html(parseInt($(".time").html()) + 1);
}, 1000);
}       



function tijiao(){
	$(".marsking").fadeIn();
    CalculateExecuteTime();
	return true;
}
</script>
</head>
<body>
<div class="marsking">
        <div class="timespan">
            Please waiting，zookeeper connecting.....(<span class="time">0</span>)
        </div>
    </div>
    <script type="text/javascript" language="javascript">
        
    </script>
<div class="TopBgLogo" style="display:none;">
</div>
<h1 style="text-align: center;">ZooKeeper Manager Plus</h1>


<div style="padding-left: 25%;padding-top: 25%;">
<form action="login.action" method="post" onsubmit="return tijiao()">
username:<input type="text" name="username"><br>
password:<input type="password" name="password"><br>
Connect String:<input type="text" name="connect" value="localhost:2181"><br>
Session Timeout:<input type="text" name="timeout" value="5000"><br>
<input type="submit" value="login" />
<%
int type=0;
if(request.getParameter("type")!=null)
	type = Integer.parseInt(request.getParameter("type"));

if(type==2){
	%>
	<div style="font-size: 25px;background-color: red;">zookeeper connect fail</div>
	<%
}else if(type==1){
	%>
	<div style="font-size: 25px;background-color: red;">username or password error</div>
	<%
}
%>
</form>
</div>
</body>
</html>