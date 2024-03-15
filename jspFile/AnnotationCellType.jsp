<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>CardioAtlas</title>
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/css/style.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="css/style_FileUpLoad.css">
	<script src="js/73a252e5a4.js" ></script>
  	<script src="js/xm-select.js" ></script>
</head>
<style>
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
						<li ><a href="AnnotationCellType.jsp" class="menu-top-active">Function</a></li>
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
<!--                 <h4 class="header-line1">Annotation Celltype</h4> -->
                <div class="row checkboxline">
	                <div class="col-md-12 col-sm-12" >
	                	 <div class="alert alert-info">
	                	 	<strong class="strong1">File Preparation</strong><br />
	                	 	<div class="attention-div">
	                	 		<span><i class="fa-solid fa-circle-exclamation attention-li" ></i> The matrix must be genes (rows) by cells (columns). The row names should be the cell IDs and the column names should be the gene names.</span><br />
	                	 		<span><i class="fa-solid fa-circle-exclamation attention-li"></i> The data must be delimited by tabs.</span><br />
	                	 		<span><i class="fa-solid fa-circle-exclamation attention-li"></i> Uploaded data CAN NOT contain negative values. The normalization of TPM, FPKM, or count are acceptable.</span><br />
	                	 		<span><i class="fa-solid fa-circle-exclamation attention-li"></i><a href="download_loading.jsp?path=0_files/mat_example.txt&name=exampleExpressionFile.txt"> Download example file </a> </span><br />
	                	 	</div>
               			</div>							 												
               										
	                </div>	 
	                <div class="col-md-12 col-sm-12" >
	                	 <div class="alert alert-info">
	                	 	<strong class="strong1">Data Privacy</strong><br />
	                	 	<div class="attention-div">
	                	 		<span><i class="fa-solid fa-circle-exclamation attention-li"></i> All your data will be kept on this computer.</span><br />
	                	 		<span><i class="fa-solid fa-circle-exclamation attention-li"></i> If you run the analysis, only cell location and cell expression data will be sent to the remote server.</span><br />
	                	 		<span><i class="fa-solid fa-circle-exclamation attention-li"></i> The email address will noly be used to generate a unique job ID and notify you when the job is completed.</span><br />
	                	 		<span><i class="fa-solid fa-circle-exclamation attention-li"></i> Our server does not preserve any user data.</span><br />
	                	 	</div>
               			</div>							 																			
	                </div>               	                
                </div>
            </div>			
        </div>
           <div class="row">
                <div class="col-md-5 col-sm-5" >
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <strong class="strong-title"> Data Upload</strong>
                        </div>
                        <div class="panel-body">
                            <div id="uploadFile" style="height:172px;">
                            	<div class="item">
									<div class="addImg"  style="text-align:center;">															                
												<i  class="fa-solid fa-cloud-arrow-up" style="margin-top:51px; font-size:70px;"></i>															                
									</div>
									<input name="url" type="file" class="upload_input" id="upload_file_score" onchange="change(this)" />
									<div class="preBlock">
										<table style="margin:auto;height: 100%;font-size:18px;display:none;" id="FileSuccessNameTable">
											<tr>
												<td><i style="font-size:50px;" class="fa-solid fa-file-lines"  ></i></td>
												<td style="width:10px;"><p> : </p></td>
												<td><p id="FileSuccessName" ></p></td>
											</tr>
										</table>						                						             									
									</div>
									<div class="delete" id="del">×</div>
								</div>
                            </div>
                        </div>
                    </div>
                </div>
                
                 <div class="col-md-7 col-sm-7" >
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <strong class="strong-title"> Special Parameters</strong>
                            
                        </div>
                        <div class="panel-body">
                            <table style="width:100%;margin-bottom:10px;border-collapse:separate;border-spacing:10px">
                                	<tr>
                                		<td class="td1">Reference :</td>
                                		<td style="width:80%"><span id="share_reference" ></span></td>
                                	</tr>
                                	<tr>
                                		<td class="td1">Resolution :</td>
                                		<td style="width:80%"><span ><input id="resolution" name="resolution" class="input-use" type="search" placeholder=" e.g. 0.5" ></span></td>
                                	</tr>
                                	<tr>
                                		<td class="td1">Email address : </td>
                                		<td style="width:80%"><span ><input id="email_address" name="email_address" class="input-use" type="search" placeholder=" e.g. #####@gmail" ></span></td>
                                	</tr>
                                </table>
                        </div>
                        
                    </div>
                </div>
<!--                 text-align:center;margin-top:30px; -->
                <div class="col-md-12 col-sm-12" >
                	<div style="margin:0 auto;text-align:center;margin-top:30px;">
	                	<table style="border-collapse:separate;border-spacing:10px">
	                		<tr>
	                			<td> <button class="btn btn-danger botton-submit" onclick="GoQC()"><i class="fa-solid fa-magnifying-glass-arrow-right panel-li" ></i> START TASK </button></td>
	                			<td> <button class="btn btn-danger botton-submit" onclick="goRest()"><i class="fa-solid fa-arrow-rotate-left panel-li"></i> RESET </button></td>
	                			<td> <button class="btn btn-danger botton-submit" onclick="goExample()"><i class="fa-regular fa-eye panel-li"></i> ANALYSIS EXAMPLE </button></td>
	                		</tr>
	                	</table>
                	</div>
                </div>
                
                
                <div id="taskIdShow" class="col-md-10 col-sm-10 col-xs-12" style="margin-top:30px;display:none;">
                	<div class="alert alert-success alert-dismissable">
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
						
						<span> <p id="" style="font-size:20px;font-weight:500;color:black">Task submitted successfully. </p></span>
						<span> <p id="taskIdShowContent" style="font-size:20px;font-weight:500;color:black"> </p></span>
						<span> <p id="" style="font-size:20px;font-weight:500;color:black">QC will be conducted soon, please be patient. </p></span>	
					</div>
                </div>
                <div id="taskIdShowError" class="col-md-10 col-sm-10 col-xs-12" style="margin-top:30px;display:none;">
                	<div class="alert alert-success alert-dismissable">
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
						
						<p id="" style="font-size:20px;font-weight:500;color:black">There is an error in the task please check your upload file. </p>
						
					</div>
                </div>
            </div>

         
             
                    
            
                    <!-- /. ROW  -->
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
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
    <script src="js/AnnotationCellType.js"></script>
      <!-- CUSTOM SCRIPTS  -->
<!--     <script src="assets/js/custom.js"></script> -->

   
</body>
</html>