<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<s:if test="#session.username!=null">
<div>欢迎，<a href="userhome.jsp"><s:property value="#session.username"/></a></div>
</s:if>
<s:else>
<a href="login.jsp">登录</a><br/>
<a href="signup.jsp">注册</a>
</s:else>
<a href="logout.action">登出</a>

<button id = "ajax" >AJAX</button>
<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
<script>
$(function(){
$("#ajax").click(function(){
	$.ajax({
		url:"aj/ajaxtest.action",
		type:"post",
		dataType:"json",
		data:{
			username:"mushroom"
			
		},
		
		success:function (data){
			alert(JSON.parse(data)["repos"][0]["projectname"]);
		}
	});
});
});
</script>
</body>
</html>