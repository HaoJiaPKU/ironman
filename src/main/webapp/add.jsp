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
						<li class="active">
							<a href="add.jsp">添加</a>
						</li>
						<li>
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
						<button onclick="add()" class="btn btn-info" style="width:100px;">添加</button>
						<button onclick="" class="btn btn-info" style="width:100px;">重置</button>
					</div>
				</div>
				<br/>
				
				<div class="row-fluid">
					<div class="row-fluid">
						<label>关联属性 :
							<button onclick="addField()" class="btn btn-info" style="width:100px;">添加属性</button>
						</label>
					</div>
					<br/>
					<div class="row-fluid">
						<table id="fields" class="table table-striped table-hover">
							<tr id="field0">
								<td style="width:15px;">-></td>
								<td>
									<button onclick="deleteField()" class="btn btn-info" style="width:60px;">删除</button>
									<button onclick="addValue(0)" class="btn btn-info" style="width:100px;">添加值</button>
									<button onclick="addSubField(0)" class="btn btn-info" style="width:130px;">添加子属性</button>
									<label class="control-label" style="margin-top:5px;">
										<span style="white-space:pre;">属性 : </span> 
										<input id="key0_0" value="型號"/>
									</label>
									<label class="control-label" style="margin-top:5px;">
										<span style="white-space:pre;">值     : </span>  
										<input id="value0_0" value="PMC-24V075W1AA"/>
									</label>
								</td>
							</tr>
						</table>
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
var fieldCount = 0;
var valueCount = 0;
var map = {};

function addField() {
	fieldCount ++;
	valueCount ++;
	$("#fields").append("<tr id=\"field" + fieldCount + "\">"
			+ "\n<td style=\"width:15px;\">-></td>"
			+ "\n<td>"
			+ "\n<button onclick=\"deleteField()\" class=\"btn btn-info\" style=\"width:60px;\">删除</button>"
			+ "\n<button onclick=\"addValue(" + fieldCount + ")\" class=\"btn btn-info\" style=\"width:100px;\">添加值</button>"
			+ "\n<button onclick=\"addSubField(" + fieldCount + ")\" class=\"btn btn-info\" style=\"width:130px;\">添加子属性</button>"
			+ "\n<label class=\"control-label\" style=\"margin-top:5px;\">"
			+ "\n<span style=\"white-space:pre;\">属性 : </span>"
			+ "\n<input id=\"key" + fieldCount + "_" + valueCount + "\" value=\"\"/>"
			+ "\n</label>"
			+ "\n<label class=\"control-label\" style=\"margin-top:5px;\">"
			+ "\n<span style=\"white-space:pre;\">值     : </span>"
			+ "\n<input id=\"value" + fieldCount + "_" + valueCount + "\" value=\"\"/>"
			+ "\n</td>"
			);
}

function deleteField() {
	$(event.target).parent().parent().remove();
}

function addValue(currenField) {
	valueCount ++;
	$(event.target).parent()
		.append("<label class=\"control-label\" style=\"margin-top:5px;\">"
			+ "\n<span style=\"white-space:pre;\">值     : </span>"
			+ "\n<input id=\"value" + currenField + "_" + valueCount + "\" value=\"\"/>"
			+ "\n</label>");
}

function addSubField(fieldID) {
	fieldCount ++;
	valueCount ++;
	$("#field" + fieldID).append("<tr id=\"field" + fieldCount + "\">"
			+ "\n<td style=\"width:15px;\">-></td>"
			+ "\n<td>"
			+ "\n<button onclick=\"deleteField()\" class=\"btn btn-info\" style=\"width:60px;\">删除</button>"
			+ "\n<button onclick=\"addValue(" + fieldCount + ")\" class=\"btn btn-info\" style=\"width:100px;\">添加值</button>"
			+ "\n<button onclick=\"addSubField(" + fieldCount + ")\" class=\"btn btn-info\" style=\"width:130px;\">添加子属性</button>"
			+ "\n<label class=\"control-label\" style=\"margin-top:5px;\">"
			+ "\n<span style=\"white-space:pre;\">属性 : </span>"
			+ "\n<input id=\"key" + fieldCount + "_" + valueCount + "\" value=\"\"/>"
			+ "\n</label>"
			+ "\n<label class=\"control-label\" style=\"margin-top:5px;\">"
			+ "\n<span style=\"white-space:pre;\">值     : </span>"
			+ "\n<input id=\"value" + fieldCount + "_" + valueCount + "\" value=\"\"/>"
			+ "\n</td>"
			);
}

function siblings(elm) {
	var a = [];
	var p = elm.parentNode.children;
	var i = 0;
	for(i = 0; i < p.length; i ++) {
		if(p[i] === elm)
			break;
	}
	for(i = i + 1; i < p.length; i ++) {
		//console.log(p[i]);
		a.push(p[i]);
	}
	return a;
}

function fillMap(rows) {
	var tempMap = {};
	for(var i = 0; i < rows.length; i ++) {
		if(rows[i].id) {
			var inputs = rows[i].cells[1].getElementsByTagName("input");
			var key = inputs[0].value;
			var valueArray = [];
			//console.log(inputs);
			//console.log(inputs.length);
			for(var j = 1; j < inputs.length; j ++) {
				valueArray.push(inputs[j].value);
			}
			/*
			var cellChildren = rows[i].cells[1].childNodes;
			var key;
			for(var j = 0; j < cellChildren.length; j ++) {
				if(cellChildren.item(j).id && cellChildren.item(j).id.indexOf("key") != -1) {
					key = cellChildren.item(j).value;
					break;
				}
			}
			var valueArray = [];
			for(var j = 0; j < cellChildren.length; j ++) {
				if(cellChildren.item(j).id && cellChildren.item(j).id.indexOf("value") != -1) {
					valueArray.push(cellChildren.item(j).value);
				}
			}
			*/
			var sibling = siblings(rows[i].cells[1]);
			if(sibling.length != 0) {
				tempMap[key] = fillMap(sibling);
			}
			else {
				if(valueArray.length == 1)
					tempMap[key] = valueArray[0];
				else
					tempMap[key] = valueArray;
			}
		}
	}
	JSON.stringify(tempMap);
	return tempMap;
}

function add() {
	var index = encodeURI(document.getElementById("_index").value);
	var type = encodeURI(document.getElementById("_type").value);
	var id = encodeURI(document.getElementById("_id").value);
	
	var table = document.getElementById("fields");
	var rows = table.rows;
	map = fillMap(rows);//将表格里的数据取出装入map
	/*
	for(var i = 0; i < rows.length; i ++) {
		if(rows[i].id) {
			var key = rows[i].cells[1].childNodes.item(2).value;
			var value = rows[i].cells[1].childNodes.item(7).value;
			map[key] = value;
		}
	}
	
	var table = document.getElementById("fields");
	var rows = table.rows;
	for(var i = 0; i < rows.length; i ++) {
		for(var j = 0; j < rows[i].cells.length; j ++) {
			//console.log(rows[i].cells[j]);
		}
		//console.log(rows[i].getElementsByTagName("tr"));
		var subrows = rows[i].getElementsByTagName("tr");
		for(var j = 0; j < subrows.length; j ++) {
			//console.log(subrows[j]);
		}
	}
	*/
	
	/*
	var trs = document.getElementById("fields").childNodes.item(1).childNodes;
	for(var i = 0; i <= trs.length; i ++) {
		if(trs[i].id) {
			var tds = trs[i].getElementsByTagName("td");
			console.log(tds[0].childNodes.item(1).value);
			console.log(tds[1].childNodes.item(1).value);
		}
	}*/
	
	map = JSON.stringify(map);
	console.log(map);
	
	console.log(index + " " + type + " " + id);
	$.ajax({
		url: "/ironman/" + index + "/" + type + "/" + id,
		data: map,
		type : "POST",
		async : true,
		dataType : "json",
		contentType : "application/json",
		success : function(json){
			
		},
		error : function(xhr, status){
			console.log("error");
			return false;
		},
		complete : function(xhr, status){
			console.log("complete");
			body = {};
		}
	});
}
</script>
</html>