<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
function checkqwd(){
	var p1=document.form1.password.value;
	var p2=document.form1.password2.value;
	if (p1==""){
		alert("请输入密码");
		document.form1.password.focus();
		return false;
	}
	if(p1!=p2){
		document.getElementByldx_x("msg").innerHTML="两侧输入密码不一致";
		return false;
	}
		
}
</script>
<body>
<form action="signup" method="post" name="form1">
<input type="text" name="username" placeholder="用户名"/>
<input type="text"  name="password" placeholder="密码"/>
<input type="text" name="password2" placeholder="确认密码" onchange="checkpwd()"/>
<div id="msg" style="color:red;"></div>
<input type="text" name="email" placeholder="邮箱"/>
<button type="submit" >注&nbsp;册</button>
</form>
</body>
</html>