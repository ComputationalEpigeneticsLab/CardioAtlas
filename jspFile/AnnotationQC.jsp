<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
   
    <title>CardioAtlas</title>
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/css/style.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/style_FileUpLoad.css">
    <link rel="stylesheet" href="css/fonts.googleapis.css">
  	<link rel="stylesheet" href="ionslider/ion.rangeSlider.css">
  	<link rel="stylesheet" href="ionslider/ion.rangeSlider.skinNice.css">
 	<link rel="stylesheet" href="bootstrap-slider/slider.css">
	<script src="js/73a252e5a4.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" type="text/css" href="css/layui.css" />
	<script type="text/javascript" language="javascript" src="js/layui.js"></script>
	<script src="js/layer.js"></script>
  	<script src="js/xm-select.js" ></script>
</head>
<style>

.silde-table{width:100%;margin-bottom:0px;border-collapse:separate;border-spacing:5px}
.slider_input_exp{	border-style: none;background:white;color:#bd2130;width:80px;text-align:center;font-size:18px;}
.p1{font-size:18px;color:black;font-weight:600;}
.td1{font-size:18px;color:black;font-weight:600;}
.strong-title{color:black;font-size:20px;}
.attention-li{color:#f0ad4e;}
.attention-div{margin-left:30px;margin-top:10px;font-size:16px;}
.strong1{color:black;font-size:18px;}
.botton-submit{background:white;color:black;border-radius:10px;border-color:#ced4da;font-size:20px;height:60px;font-weight:600;}
.panel-body-font{font-size:25px;}
.panel-up-ww{background:white;color:black;border-radius:10px;border-color:#dff0d8;pointer-events:none;font-size:;}
.panel-down-ww{background:;color:;border-radius:10px;border-color:#faebcc;}
.panel-down-ww-a{color:white;font-size:px;text-decoration:none;}
.panel-down-ww-dataset{color:gray;font-size:16px;text-decoration:auto;}
.panel-li{font-size:25px;color:#f0ad4e;}
.header-line1{font-weight: 900;padding-bottom: 10px;text-transform: uppercase}
.checkboxline{padding-bottom: 0px;border-bottom: 1px solid #eeeeee;}
.input-use{height:40px;width:100%;padding: 0.375rem 0.75rem;font-size: 1rem;line-height: 1.5;color: #495057;background-color: #fff;background-clip: padding-box;border: 1px solid #ced4da;border-radius: 0.25rem;box-shadow: inset 0 0 0 transparent;font-size:18px;padding-bottom: 10px;}
</style>
<body>
<%
String taskID=request.getParameter("UserTaskID");			
%>
<input name="UserTaskID"  id="UserTaskID" type="hidden" value=<%=request.getParameter("UserTaskID") %> >

    <section class="menu-section">
	<div class="container">
		<div class="row ">
			<div class="col-md-12">
				<div class="navbar-collapse collapse ">
					<ul id="menu-top" class="nav navbar-nav navbar-right">
						<li><a class="navbar-brand" href="index.jsp">
							<img src="assets/img/logo_2.png" / style="width:150px;height:60px;margin-top:-20px;">
						</a>
						<li><a href="index.jsp" >home</a></li>
					   
						<li><a href="Browse.jsp">Browse</a></li>
						<li >
							<a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown">Search <i class="fa fa-angle-down"></i></a>
							<ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem" >
								<li role="presentation"><a role="menuitem" tabindex="-1" href="SearchAtlas.jsp" class="font-1" >Atlas</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1" href="SearchDatasets.jsp" class="font-1">Datasets</a></li>
							</ul>
						</li>
						<li><a href="AnnotationCellType.jsp">Function</a></li>
						<li><a href="Help.jsp">Help</a></li>

					</ul>
				</div>
			</div>

		</div>
	</div>
</section>
     <!-- MENU SECTION END-->
    <div class="content-wrapper">
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line" style="font-size:25px;">Define quality control conditions</h4>
                
            </div>			
        </div>
           <div class="row">
           	<div class="col-md-8 col-sm-8" >
           		<div class="panel panel-success">
                    <div class="panel-heading">
                        <strong class="strong-title"> Data distribution</strong>
                    </div>
                    <div class="panel-body">
                        <div class="row" style="min-height:510px;">
                        	<div class="col-md-12 col-sm-12" >
			               		<div id="QC_violin_nFeature_RNA" class="col-md-4 col-sm-4" ></div>
			               		<div id="QC_violin_nCount_RNA" class="col-md-4 col-sm-4" ></div>
			               		<div id="QC_violin_percent_mt" class="col-md-4 col-sm-4" ></div>
		               		</div>
		               	</div>
                    </div>
                 </div>
           	</div>
            <div class="col-md-4 col-sm-4" >
            	<div class="panel panel-success">
                    <div class="panel-heading">
                        <strong class="strong-title"> Parameters</strong>
                    </div>
                    <div class="panel-body">
<!-- ######## nFeature_RNA_slider                     -->
                    	<table class="silde-table" >
<!--                     	border="1" -->
							<tr>
								<td> <p class="p1">nFeature RNA :</p>	</td>
								<td ><input class="slider_input_exp" id="nFeature_RNA_form" type="text" name="nFeature_RNA_form" value=" "> </td>
								<td style="width:15px;text-align:center">~</td>
								<td ><input class="slider_input_exp" id="nFeature_RNA_to" type="text" name="nFeature_RNA_to" value=" "> </td>
							</tr>
						</table>
                        <span><input id="nFeature_RNA_slider" type="text" name="nFeature_RNA_slider" value="" ></span><br />
<!-- ######## nCount_RNA_slider                     -->   
                     	<table class="silde-table" >
							<tr>
								<td> <p class="p1">nCount RNA :</p>	</td>
								<td ><input class="slider_input_exp" id="nCount_RNAt_form" type="text" name="nCount_RNAt_form" value=" "> </td>
								<td style="width:15px;text-align:center">~</td>
								<td ><input class="slider_input_exp" id="nCount_RNA_to" type="text" name="nCount_RNA_to" value=" "> </td>
							</tr>
						</table>
                        <span><input id="nCount_RNA_slider" type="text" name="nCount_RNA_slider" value="" ></span><br />
                        
<!-- ######## percent_mt_slider                     -->
						<table class="silde-table" >
							<tr>
								<td> <p class="p1">% percent MT :</p>	</td>
								<td ><input class="slider_input_exp" id="percent_mt_form" type="text" name="percent_mt_form" value=" "> </td>
								<td style="width:15px;text-align:center">~</td>
								<td ><input class="slider_input_exp" id="percent_mt_to" type="text" name="percent_mt_to" value=" " > </td>
							</tr>
						</table>
                        <span><input id="percent_mt_slider" type="text" name="percent_mt_slider" value=""></span> <br />                         
                    </div>
                 </div>
                
            </div>
            <div class="col-md-12 col-sm-12" style="text-align:center;margin-top:30px;">
                	<button class="btn btn-danger botton-submit" onclick="goContinue()"><i class="fa-solid fa-magnifying-glass-arrow-right panel-li" ></i> CONTINUE TASK </button>
                </div>
                
            <div id="taskIdShow" class="col-md-12 col-sm-12 col-xs-12" style="margin-top:30px;display:none;">
                	<div class="alert alert-success alert-dismissable">
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
						
						<span> <p id="" style="font-size:20px;font-weight:500;color:black">Continue the task . </p></span>
						<span> <p id="taskIdShowContent" style="font-size:20px;font-weight:500;color:black"> </p></span>
						<span> <p id="" style="font-size:20px;font-weight:500;color:black">You can wait for the results here or we will inform you by email when the task is completed and you can access the results by task id. </p></span>	
					</div>
                </div>
                <div id="taskIdShowError" class="col-md-12 col-sm-12  col-xs-12" style="margin-top:30px;display:none;">
                	<div class="alert alert-success alert-dismissable">
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
						
						<p id="" style="font-size:20px;font-weight:500;color:black">There is an error in the task please check your upload file. </p>
						
					</div>
                </div>
            </div>

    </div>
    </div>

    <section class="footer-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12" style="font-size:16px;">
                   Copyright &copy; 2023.Harbin Medical University </div>

            </div>
        </div>
    </section>
    
    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.js"></script>
<script src="ionslider/ion.rangeSlider.min.js"></script>
<script src="bootstrap-slider/bootstrap-slider.js"></script>
<script type="text/javascript" language="javascript" src="js/base/plotly-2.6.3.min.js"></script>
<script type="text/javascript" language="javascript" src="js/base/d3.min.js"></script>
 <script src="js/AnnotationQC.js"></script>
<script>
taskID='<%=taskID %>';
var webpath="upload"+"/"+taskID;
//webpath="upload_email/example";
$.getJSON(webpath+"/qc_re.txt", "", function(data) {
	if(data.error_attention=="no"){
		//violin
		var path_plotly_violin_nFeature=webpath+"/"+data.qc_violin_nFeature_RNA;
		plotly_violin_nFeature(path_plotly_violin_nFeature);
		var path_plotly_violin_nCount=webpath+"/"+data.qc_violin_nCount_RNA;
		plotly_violin_nCount(path_plotly_violin_nCount);
		var path_plotly_violin_percent_mt=webpath+"/"+data.qc_violin_percent_mt;
		plotly_violin_percent_mt(path_plotly_violin_percent_mt);
		//slider
		 $('#nFeature_RNA_slider').ionRangeSlider({
			  min     : 0,
			  max     : Number(data.slider_nFeature_max),
			  from    : Number(data.slider_nFeature_from),
			  to      : Number(data.slider_nFeature_to),
			  type    : 'double',
			  step    : 1,
			  //prefix  : '$',
			  prettify: false,
			  hasGrid : true,
				onChange: function (data) {
				var from = data["fromNumber"];
				var to = data["toNumber"];
				document.getElementById("nFeature_RNA_form").value=from;
				document.getElementById("nFeature_RNA_to").value=to;
				}
			});
			$('#nCount_RNA_slider').ionRangeSlider({
				min     : 0,
				max     : Number(data.slider_nCount_max),
				from    : Number(data.slider_nCount_from),
				to      : Number(data.slider_nCount_to),
				type    : 'double',
				step    : 1,
				//prefix  : '$',
				prettify: false,
				hasGrid : true,
				  onChange: function (data) {
					var from = data["fromNumber"];
					var to = data["toNumber"];
					document.getElementById("nCount_RNAt_form").value=from;
					document.getElementById("nCount_RNA_to").value=to;
				  }
			  });
			$('#percent_mt_slider').ionRangeSlider({
				min     : 0,
				max     : Number(data.slider_mt_max),
				from    : Number(data.slider_mt_from),
				to      : Number(data.slider_mt_to),
				type    : 'double',
				step    : 1,
				//prefix  : '$',
				postfix:'%',
				prettify: false,
				hasGrid : true,
				onChange: function (data) {
				var from = data["fromNumber"];
				var to = data["toNumber"];
				document.getElementById("percent_mt_form").value=from;
				document.getElementById("percent_mt_to").value=to;
				//console.log(document.getElementById("percent_mt_form").value);
				}
			});
	}else{
		//go to
	}
	
	
});
  

</script>
   
</body>
</html>