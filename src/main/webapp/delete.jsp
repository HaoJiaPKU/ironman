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
						<li class="active">
							<a href="delete.jsp">删除</a>
						</li>
						<li>
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
					<div class="row-fluid">
						<label>资源定位（URI） : </label>
					</div>
					<br/>
					<div class="row-fluid">
						<label class="control-label" style="float:left; margin:5px">_index : 
							<input id="_index" value="test"/>
						</label>
						<label class="control-label" style="float:left; margin:5px">_type : 
							<input id="_type" value="product"/>
						</label>
						<label class="control-label" style="float:left; margin:5px">_id : 
							<input id="_id" value="1"/>
						</label>
						<button onclick="deleteFunc()" class="btn btn-info" style="width:100px;">删除</button>
						<button onclick="" class="btn btn-info" style="width:100px;">重置</button>
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
function deleteFunc(){
	var index = encodeURI(document.getElementById("_index").value);
	var type = encodeURI(document.getElementById("_type").value);
	var id = encodeURI(document.getElementById("_id").value);
	
	console.log(index + " " + type + " " + id);
	$.ajax({
		url: "/ironman/" + index + "/" + type + "/" + id,
		data: {},
		type : "DELETE",
		async : true,
		dataType : "json",
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		success : function(json){
			
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