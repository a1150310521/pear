<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="beans.CommitBean" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户主页</title>
<link rel="stylesheet" href="statics/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<style type="text/css">
	#head-bar{
		padding:0 10px;
	}
	#ground{
		margin:10px 30px;
	}
	#ground>*{
		display:none;
	}

</style>
</head>
<body>
<!-- nav bar -->
	<div style="border-radius: 0;padding-right: 10px;" class="navbar navbar-inverse">
		<div class="navbar-header">
			<a class="navbar-brand">PEAR</a>
		</div>

		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown"><s:property value="#session.username"/>MUSHROOM<span class="caret"></span></a>
				<ol class="dropdown-menu">
					<li><a href="userhome.jsp">我的主页</a></li>
					<li class="nav-divider"></li>
					<li><a href="logout.action">登出</a></li>
				</ol>
			</li>
		</ul>
	</div>


<!-- header include projectname ,students msg -->
	<div id="head-bar">
		<h1>GITHUB项目跟踪系统</h1>
		<div>1150310502 张雅姗 BokunoMasayume,1150310502 张雅姗 BokunoMasayume,1150310502 张雅姗 BokunoMasayume</div>
		<hr/>
	</div>



<!-- func nav -->
	<ol id="func-nav" class="nav nav-tabs nav-justified">
		<li><a>历史提交情况</a></li>
		<li><a>成员贡献率</a></li>
		<li><a>分支情况</a></li>
		<li><a>成员协作情况</a></li>
		<li><a>个性化工作分析</a></li>
		<li><a>提交目的分析</a></li>
	</ol>


<!-- work place -->
	<div id='ground'>
		<canvas id="line-chart"></canvas>

		<div id="contribution-rate">
			<div class="form-group">
				<label class="control-label col-sm-1 col-sm-offset-2" for="startDate">开始日期</label>
				<div class="col-sm-3">
					<select class="form-control" id="startDate">
						<option value=''>-请选择-</option>
					</select>
				</div>

				<label class="control-label col-sm-1 col-sm-offset-1">结束日期</label>
				<div class="col-sm-3">
					<select class="form-control" id="endDate">
						<option value=''>-请选择-</option>
					</select>
				</div>
			</div>

			<canvas id="rate-pie"></canvas>

		</div>

		<canvas id="branchPicture"></canvas>


	</div>



<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
<script src="statics/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="statics/js/linechart.js"></script>
<script type="text/javascript">

	var commitList = [];
	
	// 获取url参数对象
	var params = (function(){
		var url = location.href;
		var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
		var result = {};
		for(var i=0;i<paraString.length;i++){
			var str = paraString[i];
			result[str.substring(0,str.indexOf("="))] = str.substring(str.indexOf("=")+1,str.length);
		}
		return result;
	})();
	alert(params['reponame']);

	// 获取应对不同操作的方法
	var page = (function(){
		// 历史提交情况
		var commitsLineChart = function(){
			$('#line-chart').show().siblings().hide();

			var canvas = document.getElementById('line-chart');
			var ctx = canvas.getContext('2d');
			
				$.ajax({
					url : "aj/getCommits.action",
					type : 'post',
					dataType : 'json',
					data : {
						reponame : params["reponame"],
						repomaster : params["repomaster"]
					},
					success : function(data){
						// commitList = JSON.parse(data);
						alert(JSON.stringify(data));
					}
				});
			

			// 画图
		}


		// 成员贡献率
		var contributionRate  = function(){
			$('#contribution-rate').show().siblings().hide();
			if(commitList==[]){
				$.ajax({
					url : "aj/getCommits.action",
					type : 'post',
					dataType : 'json',
					data : {
						reponame : params["reponame"],
						repomaster : params["repomaster"]
					},
					success : function(data){
						commitList = JSON.parse(data);
						alert(commitList);
					}
				});
			}
		}

		// 分支情况
		var branchPic = function(){
			$('#branchPicture').show().siblings().hide();

		}

		return {
			'历史提交情况' : commitsLineChart,
			'成员贡献率' : contributionRate,
			'分支情况' : branchPic
		}

	})();

	$('#func-nav li').click(function(){
		$(this).addClass('active').siblings().removeClass('active');
		var req = $(this).text();
		alert("text:"+req);
		page[req]();
		
	});

	// 下拉菜单事件
	$('#startDate').change(function(){
		
	});




</script>
</body>
</html>