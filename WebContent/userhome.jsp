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
	.dele-btn{
		display: none;
	}
  .file{
    position: relative;
    display:inline-block;
    overflow: hidden;

  }
  .file input{
    position :absolute;
    right:0;
    top:0;
    opacity: 0;
  }
</style>
</head>
<body>
  <!-- nav bar -->
	<div style="border-radius: 0;padding-right: 10px;" class="navbar navbar-inverse">
		<div class="navbar-header">
			<a  href="index.jsp" class="navbar-brand">PEAR</a>
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
<!-- head -->
	<div id="head">
		<h2><s:property value="#session.username"/></h2>
		<hr/>
	</div>


<!-- project list -->
	<div style="float:left;width:70%;margin-right: 30px;" id="projectlist">
		<div style="float:right;margin-bottom: 20px;">
			<button id="showDeleBTN" class="btn default">删除</button>
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
			<button id="addBlukProjectsBTN" class="file btn default">
        <input type="file" onchange="importf(this)"/>批量添加
      </button>
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
<script src="statics/js/xlsx.full.min.js"></script>
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
					$("#newpackage").before("<li ><span>"+ipackages[i]+"</span><button class=\'btn-xs dele-btn btn btn-primary\'>删除</button></li>");
				}


				if(ipackages.length>0){
					$("#packagelist li:first-child").addClass("iactive");
					focusPackage = $("#packagelist li:first-child").children('span').text();

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
								var studentMsgs = [];
								for(var j =0 ;j<project.students.length;j++){
									studentMsgs[j] =  project.students[j].id+" "+project.students[j].name+" "+project.students[j].githubname;
								}

								var href = "https://github.com/" + project.repomaster +"/" + project.reponame ;

								$('#projectlist tbody').append(
									"<tr><td>" +project.projectname+"</td><td><a href=\'"
									+href+"\'>"+href+"</a></td><td>"+studentMsgs.join()+"</td><td class=\'dele-btn btn btn-primary\'>删除</td></tr>");
							}
						}
					});
				}
			}
		});


	})();

  //导入EXCEL
  function importf(obj){
    var wb;
    if(!obj.files){
      return;
    }
    var f = obj.files[0];
    if("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"!=f.type){
      alert("请确保文件类型为xlsx");
      return ;
    }
    var reader = new FileReader();
    reader.onload = function(e){
      var data = e.target.result;
      wb = XLSX.read(data,{
        type:"binary"
      });

      var importJSON = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
      // 导入的json

      var jud = confirm("确定导入吗？");
      if(jud==false){
        return;
      }

      var ajaxData = {};
      for(var i = 0 ; i < importJSON.length ; i++){
        ajaxData["proList["+i+"].projectname"] = importJSON[i]["项目名称"];
        var proURL = importJSON[i]["项目地址"];
        proURL = proURL.split('/');
        if(proURL[proURL.length-1] == ""){
          ajaxData["proList["+i+"].reponame"] = proURL[proURL.length - 2];
          ajaxData["proList["+i+"].repomaster"] = proURL[proURL.length - 3];
        }
        else{
          ajaxData["proList["+i+"].reponame"] = proURL[proURL.length - 1];
          ajaxData["proList["+i+"].repomaster"] = proURL[proURL.length - 2];
        }
        ajaxData["proList["+i+"].packagename"] = focusPackage;

        ajaxData["proList["+i+"].students[0].id"] = importJSON[i]["组员1学号"];
        ajaxData["proList["+i+"].students[0].name"] = importJSON[i]["组员1姓名"];
        ajaxData["proList["+i+"].students[0].githubname"] = importJSON[i]["组员1github账号"];

        ajaxData["proList["+i+"].students[1].id"] = importJSON[i]["组员2学号"];
        ajaxData["proList["+i+"].students[1].name"] = importJSON[i]["组员2姓名"];
        ajaxData["proList["+i+"].students[1].githubname"] = importJSON[i]["组员2github账号"];

        ajaxData["proList["+i+"].students[2].id"] = importJSON[i]["组员3学号"];
        ajaxData["proList["+i+"].students[2].name"] = importJSON[i]["组员3姓名"];
        ajaxData["proList["+i+"].students[2].githubname"] = importJSON[i]["组员3github账号"];


      }

      $.ajax({
        url : "aj/addProjects.action",
        type : "post",
        dataType : "json",
        data : ajaxData,
        success : function(){
          for(var i = 0  ; i < importJSON.length ; i++){
            $('#projectlist tbody').append(
    					"<tr><td>" +importJSON[i]["项目名称"]+"</td><td><a href=\'"
    					+importJSON[i]["项目地址"]+"\'>"+importJSON[i]["项目地址"]+"</a></td><td>"+
              importJSON[i]["组员1学号"]+" "+importJSON[i]["组员1姓名"]+" "+importJSON[i]["组员1github账号"]+","+
              importJSON[i]["组员2学号"]+" "+importJSON[i]["组员2姓名"]+" "+importJSON[i]["组员2github账号"]+","+
              importJSON[i]["组员3学号"]+" "+importJSON[i]["组员3姓名"]+" "+importJSON[i]["组员3github账号"]+
              "</td><td class=\'dele-btn btn btn-primary\'>删除</td></tr>");
          }

        }
      });

    };//onload

    reader.readAsBinaryString(f);


  }

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
					$("#newpackage").before("<li><span>"+newName+"</span><button class=\'btn-xs dele-btn btn btn-primary\'>删除</button></li>");
				}
			});
		}


	});


	//选中包并展示包内项目
	$("#packagelist").delegate("li","click",function(){

		if($(this).attr('id')!='newpackage'){

			$(this).addClass('iactive').siblings().removeClass('iactive');

			var packagename = $(this).children('span').text();
			// alert(packagename);
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
						var studentMsgs = [];
						for(var j =0 ;j<project.students.length;j++){
							studentMsgs[j] =  project.students[j].id+" "+project.students[j].name+" "+project.students[j].githubname;
						}
						var href = "https://github.com/" + project.repomaster +"/" + project.reponame ;

						$('#projectlist tbody').append(
							"<tr><td>" +project.projectname+"</td><td><a href=\'"
							+href+"\'>"+href+"</a></td><td>"+studentMsgs.join()+"</td><td class=\'dele-btn btn btn-primary\'>删除</td></tr>");
					}

				}
			});
		}
	});

    // this is worry
    // but i still donot know why
    // i ll finish it later
	// $('#showDeleBTN').toggle(function(){
	// 	$('.dele-btn').show();
	// },
	// function(){
	// 	$('.dele-btn').hide();
	// });
	$('#showDeleBTN').click(function(){

		$('.dele-btn').toggle(500);
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
		var studentMsgs = [];
		for(var i=0 ; i<students.length;i++){
			var student = new Object();
			var stuDom = students[i];

			student.id = stuDom.getElementsByClassName("student-id")[0].value;
			student.name = stuDom.getElementsByClassName("student-name")[0].value;
			student.githubname = stuDom.getElementsByClassName("student-githubname")[0].value;

			studentList[i] = student;

			studentMsgs[i] =  student.id+" "+student.name+" "+student.githubname;
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
				"project.students[2].githubname": studentList[2].githubname

			},
			success:function(){
				$('.form-background').hide();
				var href = "https://github.com/" + project.repomaster +"/" + project.reponame ;

				$('#projectlist tbody').append(
					"<tr><td>" +project.projectname+"</td><td><a href=\'"
					+href+"\'>"+href+"</a></td><td>"+studentMsgs.join()+"</td><td class=\'dele-btn btn btn-primary\'>删除</td></tr>");
			}
		});
	});

	$("#projectlist tbody").delegate("tr","click",function(){
		var href = $(this.getElementsByTagName("td")[1]).text();
		var msgs = href.split("/");
		var go = location.href;
		var str = go.slice(0,go.lastIndexOf('/')+1) + "repocommits.jsp?reponame=" + msgs[msgs.length-1]
		  + "&repomaster=" + msgs[msgs.length-2]+"&studentMsgs="+$(this.getElementsByTagName("td")[2]).text()+"&projectname="+$(this.getElementsByTagName("td")[0]).text();
		location.href = encodeURI(str);
	});

	$('#projectlist tbody').delegate(".dele-btn","click",function(event){
		event.stopPropagation();

		var href = $(this).prev().prev().text();
		var msgs = href.split("/");

		var $tr = $(this).parent();
		$.ajax({
			url : "aj/deleProject.action",
			type : 'post',
			dataType : 'json',
			data : {
				repomaster: msgs[msgs.length-2],
				reponame : msgs[msgs.length-1] ,
				projectname : $(this).prev().prev().prev().text()
			},
			success:function(){
				$tr.remove();
			}
		});

	});

	$("#packagelist").delegate(".dele-btn","click",function(event){
		event.stopPropagation();

		var packagename = $(this).prev().text();
		var $li = $(this).parent();
		$.ajax({
			url:"aj/delePackage.action",
			type:'post',
			dataType:'json',
			data:{
				packagename:packagename
			},
			success:function(){
				$li.remove();
			}
		});
	});
</script>
</body>
</html>
