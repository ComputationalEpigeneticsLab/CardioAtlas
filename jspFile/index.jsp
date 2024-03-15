<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>CardioAtlas</title>
<link href="assets/css/bootstrap.css" rel="stylesheet" />
<link href="assets/css/font-awesome.css" rel="stylesheet" />
<link href="assets/css/style.css" rel="stylesheet" />
<link href='css/fonts.googleapis.css' rel='stylesheet' type='text/css' />
<script src="js/73a252e5a4.js" ></script>
</head>
<style>
.title_dabase{
	font-family: 'Montserrat', sans-serif;
    font-size: 40px;
    font-weight: 700;
    margin-bottom: 10px;
    color: black;
    }
.summary{
	margin-bottom:0px;
	font-family: 'Roboto', sans-serif; 
	color:;font-size:22px !important;
	margin-top:10px;
	margin-right:10px;
	text-align: justify;
	text-justify: distribute-all-lines;
	text-align-last: justify; 
	-moz-text-align-last: justify;
	-webkit-text-align-last: justify;
}
.input-use{height:50px;width:70%;margin-left:30%;padding: 0.375rem 0.75rem;font-size: 1rem;line-height: 1.5;color: #495057;background-color: #fff;background-clip: padding-box;border: 1px solid #ced4da;border-radius: 0.25rem;box-shadow: inset 0 0 0 transparent;font-size:18px;padding-bottom: 10px;}
.botton-submit{background:white;color:black;border-radius:10px;border-color:#ced4da;font-size:20px;height:50px;}
.panel-li{font-size:20px;}
.summary2{font-family: 'Roboto', sans-serif; color:;font-size:22px !important;font-weight:600;margin-bottom:5px;}
.widthTD{width:5px;}
</style>
<body>

<section class="menu-section">
	<div class="container">
		<div class="row ">
			<div class="col-md-12">
				<div class="navbar-collapse collapse ">
					<ul id="menu-top" class="nav navbar-nav navbar-right">
						<li><a class="navbar-brand" href="index.jsp">
							<img src="assets/img/logo_2.png" / style="width:150px;height:60px;margin-top:-20px;">
						</a>
						</li>
						<li><a href="index.jsp" class="menu-top-active">home</a></li>
						<li><a href="Browse.jsp">Browse</a></li>
						<li>
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

<div class="content-wrapper">
	 <div class="container">
		 <div class="row" style="margin-top:20px;">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<h1 class="title_dabase"><strong >CardioAtlas : decipersing the single-cell transcriptome landscape in cardiovascular tissues and diseases </strong></h1>
				<div style="margin-top:20px;">
                    <p  class="summary">
                    	Advances in single-cell RNA sequencing (scRNA-seq) technologies have enabled the profiling and analysis of the transcriptomes of single cells at unprecedented resolution and throughput. Increasing scRNA-seq data in cardiovascular research have substantially improved our knowledge on the development of the cardiovascular system and the mechanisms underlying cardiovascular diseases. CardioAtlas is an integrated resource for cell type clustering and annotation in cardiovascular diseases. 
Here, we collected 27 single-cell RNA-seq projects of humans and 39 single-cell RNA-seq projects of mouse, including ~1929k and ~1800k cells, respectively. Through large-scale literature retrieval and manual annotation, we constructed 12 and 15 scRNA-seq reference atlas for common human and mouse cardiovascular diseases and health tissues, covering 43 and 39 cell types.

                    <strong>CardioAtlas </strong>provides six major analytic module that allow users to interactively explore the annotations of cell types in human and mouse cardiovascular tissues and diseases.
                    </p>
                    <table class="summary2">
                                		<tr>
                                			<td>I)</td>
                                			<td class="widthTD"></td>
                                			<td >Cell  clustering and cell type annotating; </td>
                                		</tr>
                                		<tr>
                                			<td>II)</td>
                                			<td class="widthTD"></td>
                                			<td>The list and expression of marker genes across cell types;</td>
                                		</tr>
                                		<tr>
                                			<td>III)</td>
                                			<td class="widthTD"></td>
                                			<td> Functional  functional assignment of each cell type in cell cycle, cancer hallmarks, cell states and immune pathways;</td>
                                		</tr>
                                		<tr>
                                			<td>IV)</td>
                                			<td class="widthTD"></td>
                                			<td>Identification of cell-type-specific transcription regulons;</td>
                                		</tr>
                                		<tr>
                                			<td>V)</td>
                                			<td class="widthTD"></td>
                                			<td>cell-cell communications and corresponding ligand-receptor interactions;</td>
                                		</tr>
                                		<tr>
                                			<td> VI)</td>
                                			<td class="widthTD"></td>
                                			<td>useful online tools for annotating the single-cell transcriptome uploaded by users.</td>
                                		</tr>
                                	</table>
                </div>
			</div>
<!-- 			 <div class="col-md-4 col-sm-4 col-xs-12"> -->
<!-- 				<div id="carousel-example" class="carousel slide slide-bdr" data-ride="carousel" > -->
			   
<!-- 				<div class="carousel-inner"> -->
<!-- 					<div class="item active"> -->

<!-- 						<img src="assets/img/1.jpg" alt="" /> -->
					   
<!-- 					</div> -->
<!-- 					<div class="item"> -->
<!-- 						<img src="assets/img/2.jpg" alt="" /> -->
					  
<!-- 					</div> -->
<!-- 					<div class="item"> -->
<!-- 						<img src="assets/img/3.jpg" alt="" /> -->
					   
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				INDICATORS -->
<!-- 				 <ol class="carousel-indicators"> -->
<!-- 					<li data-target="#carousel-example" data-slide-to="0" class="active"></li> -->
<!-- 					<li data-target="#carousel-example" data-slide-to="1"></li> -->
<!-- 					<li data-target="#carousel-example" data-slide-to="2"></li> -->
<!-- 				</ol> -->
<!-- 				PREVIUS-NEXT BUTTONS -->
<!-- 				 <a class="left carousel-control" href="#carousel-example" data-slide="prev"> -->
<!-- 				<span class="glyphicon glyphicon-chevron-left"></span> -->
<!-- 				</a> -->
<!-- 				<a class="right carousel-control" href="#carousel-example" data-slide="next"> -->
<!-- 				<span class="glyphicon glyphicon-chevron-right"></span> -->
<!-- 				</a> -->
<!-- 			  </div> -->
<!-- 		  </div> -->
			
		</div>
		<div class="row" style="margin-top:50px;">
			<div class="col-md-12 col-sm-12 col-xs-12" >
				<table  style="width:100%">
	                	 	<tr>
<!-- 	                	 		<td > Task ID :</td> -->
<!-- 	                	 		<td style="width:10px;"></td> -->
	                	 		<td "><span><input id="taskid" name="taskid" class="input-use" type="search" placeholder=" Input your task ID" ></span></td>
	                	 		<td style="width:30px;"></td>
	                	 		<td><button class="btn btn-danger botton-submit" onclick="taskQuery()"><i class="fa-solid fa-magnifying-glass-arrow-right panel-li" ></i> Submit</button></td>
	                	 	
	                	 </table>
			</div>
		</div>
		<div class="row" style="margin-top:50px;">
			<div class="col-md-12 col-sm-12 col-xs-12" >
				<object data="img/webHome.svg" type="image/svg+xml" style="width:100%;">   </object> 
			</div>
		</div>
		<div class="row" style="margin-top:50px;">
			 <div class="col-md-3 col-sm-3 col-xs-6">
				  <div class="alert alert-success back-widget-set text-center">
						<i class="fa-solid fa-database" style="font-size:70px;"></i>
						<h3>No. of Human Disease : 12 </h3>
						<h3>No. of Mouse Disease : 15 </h3>
					</div>
				</div>
				
			<div class="col-md-3 col-sm-3 col-xs-6">	
				<div class="alert alert-success back-widget-set text-center">
						<i class="fa-solid fa-database" style="font-size:70px;"></i>
						
						<h3>No. of Human Datasets : 27</h3>
						<h3>No. of Mouse Datasets : 39</h3>
					</div>
				</div>
				
			 <div class="col-md-3 col-sm-3 col-xs-6">
			 		
				  <div class="alert alert-success back-widget-set text-center">
						<i class="fa fa-bars fa-5x"></i>
						<h3>No. of Human Cell : 1929k</h3>
						<h3>No. of Mouse Cell : 1088k</h3>
					</div>
				</div>
		  <div class="col-md-3 col-sm-3 col-xs-6">
				  <div class="alert alert-success back-widget-set text-center">
						<i class="fa fa-bars fa-5x"></i>
						<h3>No. of Human Cell type : 43</h3>
						<h3>No. of Mouse Cell type : 39</h3>
					</div>
				</div>
	</div>              
		


		 

</div>
</div>
<section class="footer-section">
        <div class="container">
            <div class="row">
            	<div class="col-md-12">
            		<div style="margin-left:20px;margin-top:10px;margin-bottom:10px;"><p ><strong style="margin-left:2px;font-size:35px;color:;">Contact </strong></p></div>
						<table style="width:96%;margin-left:2%;" >
							<tr>
								<td style="width:200px;"><p  style="margin-left:2px;font-size:25px;color:;">	Yongsheng li,   </p></td>
								<td><p  style="margin-left:2px;font-size:22px;color:;">	Email  : liyongsheng@ems.hrbmu.edu.cn </p></td>
								<td rowspan="3">
									<div style="height:140px;width:240px;margin-top:-130px;">
									<script type="text/javascript" src="//rf.revolvermaps.com/0/0/6.js?i=5zaqx818ov9&amp;m=7&amp;c=e63100&amp;cr1=ffffff&amp;f=arial&amp;l=0&amp;bv=90&amp;lx=-420&amp;ly=420&amp;hi=20&amp;he=7&amp;hc=a8ddff&amp;rs=80" async="async"></script>
									</div>
								</td>
							</tr>
							<tr>
								<td style="width:200px;"><p  style="margin-left:2px;font-size:25px;color:;">	Juan Xu,   </p></td>
								<td><p  style="margin-left:2px;font-size:22px;color:;">	Email  : xujuanbiocc@ems.hrbmu.edu.cn </p></td>
							</tr>
							
<!-- 							<tr> -->
<!-- 								<td style="width:200px;"><p  style="margin-left:2px;font-size:25px;color:;"> Yunpeng Zhang,   </p></td> -->
<!-- 								<td><p  style="margin-left:2px;font-size:22px;color:;">	Email  : zhangyp@hrbmu.edu.cn </p></td> -->
<!-- 							</tr> -->
							
						</table>
					  	<div style="margin-left:10px;margin-top:20px;">
							<p  style="margin-left:2px; font-size:20px;color:;">	Copyright &copy; 2023.Harbin Medical University </p>
						</div>
            	</div>
            </div>
        </div>
    </section>
<script src="assets/js/jquery-1.10.2.js"></script>
<script src="assets/js/bootstrap.js"></script>
<script src="assets/js/custom.js"></script>
<script src="js/home.js"></script>

</body>
</html>
