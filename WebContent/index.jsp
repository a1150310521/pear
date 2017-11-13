<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="beans.CommitBean" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"> 
  <title>PEAR</title>
  <link rel="stylesheet" href="statics/bootstrap-3.3.7-dist/css/bootstrap.min.css"> 
  <link rel="stylesheet" type="text/css" href="statics/css/index.css"> 
</head>
<body>

  <!-- nav bar -->
	<div style="border-radius: 0;padding-right: 10px;" class="navbar navbar-inverse">
		<div class="navbar-header">
			<a href="index.jsp" class="navbar-brand">PEAR</a>
		</div>

		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown"><s:property value="#session.username"/><span class="caret"></span></a>
				<ol class="dropdown-menu">
					<li><a href="userhome.jsp">我的主页</a></li>
					<li class="nav-divider"></li>
					<li><a href="logout.action">登出</a></li>
				</ol>
			</li>
		</ul>
	</div>

<div class="site-wrapper">
	
  <div class="site-wrapper-inner">
  
    <div class="cover-container">
      





      <div class="inner cover">
        <h1 class="cover-heading">GITHUB项目进展监控</h1>
        <p class="lead">软件工程监控小组项目进展必备神器</p>

<s:if test="#session.username!=null">
          <div>欢迎,<a href="userhome.jsp"><s:property value="#session.username"/></a></div>
</s:if>
<s:else>
        <button type="button" class="btn btn-lg btn-default" data-toggle="modal" data-target="#signin">Sign in</button>&nbsp;&nbsp;OR&nbsp;&nbsp;<button type="button" class="btn btn-lg btn-default" data-toggle="modal" data-target="#signup">Sign up</button>


        <!-- sign up -->
        <div class="modal fade" id="signup" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="btModalLabel">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">x</span><span class="sr-only">Close</span></button>
                                    <div class="row">
                                      <div class="col-md-offset-3 col-md-6">
                                        <form class="form-horizontal" action="signup" method="post">
                                        <span class="heading">用户注册</span>
                                        <div class="form-group ">
                                          <input id="username" name="username" type="text" class="form-control"  placeholder="用户名">
                                          <i class fa fa-user></i>
                                        </div>
                                        <div class="form-group help">
                                          <input id="password" name="password" type="password" class="form-control" placeholder="密 码">
                                          <i class="fa fa-lock"></i>
                                          <a href="#" class="fa fa-question-circle"></a>
                                        </div>
                                        <div class="form-group help">
                                          <input id="repassword" type="password" class="form-control"  placeholder="确 认 密 码">
                                        </div>
                                        <div class="form-group help" >
                                          <input name="email" id="email" type="email" class="form-control"  placeholder="邮 箱">
                                        </div>
                                        <div class="form-group">
                                              

                                            <button type="submit" class="btn btn-default">注 册</button>
                                            </div>
                                          </form>
                                      </div>
                                    </div>
                                  </div>
              </div>
            </div>
          </div>

        <!-- sign in -->
        <div class="modal fade" id="signin" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="btModalLabel">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">x</span><span class="sr-only">Close</span></button>
                                    <div class="row">
                                      <div class="col-md-offset-3 col-md-6">
                                        <form action="signin" method="post" class="form-horizontal">
                                        <span class="heading">用户登录</span>
                                        <div class="form-group">
                                          <input name="username" id="signin-username" type="text" class="form-control" id="inputEmail3" placeholder="用户名">
                                          <i class fa fa-user></i>
                                        </div>
                                        <div class="form-group help">
                                          <input name="password" id="signin-password" type="password" class="form-control" id="inputPassword3" placeholder="密 码">
                                          <i class="fa fa-lock"></i>
                                          <a href="#" class="fa fa-question-circle"></a>
                                        </div>
                                        <div class="form-group">
                                              

                                            <button type="submit" class="btn btn-default">登 录</button>
                                            </div>
                                          </form>
                                      </div>
                                    </div>
                                 
              </div>
            </div>
          </div>
        </div>
</s:else>
      </div>
      
    </div>
  </div>
</div>
<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
<script src="statics/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>