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
<form action="signin" method="post">
<input type="text" name="username" value="<s:property value="username"/>" placeholder="用户名"/>
<input type="text" name="password" value="<s:property value="password"/>" placeholder="密码"/>
<input type="submit" value="登录"/>
</form>
</body>
</html>