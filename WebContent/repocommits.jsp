<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="beans.CommitBean" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">  
 	<title>信 息</title>
	<style type="text/css">

	</style>
</head>
<body>
<canvas id="zhexian" ></canvas>
<!-- <s:iterator value="commitList">
<s:property value="date"/><br/>
<s:property value="commiter"/><br/>
<s:property value="changedLines"/><br/>
<s:property value="message"/><br/><br/>
</s:iterator> -->
<script src="statics/Chart.min.js"></script>
<script src="statics/Chart.bundle.min.js"></script>
<script>
	(function(){
		var width=window.innerWidth *0.8;
		var height = window.innerHeight *0.8;

		var zhexian = document.getElementById("zhexian");
		var ctx = zhexian.getContext("2d");
		zhexian.width = width;
		zhexian.height = height;

		var data = {
	labels : [ ],
	datasets : [
		{
			fillColor : "rgba(220,220,220,0.5)",
			strokeColor : "rgba(220,220,220,1)",
			pointColor : "rgba(220,220,220,1)",
			pointStrokeColor : "#fff",
			data : []
		}
	]
}
	
		<s:iterator value="commitList">
		// data.labels.push(new Date("<s:date name="date"/>"));
		data.labels.push("<s:date name="date"/>");

        data.datasets[0].data.push(<s:property value="changedLines"/>);

		</s:iterator>
       data.datasets[0].data.reverse();
		var chart = new Chart(ctx,{
			type:'line',
			data:data
		});
	})();
</script>
</body>

</html>