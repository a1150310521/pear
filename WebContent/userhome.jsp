 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="statics/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<style type="text/css">
	.iactive{
		color:red;
	}
	.form-background{
		display:none;
		background-color: rgba(0,0,0,0.8);
		position:fixed;
		left:0;
		top:0;
		height:100%;
		width:100%;
		padding:5% 20%;
	}
	.form{
		background-color: #FFF;
		padding:5%;
		border-radius: 5px;
	}
</style>
</head>
<body>
<body>
<!-- head -->
	<div id="head">
		<h2>MUSHROOM</h2>
		<hr/>
	</div>


<!-- project list -->
	<div style="float:left;width:70%;margin-right: 30px;" id="projectlist">
		<div style="float:right;margin-bottom: 20px;">
			<button id="showAddFormBTN" class="btn default">添加</button>
<!-- 添加项目 -->
			<div class="form-background">
				<div class="form">
					<form class="form-horizontal">
					<div class="form-group">
    					<label class="control-label col-sm-4" for="projectname">项目名称</label>
    					<div class="col-sm-6">
      						<input type="text" id="projectname" class="form-control" placeholder="项目名称">
    					</div>
  					</div>

  					<div class="form-group">
    					<label class="control-label col-sm-4" for="reponame">仓库名字</label>
    					<div class="col-sm-6">
      						<input type="text" id="reponame" class="form-control" placeholder="仓库名字">
    					</div>
  					</div>

  					<div class="form-group">
  						<label class="control-label col-sm-4" for="repomaster">仓库所有者</label>
  						<div class="col-sm-6">
  							<input type="text" id="repomaster" class="form-control" placeholder="仓库所有者">
  						</div>
  					</div>

  					<h2 style="text-align:center">学生信息</h2>
  						<div class="student form-group">
  							<div class="col-sm-1"></div>
  							<div class="col-sm-3 ">
  								<input type="text"  class="form-control student-id" placeholder="id"/>
  							</div>
  							<div class="col-sm-3 ">
  								<input type="text"  class="form-control student-name" placeholder="name"/>
  							</div>
  							<div class="col-sm-3 ">
  								<input type="text"  class=" form-control student-githubname" placeholder="githubname"/>
  							</div>

  						</div>

  						<div class="student form-group">
  							<div class="col-sm-1"></div>
  							<div class="col-sm-3 ">
  								<input type="text"  class="form-control student-id" placeholder="id"/>
  							</div>
  							<div class="col-sm-3 ">
  								<input type="text"  class="form-control student-name" placeholder="name"/>
  							</div>
  							<div class="col-sm-3 ">
  								<input type="text"  class=" form-control student-githubname" placeholder="githubname"/>
  							</div>

  						</div>

  						<div class="student form-group">
  							<div class="col-sm-1"></div>
  							<div class="col-sm-3 ">
  								<input type="text"  class="form-control student-id" placeholder="id"/>
  							</div>
  							<div class="col-sm-3 ">
  								<input type="text"  class="form-control student-name" placeholder="name"/>
  							</div>
  							<div class="col-sm-3 ">
  								<input type="text"  class=" form-control student-githubname" placeholder="githubname"/>
  							</div>

  						</div>

  						<div style="padding-left: 25%;">
  							<div style="width:50%" class="btn btn-primary" id="addProjectBTN">添&nbsp;加</div>
  						</div>
  						

					</form>
				</div>
			</div>
			<button id="addBlukProjectsBTN" class="btn default">批量添加</button>
<!-- 批量添加表单 -->

		</div>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>项目</th>
					<th>github地址</th>
					<th>参与学生</th>
				</tr>
			</thead>
			<tbody>
				
			</tbody>
		</table>
	</div>


<!-- package list -->
	<ul  id="packagelist">
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
	var focusPackage;
	//载入时
	(function(){
		var ipackages;
		$.ajax({
			url : "aj/getpackages.action",
			type: "post",
			dataType: "json",
			success: function(data){
				ipackages = JSON.parse(data)["packages"];
				console.log(ipackages);
				for(var i = 0 ; i < ipackages.length ;i++){
					$("#newpackage").before("<li >"+ipackages[i]+"</li>");
				}
				
				
				if(ipackages.length>0){
					$("#packagelist li:first-child").addClass("iactive");
					focusPackage = $("#packagelist li:first-child").text();
					
					$.ajax({
						url : "aj/packageProjects.action",
						type: "post",
						dataType : "json",
						data : {
							packagename : ipackages[0]
						},
						success : function(data){
							var projects = JSON.parse(data)["projects"];

							for(var i =0 ; i<projects.length;i++){
								var project = projects[i];
								var studentNames = [];
								for(var j =0 ;j<project.students.length;j++){
									studentNames[j] =  project.students[j].name;
								}

								var href = "https://github.com/" + project.repomaster +"/" + project.reponame ;

								$('#projectlist tbody').append(
									"<tr><td>" +project.projectname+"</td><td><a href=\'"
									+href+"\'>"+href+"</a></td><td>"+studentNames.join()+"</td></tr>");
							}
						}
					});
				}
			}
		});
		
		
	})();
	
	//新建包
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
		
		
	});

	
	//选中包并展示包内项目
	$("#packagelist").delegate("li","click",function(){
		
		if($(this).attr('id')!='newpackage'){
			
			$(this).addClass('iactive').siblings().removeClass('iactive');

			var packagename = $(this).text();
			focusPackage = packagename;
			$.ajax({
				url : "aj/packageProjects.action",
				type: "post",
				dataType : "json",
				data : {
					packagename : packagename
				},
				success : function(data){
					var projects = JSON.parse(data)["projects"];
					
					$('#projectlist tbody').html("");

					for(var i =0 ; i<projects.length;i++){
						var project = projects[i];
						var studentNames = [];
						for(var j =0 ;j<project.students.length;j++){
							studentNames[j] =  project.students[j].name;
						}
						var href = "https://github.com/" + project.repomaster +"/" + project.reponame ;

						$('#projectlist tbody').append(
							"<tr><td>" +project.projectname+"</td><td><a href=\'"
							+href+"\'>"+href+"</a></td><td>"+studentNames.join()+"</td></tr>");
					}

				}
			});
		}
	});

	$('#showAddFormBTN').click(function(){
		$(this).next().show();
	});

	$('.form-background').click(function(){
		$(this).hide();
	});
	$('.form').click(function(event){
		event.stopPropagation();
	});

	$('#addProjectBTN').click(function(event){
		event.stopPropagation();
		
		var reponame = document.getElementById("reponame");
		var repomaster = document.getElementById("repomaster");
		var projectname = document.getElementById("projectname");
		var students = document.getElementsByClassName("student");
		// 检查输入是否合法
		
		var project = new Object();
		project.projectname = projectname.value;
		project.reponame = reponame.value;
		project.repomaster = repomaster.value;
		project.packagename = focusPackage;

		var studentList = [];
		var studentNames = [];
		for(var i=0 ; i<students.length;i++){
			var student = new Object();
			var stuDom = students[i];
			
			student.id = stuDom.getElementsByClassName("student-id")[0].value;
			student.name = stuDom.getElementsByClassName("student-name")[0].value;
			student.githubname = stuDom.getElementsByClassName("student-githubname")[0].value;

			studentList[i] = student;

			studentNames[i] = student.name;
		}
		project.students = studentList;
		//alert(JSON.stringify(project));
		// ajax传回后台
		$.ajax({
			url : "aj/addOneProject.action",
			type:"post",
			dataType: "json",
			data : {
				"project.projectname" : projectname.value,
				"project.reponame" : reponame.value,
				"project.repomaster" : repomaster.value,
				"project.packagename" : focusPackage,
				"project.students[0].id": studentList[0].id,
				"project.students[0].name": studentList[0].name,
				"project.students[0].githubname": studentList[0].githubname,
				
				"project.students[1].id": studentList[1].id,
				"project.students[1].name": studentList[1].name,
				"project.students[1].githubname": studentList[1].githubname,
				
				"project.students[2].id": studentList[2].id,
				"project.students[2].name": studentList[2].name,
				"project.students[2].githubname": studentList[2].githubnames
				
			},
			success:function(){
				$('.form-background').hide();
				var href = "https://github.com/" + project.repomaster +"/" + project.reponame ;

				$('#projectlist tbody').append(
					"<tr><td>" +project.projectname+"</td><td><a href=\'"
					+href+"\'>"+href+"</a></td><td>"+studentNames.join()+"</td></tr>");
			}
		});
	});

	$("#projectlist tbody").delegate("tr","click",function(){
		alert($(this).html());
	});
</script>
</body>
</html>