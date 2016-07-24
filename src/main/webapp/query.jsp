<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   
	<head>
        <title></title>
        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
        <link href="assets/styles.css" rel="stylesheet" media="screen">
        
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        
        <script src="script/jquery-2.0.3.js" type="text/javascript"></script>
    </head>
    
<body>
	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
				<a class="brand" href="#">Ironman</a>
				<div class="nav-collapse collapse">
					<ul class="nav pull-right">
						<li class="dropdown">
							<a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
								<i class="icon-user"></i> Admin <i class="caret"></i>
							</a>
							<ul class="dropdown-menu">
								<li>
									<a tabindex="-1" href="#">Profile</a>
								</li>
								<li class="divider"></li>
								<li>
									<a tabindex="-1" href="#">Logout</a>
								</li>
							</ul>
						</li>
					</ul>
					<ul class="nav">
						<li>
							<a href="add.jsp">添加</a>
						</li>
						<li>
							<a href="delete.jsp">删除</a>
						</li>
						<li class="active">
							<a href="query.jsp">查询</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
					<div class="row-fluid">
						<label class="control-label" style="float:left; margin:5px">
							<span style="font-size:16px;">目标类型 : </span>
							<select id="type" class="form-control" style="width:200px;">
								<option value="product">product</option>
								<option value="industry">industry</option>
								<option value="solution">solution</option>
								<option value="configuration">configuration</option>
								<option value="">all</option>
							</select>
						</label>
						<label class="control-label" style="float:left; margin:5px;">
							<span style="font-size:16px;">相关问题 : </span>
							<input id="question" value="低能耗人機介面" style="width:200px;" type="text"/>
					    </label>
					    <label class="control-label" style="float:left; margin:5px;">
					    	<button onclick="search()" class="btn btn-info" style="width:100px;">搜索</button>
						</label>
					</div>
			</div>
			<div class="span8">
					<div id="answer" class="row-fluid">
					</div>
			</div>
			<div class="span3">
					<div class="row-fluid">
						<h5>常见问题</h5>
				    	<ul>
				    		<li><a href="/ironman/query?type=product&question=DOP-B">交流伺服马达与驱动器有哪些产品</a></li>
				    		<li><a href="">震雄公司使用过哪些产品</a></li>
				    		<li><a href="">交流伺服马达与驱动器有哪些型号</a></li>
				    		<li><a href="">...</a></li>
				    	</ul>
			    	</div>
			    	<br/>
			    	<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">Details</div>
							<div class="pull-right"><span class="badge badge-warning"></span></div>
						</div>
						<div id="content" class="row-fluid">
			    		</div>
					</div>
			</div>
		</div>
				
		<hr>
		<p>&copy; SEKE PKU &amp; Delta 2015 </p>
	</div>

	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/scripts.js"></script> 
</body>

<script>
var details = {};

function showDetail(sourceID) {
	$("#content").empty();
	var temp = "";
	temp = details[sourceID];
	console.log(temp);
	temp = temp.replace(/undefined/g, "");
	$("#content").append(temp);
}

function showInfo(obj, indent) {
    var ret = "";
    for(var p in obj) {
    	if(typeof(obj[p]) == "function")
    		continue;
    	if(typeof(obj[p]) == "object") {
    		ret += indent + p + " : ";
    		ret += showInfo(obj[p], indent + "    ");
    	}
    	else
    		ret += "<span style='white-space:pre;'>" + indent + "</span>"
    			+ p + " : " + obj[p] + " ";
    }  
    return ret;
} 

function showInfoChangeLine(obj, indent) {
    var ret = "";
    for(var p in obj) {
    	if(typeof(obj[p]) == "function")
    		continue;
    	if(typeof(obj[p]) == "object") {
    		ret += indent + p + " : <br/>";
    		ret += showInfoChangeLine(obj[p], indent + "    ");
    	}
    	else {
    		ret += "<span style='white-space:pre;'>" + indent + "</span>"
    			+ p + " : " + obj[p] + "<br/>";
    	}
    }  
    return ret;
}

function search(){
	var question = document.getElementById("question").value;
	var type = document.getElementById("type").value;
	console.log(question + " " + type);
	$.ajax({
		url: "/ironman/query",
		data: {
			question : encodeURI(question),
			type : encodeURI(type)
		},
		type : "GET",
		async : true,
		dataType : "json",
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		success : function(json){
			details = {};
			$("#answer").empty();
			$("#answer").append("<p>共搜索到" + json.totalHits + "个结果</p><br/>");
			for(var i = 0; i < json.totalHits; i ++) {
				var scoreID = "score" + i;
				var sourceID = "source" + i;
				//$("#answer").append(showInfoChangeLine(JSON.parse(json[sourceID]), ""));
				details[i] = showInfoChangeLine(JSON.parse(json[sourceID]));
				$("#answer").append("<p style=\"width:600px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;\">"
					+ "<a href=\"#\" onclick=\"showDetail(" + i + ")\">"
					+ showInfo(JSON.parse(json[sourceID]), "") + "</a>");
				$("#answer").append("    相关度 : " + json[scoreID] + "</p><br/>");
			}
			//console.log(details);
			document.close();
		},
		error : function(xhr, status){
			console.log("error");
			return false;
		},
		complete : function(xhr, status){
			console.log("complete");
		}
	});
}
</script>
</html>