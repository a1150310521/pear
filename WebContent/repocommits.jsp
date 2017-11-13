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
	#canvas{
		position: relative;
	}
	.tag{
		position:absolute;
		background-color: rgba(0,0,0,0.8);
		display: inline-block;
		border-radius: 3px;
		color:white;
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
				<a class="dropdown-toggle" data-toggle="dropdown"><s:property value="#session.username"/><span class="caret"></span></a>
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
		<h1></h1>
		<div></div>
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
		<div id="canvas">
			<canvas id="line-chart"></canvas>
		</div>

		<div id="contribution-rate">
			<div class="form-group">
				<label class="control-label col-sm-1 col-sm-offset-2" for="startDate">开始日期</label>
				<div class="col-sm-3">
					<input class="form-control" placeholder="format=yyyy-mm-dd" id="startDate"/>
				</div>

				<label class="control-label col-sm-1 col-sm-offset-1">结束日期</label>
				<div class="col-sm-3">
					<input placeholder="format=yyyy-mm-dd" class="form-control" id="endDate"/>
				</div>
			</div><br/><br/><br/>
			<h3 style="text-align: center;">成员贡献情况</h3>
			<canvas id="rate-pie"></canvas>
			<hr/>
			<h3 style="text-align: center;">成员贡献率</h3>
			<canvas id = "contribute-radar"></canvas>

		</div>

		<canvas id="branchPicture"></canvas>


	</div>



<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
<script src="statics/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="statics/js/Chart.bundle.min.js"></script>
<script src="statics/js/Chart.min.js"></script>

<script src="statics/js/linechart.js"></script>
<script type="text/javascript">

	var commitList = [];
	
	// 获取url参数对象
	var params = (function(){
		var url = decodeURI(location.href);
		var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
		var result = {};
		for(var i=0;i<paraString.length;i++){
			var str = paraString[i];
			result[str.substring(0,str.indexOf("="))] = str.substring(str.indexOf("=")+1,str.length);
		}
		return result;
	})();
	
	// 填充页面头部
	$("#head-bar>h1").html(params["projectname"]);
	$("#head-bar>div").html(params["studentMsgs"]);

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
						commitList = data;
						var xValues = [];
						var yValues = [];
						var msg = [];
						for(var i =0 ;i<data.length;i++){
							var commit = data[i];
							xValues[i] = new Date(commit["date"]);
							yValues[i] = parseInt(commit["addLines"])+parseInt(commit["deleLines"]);
							
							msg[i]="提交者:"+commit["commiter"]+"<br/>提交信息:"+commit["message"]+"<br/>提交时间:"+commit["date"]+"<br/>"+commit["changedFiles"]+" files changed,"+commit["addLines"]+"(+),"+commit["deleLines"]+"(-)";
						}
						
						ctx.save();
						ctx.fillStyle="#ffffff";
						ctx.fillRect(0,0,canvas.width,canvas.height);
						ctx.restore();

						canvas.height = window.innerHeight * 0.5;
						canvas.width = window.innerWidth * 0.8;
						
						var chart = new LineChart(xValues,yValues,msg);
						chart.setPer(canvas).drawAxis(ctx).createCircles(canvas).drawLines(ctx).renderCircles(ctx);
						$('#canvas').show().siblings().hide();
						
						$("#line-chart").mousemove(function(e){
							var cir = chart.circles;
							var c = document.getElementById("line-chart");
							for(var i = 0;i<cir.length;i++){
								if(cir[i].hasPoint(e.pageX-getX(c) , e.pageY - getY(c))){
									cir[i].showMsg();
								}else{
									cir[i].removeMsg();
								}
							}
						});
					}
				});
			
		}




		// 成员贡献率
		var contributionRate  = function(){
			$('#contribution-rate').siblings().hide();
			if(commitList[0]==undefined){
				$.ajax({
					url : "aj/getCommits.action",
					type : 'post',
					dataType : 'json',
					data : {
						reponame : params["reponame"],
						repomaster : params["repomaster"]
					},
					success : function(data){
						commitList = data;
						$('#contribution-rate').show();
					}
				});
			}else{
				$('#contribution-rate').show();
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
		
		page[req]();
		
	});

	// 下拉菜单事件
	$('#startDate,#endDate').change(function(){
		var dateformat = /^(19|20)\d{2}-(0?[1-9]|1[0-2])-(0?[1-9]|[1-2][0-9]|30|31)$/;
		var start = $('#startDate').val();
		var end = $("#endDate").val();
		if(dateformat.test(start) && dateformat.test(end)){
			//  draw on canvas
			var canvas = document.getElementById("rate-pie");
			var ctx = canvas.getContext('2d');

			canvas.height = window.innerHeight * 0.5;
			canvas.width = window.innerWidth * 0.8;

			var startDate = new Date(Date.parse(start));
			var endDate = new Date(Date.parse(end));
			// 擦黑板
			ctx.save();
			ctx.fillStyle="#ffffff";
			ctx.fillRect(0,0,canvas.width,canvas.height);
			ctx.restore();


			

			var dataset = [];
			var students = params["studentMsgs"].split(",");
			var studentObjList = [];
			// get students object list
			// init datasets
			for(var i=0 ;i<students.length;i++){
				var perStu = students[i].split(" ");
				studentObjList[i] =  new Object();
				studentObjList[i]["id"] = perStu[0];
				studentObjList[i]["name"] = perStu[1];
				studentObjList[i]["githubname"] = perStu[2];

				studentObjList[i]["addLines"] = 0;
				studentObjList[i]["deleLines"] = 0;
				studentObjList[i]['changedFiles'] = 0;
				studentObjList[i]['commitCount'] = 0;


				dataset[i] = new Object();
				dataset[i]["label"] = studentObjList[i]["name"];
				// dataset[i]["my-id"] = studentObjList[i]["githubname"];
				dataset[i]["data"] = [0,0,0,0,0];
			}
			// bianli all commits
			for(var i =0;i<commitList.length;i++){
				var theCommit = commitList[i];
				var commitDate = new Date(theCommit["date"]);
				if(startDate.getTime()<=commitDate.getTime() && commitDate.getTime()<=endDate.getTime()){
					// 在时间范围内
					for(var j=0;j<studentObjList.length;j++){
						if(theCommit["commiter"].toLowerCase() == studentObjList[j]["githubname"].toLowerCase()){
							var dataList = dataset[j]["data"];

							dataList[0] += parseInt(theCommit["addLines"]);
							dataList[1] += parseInt(theCommit["deleLines"]);
							dataList[2] += parseInt(theCommit["changedFiles"]);
							dataList[3] ++;
							dataList[4] = dataList[0] + dataList[1];

							dataset[j]["data"] = dataList;


						}
					}
				}
			}
	
			var radarChart = new Chart(ctx, {
    			type: 'radar',
    			data: {
      				labels: ["累计增加代码" ,"累计删除代码","累计修改文件数目","提交次数","累计修改代码"],
        			datasets :dataset

    			},
    			options: {
        
    			}
			});

			var pie = document.getElementById("contribute-radar");
			var pieCtx = pie.getContext("2d");
			pie.height = window.innerHeight * 0.5;
			pie.width = window.innerWidth * 0.8;


			var pieLaber = [];
			var pieDataset = [];
			pieDataset[0] = new Object();
			pieDataset[0]["data"] = [];
			for(var i = 0;i<dataset.length;i++){
				pieLaber[i] = dataset[i]["label"];
				pieDataset[0]["data"][i] = dataset[i]["data"][4] ;
				
			}

			var pieChart = new Chart(pieCtx,{
				type : 'doughnut',
				data :{
				datasets: pieDataset,
				labels: pieLaber
			}
			 });
			



		} //日期合法

	});






</script>
</body>
</html>