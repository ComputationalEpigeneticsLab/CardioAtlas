<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    <link href="css/fonts.googleapis.css" rel="stylesheet" />
	<script src="js/73a252e5a4.js" ></script>
</head>
<style>
.panel-body-font{font-size:25px;}
.panel-up-ww{background:white;color:black;border-radius:10px;border-color:#dff0d8;pointer-events:none;font-size:;}
.panel-down-ww{background:;color:;border-radius:10px;border-color:#faebcc;}
.panel-down-ww-a{color:white;font-size:px;text-decoration:none;}
.panel-li{font-size:18px;}
.header-line1{font-weight: 900;padding-bottom: 10px;text-transform: uppercase}
.checkboxline{padding-bottom: 0px;border-bottom: 1px solid #eeeeee;}
.input-use{height:50px;width:70%;margin-left:30%;padding: 0.375rem 0.75rem;font-size: 1rem;line-height: 1.5;color: #495057;background-color: #fff;background-clip: padding-box;border: 1px solid #ced4da;border-radius: 0.25rem;box-shadow: inset 0 0 0 transparent;font-size:18px;padding-bottom: 10px;}
.botton-submit{background:white;color:black;border-radius:10px;border-color:#ced4da;font-size:20px;height:50px;}
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
						<li class="menu-top-active">
							<a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown">Search <i class="fa fa-angle-down"></i></a>
							<ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem" >
								<li role="presentation"><a role="menuitem" tabindex="-1" href="SearchAtlas.jsp" class="menu-top-active font-1" >Atlas</a></li>
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
    <div class="content-wrapper" >
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <div class="col-md-12">
	                <h4 class="header-line1" style="font-size:25px;">Search Atlas</h4>
	                <div class="row checkboxline">
		                <div class="col-md-12 col-sm-12" >
		                	 <table style="width:100%;margin-bottom:30px;"  >
		                	 	<tr>
		                	 		<td><span><input id="ats" name="ats" class="input-use" type="search" placeholder="e.g.   human / normal / 10x / Gene / Cell Type" ></span></td>
		                	 		<td style="width:30px;"></td>
		                	 		<td><button class="btn btn-danger botton-submit" onclick="searchAts()"><i class="fa-solid fa-magnifying-glass-arrow-right panel-li" ></i> Submit</button></td>
		                	 	
		                	 </table>							 																			
		                </div>	                	                
	                </div>
	           </div>	
<!--                 <div class="row checkboxline"> -->
<!-- 	                <div class="col-md-3 col-sm-3" > -->
<!-- 						<div class="form-group"> -->
<!--                             <label>SPECIES</label> -->
<!--                             <div class="checkbox"> -->
<!--                             	<label> <input type="checkbox" value="" />Human (30)</label> -->
<!--                             </div> -->
<!--                             <div class="checkbox"> -->
<!--                                  <label><input type="checkbox" value="" />Mouse (90)</label> -->
<!--                             </div> -->
<!-- <!--                             <div class="checkbox"> --> 
<!-- <!--                             	<label><input type="checkbox" value="" />Checkbox Example Three</label> --> 
<!-- <!--                             </div> --> 
                                 
<!--                        </div> -->
<!-- 					</div> -->
<!-- 					<div class="col-md-3 col-sm-3" > -->
<!-- 						<div class="form-group"> -->
<!--                             <label>ORGAN</label> -->
<!--                             <div class="checkbox"> -->
<!--                             	<label> <input type="checkbox" value="" />Heart (90)</label> -->
<!--                             </div> -->
<!--                             <div class="checkbox"> -->
<!--                                  <label><input type="checkbox" value="" />Cardiovascular (10)</label> -->
<!--                             </div> -->
                                 
<!--                        </div> -->
<!-- 					</div> -->
					
<!-- 					<div class="col-md-3 col-sm-3" > -->
<!-- 						<div class="form-group"> -->
<!--                             <label>DISEASE</label> -->
<!--                             <div class="checkbox"> -->
<!--                             	<label> <input type="checkbox" value="" />Normal (20) </label> -->
<!--                             </div> -->
<!--                             <div class="checkbox"> -->
<!--                                  <label><input type="checkbox" value="" />Disease1 (10)</label> -->
<!--                             </div> -->
<!--                             <div class="checkbox"> -->
<!--                                  <label><input type="checkbox" value="" />Disease2 (50)</label> -->
<!--                             </div>     -->
<!--                        </div> -->
<!-- 					</div> -->
				
	                
<!--                 </div> -->
                            </div>
			
        </div>
           <div class="row">
           <div id="ats_content" style="max-height:800px;overflow:auto;">
           
           </div>
<!--                 <div class="col-md-4 col-sm-4" id="human_normal_atlas"> -->
<!--                     <div class="panel panel-success"> -->
<!--                         <div class="panel-heading"> -->
<!--                             <table style="width:100%;"> -->
<!--                             	<tr> -->
<!--                             		<td> -->
<!--                             			<button class="btn btn-danger panel-up-ww" ><i class="fa-sharp fa-solid fa-person panel-li" style=""></i> Human</button> -->
<!--                             		</td> -->
<!--                             		<td> -->
<!--                             			<button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-dna panel-li"></i> 10X Genomics </button> -->
<!--                             		</td> -->
<!--                             		<td> -->
<!--                             			<button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-heart-pulse panel-li"></i> Normal</button> -->
<!--                             		</td> -->
<!--                             		<td> -->
<!--                             			<button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-database panel-li"></i> Hert</button> -->
<!--                             		</td> -->
<!--                             	</tr> -->
<!--                             </table> -->
                            
<!--                         </div> -->
<!--                         <div class="panel-body"> -->
<!--                             <table style="width:100%;"> -->
<!--                             	<tr> -->
<!--                             		<td> -->
<!--                             			<span> <strong class="panel-body-font">5.95k </strong> Cells </span> -->
<!--                             		</td> -->
<!--                             		<td> -->
<!--                             			<span> <strong class="panel-body-font">15k </strong> Genes </span> -->
<!--                             		</td> -->
<!--                             		<td> -->
<!--                             			<span> <strong class="panel-body-font">13 </strong> Celltypes</span> -->
<!--                             		</td> -->
<!--                             	</tr> -->
<!--                             </table> -->
<!--                         </div> -->
<!--                         <div class="panel-footer"> -->
<!--                             <span><button class="btn btn-warning panel-down-ww"> <a class="panel-down-ww-a" href="AtlasDetails.jsp?ats=atlas01"><i class="fa-solid fa-binoculars panel-li"></i> View</a></button></span> -->
<!--                             <span style="float:right;"><button class="btn btn-warning panel-down-ww">  <a class="panel-down-ww-a" href="downloadCopy.jsp?name=atlas01"><i class="fa-solid fa-download panel-li"></i> Download</a></button></span> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
                
                
                
               
                
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
    <script src="assets/js/custom.js"></script>
    <script src="js/SearchAtlas.js"></script>
</body>
</html>