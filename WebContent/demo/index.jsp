<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>

<%

String name = (String)request.getSession().getAttribute("user");
if(name==null||name.length()==0){
	response.sendRedirect("../login.jsp");
	return;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title>ZooKeeper Manager Plugin</title>
	
	<link rel="stylesheet" href="../jquery.treeview.css" />
	<link rel="stylesheet" href="screen.css" />
	
	<script src="../lib/jquery.js" type="text/javascript"></script>
	<script src="../lib/jquery.cookie.js" type="text/javascript"></script>
	<script src="../jquery.treeview.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="demo.js"></script>
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
	
	$(function() {
		
		
		function closeTip(){
			$(".time").html(0);
		    $(".marsking").hide();
		}
		
		
		var ExecuteSpan = null;
		function CalculateExecuteTime() {
		ExecuteSpan = setInterval(function () {
		  $(".time").html(parseInt($(".time").html()) + 1);
		}, 1000);
		}       

		
		var paraentNode="";
		
		var html="";
		
		function edutitem(child){
			 $.each(child, function(index, item) {   
				 	var name =item.nodeName;
				 	var path =item.path;
					//has child
					if(item.child.length>0){
						html += "<li><span class=\"folder\" path=\""+path+"\">"+name+"</span><ul>";
						edutitem(item.child);
						html +="</ul></li>";
					}else{
						//yezi node
						html +="<li><span class=\"file\" path=\""+path+"\">"+name+"</span></li>";
					}
	         });
		}
		
		!function(){
			paraentNode="";
			
			$(".marsking").fadeIn();
		    CalculateExecuteTime();
		    
			$.ajax({
				url:"../tree.action?times="+new Date().getTime(),
				type:"get",
				dataType:"json",
				timeout:150000,
				data:{},
				success:function(str){
					
					
					
					for(var i=0;i<str.length;i++){
						var item = str[i];
						var name =item.nodeName;
						var path =item.path;
						//has child
						if(item.child.length>0){
							html += "<li><span class=\"folder\" path=\""+path+"\">"+name+"</span><ul>";
							edutitem(item.child);
							html +="</ul></li>";
						}else{
							//yezi node
							html +="<li><span class=\"file\" path=\""+path+"\">"+name+"</span></li>";
						}
					}
					
					$("#browser").empty();
					$("#browser").append(html);
					
					closeTip();
					
				},
				error: function () {
					alert("network error，please try it again later");
					closeTip();
		        }
			});
			
		}();
		
		
		var oldtime = (new Date()).valueOf();
		var nowtime;
		
		$(".folder").live("click",function(){
			
			nowtime= (new Date()).valueOf();
			var between=parseInt(nowtime)-parseInt(oldtime);
			if(between<500){
				alert("please click,not use dbclick");
				return;
			}
			
			$(".marsking").fadeIn();
		    CalculateExecuteTime();
		    
			var path = $(this).attr("path");
			paraentNode=path;
			
			$(".file").css("background-color","#FFFFFF");
			$(".folder").css("background-color","#FFFFFF");
			$(this).css("background-color","red");
		
			
			$.ajax({
				url:"../treedata.action?times="+new Date().getTime(),
				type:"post",
				dataType:"json",
				timeout:150000,
				data:{
					path:path
				},
				success:function(str){
					if(str.message=="100002"){
						alert("sorry,NoAuth");
						closeTip();
					}else if(str.message=="100003"){
						alert("sorry,connection lost,try agian");
						closeTip();
					}else if(str.message=="100004"){
						alert("sorry,inner error");
						closeTip();
					}else if(str.message=="100005"){
						alert("sorry,Session expired");
						closeTip();
					}else if(str.message=="100006"){
						alert("sorry,no node found ,please refesh");
						closeTip();
					}else{
						$("#datavalue").val(str.message);
						$("#datapath").val(str.path);
						closeTip();
					}
					
					oldtime =nowtime;
				},
				error: function () {
					alert("network error，please try it again later");
					closeTip();
		        }
			});
			
			
			
		});
		
		
		$(".file").live("click",function(){
			
			nowtime= (new Date()).valueOf();
			var between=parseInt(nowtime)-parseInt(oldtime);
			if(between<500){
				alert("please click,not use dbclick");
				return;
			}
			
			
			$(".marsking").fadeIn();
		    CalculateExecuteTime();
		    
			var path = $(this).attr("path");
			paraentNode=path;
			
			$(".file").css("background-color","#FFFFFF");
			$(".folder").css("background-color","#FFFFFF");
			$(this).css("background-color","red");
		
			
			$.ajax({
				url:"../treedata.action?times="+new Date().getTime(),
				type:"post",
				dataType:"json",
				timeout:150000,
				data:{
					path:path
				},
				success:function(str){
					if(str.message=="100002"){
						alert("sorry,NoAuth");
						closeTip();
					}else if(str.message=="100003"){
						alert("sorry,connection lost try agian");
						closeTip();
					}else if(str.message=="100005"){
						alert("sorry,Session expired");
						closeTip();
					}else if(str.message=="100006"){
						alert("sorry,no node found ,please refesh");
						closeTip();
					}else{
						$("#datavalue").val(str.message);
						$("#datapath").val(str.path);
						closeTip();
					}
					oldtime =nowtime;
				},
				error: function () {
					alert("network error，please try it again later");
					closeTip();
		        }
			});
			
			
			
		});
		
		$("#add").click(function(){
			if(paraentNode==""){
				alert("Please select 1 parent node for the new node.");
			}else{
				
			    
			    
				var data = prompt("Please Enter a name for the new node ","");
				 if (data!=null && data!=""){
					 
						$(".marsking").fadeIn();
					    CalculateExecuteTime();
					    
					 $.ajax({
							url:"../createtreedata.action?times="+new Date().getTime(),
							type:"post",
							dataType:"json",
							timeout:150000,
							data:{
								parentPath:paraentNode,
								nodename:data
							},
							success:function(str){
								if(str.message=="10001"){
									alert("save sucessed");
									refesh();
									
								}else if(str.message=="10002"){
									alert("fail,node exists");
									
								}else{
									alert("save fail");
								}
								closeTip();
							},
							error: function () {
								alert("network error，please try it again later");
								closeTip();
					        }
						});
				 }
			}
			
		});
		
		$("#del").click(function(){
			if(paraentNode==""){
				alert("Please select at least 1 node to be deleted.");
			}else{
				if(confirm("Are you sure want to delete the selected nodes?(This action cannot be reverted)")) {
					
					$(".marsking").fadeIn();
				    CalculateExecuteTime();
				    
					$.ajax({
						url:"../deletetreedata.action?times="+new Date().getTime(),
						type:"post",
						dataType:"json",
						timeout:150000,
						data:{
							parentPath:paraentNode
						},
						success:function(str){
							if(str.message=="10001"){
								alert("delete sucessed");
								refesh();
								
							}else if(str.message=="10002"){
								alert("fail,nodes does not exist.");
							}else {
								alert("delete fail");
							}
							
							closeTip();
						},
						error: function () {
							alert("network error，please try it again later");
							closeTip();
				        }
					});
			     }
			}
			
		});
		
		$("#about").click(function(){
			alert("this zookeeper  mananger was developed by kangfei. mail:501565246@qq.com");
		});
		
		$("#save").click(function(){
			if(confirm("Are you sure you want to save this node?(this action cannot be reverted)")){
				var data = $("#datavalue").val();
				var path =$("#datapath").val();
				$.ajax({
					url:"../savetreedata.action?times="+new Date().getTime(),
					type:"post",
					dataType:"json",
					timeout:150000,
					data:{
						path:path,
						data:data
					},
					success:function(str){
						if(str.message=="10001"){
							alert("save sucessed");
						}else {
							alert("save fail");
						}
						
					},
					error: function () {
						alert("network error，please try it again later");
			        }
				});
				
			}
		});
		
		$("#refesh").click(function(){
			refesh();
		});
		
		
		
		
		function refesh(){
			paraentNode="";
			
			$(".marsking").fadeIn();
		    CalculateExecuteTime();
		    
			$("#browser").empty();
			html="";
			$.ajax({
				url:"../tree.action?times="+new Date().getTime(),
				type:"get",
				dataType:"json",
				timeout:150000,
				data:{},
				success:function(str){
					
					
					
					for(var i=0;i<str.length;i++){
						var item = str[i];
						var name =item.nodeName;
						var path =item.path;
						//has child
						if(item.child.length>0){
							html += "<li><span class=\"folder\" path=\""+path+"\">"+name+"</span><ul>";
							edutitem(item.child);
							html +="</ul></li>";
						}else{
							//yezi node
							html +="<li><span class=\"file\" path=\""+path+"\">"+name+"</span></li>";
						}
					}
					
					
					$("#browser").append(html);
					closeTip();
				},
				error: function () {
					alert("network error，please try it again later");
					closeTip();
		        }
			});
		}
		
		
		$("#logout").click(function(){
			$.ajax({
				url:"../logout.action?times="+new Date().getTime(),
				type:"get",
				dataType:"json",
				timeout:10000,
				data:{},
				success:function(str){
				},
				error: function () {
					window.location.href="../login.jsp";
		        }
			});
		});
	});
	
	</script>
	
	</head>
	<body >
	
<div class="marsking">
        <div class="timespan">
            Please waiting，zookeeper processing.....(<span class="time">0</span>)
        </div>
    </div>
    <script type="text/javascript" language="javascript">
        
    </script>
<div class="TopBgLogo" style="display:none;">
</div>
	
	<h1 id="banner"><a href="#">ZooKeeper Manager Plugin</a> developed by kangfei</h1>
	<div id="main">
		<div id="left" style="float: left; width: 500px;">
			<div>
				<input type="button" value="refesh" id="refesh"/>
				<input type="button" value="add" id="add"/>
				<input type="button" value="del" id="del"/>
				<input type="button" value="about" id="about"/>
				<input type="button" value="logout" id="logout"/>
			</div>
			<div>
				<h4>Zookeeper</h4>
				<ul id="browser" class="filetree">
				</ul>
			</div>
		</div>	
	</div>
 	<div id="reght" style="float: left;margin-left: auto;">
 		<div><input type="button" value="save" id="save"/></div>
 		<div>
 			<input type="hidden" id="datapath" value=""/>
	 		<textarea rows="80" cols="100" id="datavalue">
	 		</textarea>
		</div>
	</div>
</body></html>