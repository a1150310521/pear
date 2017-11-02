<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="statics/bootstrap-3.3.7-dist/css/bootstrap.min.css">
</head>
<body>
	<div id="head">
		<h2><s:property value="#session.username"/></h2>
		<ul>
		</ul>
	</div>

	<ol class="nav nav-tabs" id="switchlist">
		<li><a>commits时间表</a></li>
		<li><a>啊啊啊</a></li>
		<li><a>擦擦擦</a></li>
		<li><a>xsaa</a></li>
		<li><a>scscsa</a></li>
	</ol>

	<div id="projectlist">
	</div>


	<ul id="packagelist">
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
		
		$.ajax({
			url : "aj/getpackages.action",
			type: "post",
			dataType: "json",
			success: function(data){
				var packages = JSON.parse(data)["packages"];
				for(var i = 0 ; i < packages.length ;i++){
					$("#newpackage").before("<li>"+packages[i]+"</li>");
				}
			}
		});
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
</script>
</body>
</html>