<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="statics/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<style type="css/text">
	.iactive{
		color:red;
	}
</style>
</head>
<body>
<!-- head -->
	<div id="head">
		<h2><s:property value="#session.username"/></h2>
		<ul>
		</ul>
	</div>
<!-- nav -->
	<ol class="nav nav-tabs" id="switchlist">
		<li><a>commits时间表</a></li>
		<li><a>啊啊啊</a></li>
		<li><a>擦擦擦</a></li>
		<li><a>xsaa</a></li>
		<li><a>scscsa</a></li>
	</ol>

<!-- project list -->
	<div id="projectlist">
		<div >
			<button my-package="asca" class="btn default">添加</button>
			<button class="btn default">批量添加</button>

		</div>
		<table class="table table-hover">
			<tbody>
			</tbody>
		</table>
	</div>


<!-- package list -->
	<ul id="packagelist">
		<!-- packages... -->

		<!-- new package -->
		<li id="newpackage">
			<div>
				<input type="text" name="packagename" spaceholder="新建分类名字"/>
				<button>新建分类</button>
			</div>
		</li>
	</ul>



<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
<script src="statics/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">

	window.onload=function(){
		var packages
		$.ajax({
			url : "aj/getpackages.action",
			type: "post",
			dataType: "json",
			success: function(data){
				packages = JSON.parse(data)["packages"];
				for(var i = 0 ; i < packages.length ;i++){
					$("#newpackage").before("<li>"+packages[i]+"</li>");
				}
			}
		});
		

		if(packages.length>=1){
			$("#packagelist:first-child").addClass("iactive");
			$.ajax({
				url : "aj/packageProjects.action",
				type: "post",
				dataType : "json",
				data : {
					packagename : packages[0];
				},
				success : function(data){
					var projects = JSON.parse(data);

				}
			});
		}
	};
	$("#switchlist li").click(function(){
		$(this).addClass('active').siblings().removeClass('active');
		// 判断

		// ajax请求
	});

	$("#newpackage button").click(function(){
		var newName = $("#newpackage button").prev().val();  
		var flag = true;
		// 判断新建包名字是否可用

		// ajax提交
		if(flag){
			$.ajax({
				url : "aj/addPackage.action",
				type : "post",
				dataType : "json",
				data : {
					packagename : newName
				},
				success : function(){
					// 新包添加到位
					$("#newpackage").before("<li>"+newName+"</li>");
				}
			});
		}
		
		
	})

	$("#packagelist li").click(function(){
		if($(this).attr('id')!='newpackage'){
			$(this).addClass('active').siblings().removeClass('active');
			var packagename = $(this).text();
			$.ajax({
				url : "aj/packageProjects.action",
				type: "post",
				dataType : "json",
				data : {
					packagename : packagename
				},
				success : function(data){
					var projects = JSON.parse(data);

				}
			});
		}
	});
</script>
</body>
</html>