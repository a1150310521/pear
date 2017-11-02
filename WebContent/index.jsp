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
<div>欢迎，<s:property value="#session.username"/></div>
</s:if>
<s:else>
<a href="login.jsp">登录</a><br/>
<a href="signup.jsp">注册</a>
</s:else>
<a href="logout.action">登出</a>

<button id = "ajax" >AJAX</button>
<script src="statics/jquery-1.3.1.js"></script>
<script>
$("#ajax").click(function(){
	$.ajax({
		url:"aj/ajaxtest.action",
		type:"post",
		dataType:"json",
		data:{
			username:"mushroom"
			
		},
		
		success:function (data){
			alert(data);
		}
	});
});
</script>
</body>
</html>