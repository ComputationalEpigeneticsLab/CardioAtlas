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
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="assets/css/style.css" rel="stylesheet" />
    <link href="css/fonts.googleapis.css" rel="stylesheet" />
 <script src="js/73a252e5a4.js" crossorigin="anonymous"></script>
  <script src="js/xm-select.js" ></script>
</head>
<style>
.span-advance-left-button-activate{font-size:18px;font-weight:600;background:#faebcc;color:black;border-radius:10px;border-color:#faebcc;width:100%;height:50px;margin-bottom: 10px;}
.span-advance-right-methodDes{font-size:15px;font-weight:600;text-align:left;}
.span-advance-left-button{font-size:18px;font-weight:600;background:white;color:black;border-radius:10px;border-color:#faebcc;width:100%;height:50px;margin-bottom: 10px;}
.span-advance-left-button-a{font-size:18px;font-weight:600;text-decoration:none;color:black;}
.td1{font-size:22px;color:black;font-weight:600;}
.font1{font-size:20px;color:black;font-weight:600;}
.summary-td1{width:30%;font-weight:600;}
.panel-body-font{font-size:25px;}
.panel-up-ww{background:white;color:black;border-radius:10px;border-color:#dff0d8;pointer-events:none;font-size:;}
.panel-down-ww{background:;color:;border-radius:10px;border-color:#faebcc;}
.panel-down-ww-a{color:white;font-size:px;text-decoration:none;}
.panel-li{font-size:16px;width:20px;}
.header-line1{font-weight: 900;padding-bottom: 10px;text-transform: uppercase}
.checkboxline{padding-bottom: 0px;border-bottom: 1px solid #eeeeee;}
.listyle1{width:100px;font-size:20px;text-align:center;font-weight:600;}

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
						<li><a href="index.jsp" >home</a></li>
					   
						<li class="menu-top-active"><a href="Browse.jsp">Browse</a></li>
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
         <div class="container" >
<!--         <div class="row pad-botm"> -->
<!--             <div class="col-md-12"> -->
<!--                 <h4 class="header-line" style="font-size:25px;">Atlas browse</h4> -->
<!--             </div> -->
<!--         </div> -->
            <div class="row" style="margin-top:30px;">
            	<div class="col-md-12 col-sm-12">
                    <div class="panel panel-default">
                        <div class="panel-body" >
                            <ul class="nav nav-tabs" >
                                <li class="active"><a href="#human" data-toggle="tab" style="" class="listyle1">Human</a>
                                </li>
                                <li class=""><a href="#mouse" data-toggle="tab" class="listyle1">Mouse</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade active in" id="human">
                                	<div class="col-md-3 col-sm-3" style="margin-top:0px;">
                                		<img src="img/human_4.png" style="margin-left:-40px;" /> 
                                	</div>
                                	<div class="col-md-9 col-sm-9">
                                		  <div class="panel panel-default" style="margin-top:10px;">
						                        <div class="panel-heading">
						                            <strong style="font-size:20px;"> Cell type annotation and downstream analysis (human) </strong>
						                        </div>
						                        <div class="panel-body">
						                            <div class="table-responsive" style="max-height:480px;overflow:auto;">
						                                <table class="table table-striped" style="font-size:18px; ">
						                                    <thead>
						                                        <tr>
						                                            <th>Tissue</th>
						                                            <th>Disease</th>
						                                            <th>No. of Cell</th>
						                                            <th>No. of Cell type</th>
						                                            <th>Detail</th>
						                                        </tr>
						                                    </thead>
						                                    <tbody>
<tr><td>Heart</td><td>DCM</td><td>202333</td><td>12</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_DCM"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>HCM</td><td>192206</td><td>11</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_HCM"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>HF</td><td>9655</td><td>9</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_HF"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>ICM</td><td>68315</td><td>10</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_ICM"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>MI</td><td>141339</td><td>12</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_MI"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>Normal</td><td>39829</td><td>10</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>CHD</td><td>201704</td><td>13</td><td><a href="AtlasDetails.jsp?ats=atlas_human_CHD"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>CH</td><td>14651</td><td>5</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_CH"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>Normal</td><td>61419</td><td>12</td><td><a href="AtlasDetails.jsp?ats=atlas_human_fetal_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>HLHS</td><td>17714</td><td>10</td><td><a href="AtlasDetails.jsp?ats=atlas_human_HLHS"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>Normal</td><td>26279</td><td>9</td><td><a href="AtlasDetails.jsp?ats=atlas_human_young_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>TOF</td><td>14157</td><td>10</td><td><a href="AtlasDetails.jsp?ats=atlas_human_TOF"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>



<!-- <tr><td>Heart </td><td>Cardiac hypertrophy (CH)</td><td>14651</td><td>7</td><td><a href="DatasetDetails.jsp?daset=E_MTAB_11268"> <i class="fa-solid fa-share-from-square"></i> </a>  </td> -->


						                                         
						                                    </tbody>
						                                </table>
						                            </div>
						                        </div>
						                    </div>
                                	</div>
                                </div>
                                <div class="tab-pane fade" id="mouse">
                                	<div class="col-md-3 col-sm-3" style="margin-top:;">
                                		<img src="img/mms_3.png" style="height:;margin-left:-40px;" /> 
                                	</div>
                                	<div class="col-md-9 col-sm-9">
                                		  <div class="panel panel-default" style="margin-top:10px;">
						                        <div class="panel-heading">
						                            <strong style="font-size:20px;"> Cell type annotation and downstream analysis (mouse) </strong>
						                        </div>
						                        <div class="panel-body">
						                            <div class="table-responsive" style="max-height:500px;overflow:auto;">
						                                <table class="table table-striped" style="font-size:18px; ">
						                                    <thead>
						                                        <tr>
						                                            <th>Tissue</th>
						                                            <th>Disease</th>
						                                            <th>No. of Cell</th>
						                                            <th>No. of Cell type</th>
						                                            <th>Detail</th>
						                                        </tr>
						                                    </thead>
						                                    <tbody>
<tr><td>Heart</td><td>MI</td><td>80053</td><td>9</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_MI"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>HF</td><td>26499</td><td>9</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_HF"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>PO</td><td>55959</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_PO"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>Normal</td><td>51051</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Aorta</td><td>AS</td><td>25292</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_Aorta"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>SICM (Septic cardiomyopathy)</td><td>76595</td><td>6</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_SICM"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>DM (Diabetes mellitus)</td><td>13468</td><td>7</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_DM"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>Normal</td><td>41010</td><td>9</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_fetal_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>Normal</td><td>29263</td><td>9</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_young_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>MH</td><td>70217</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_MH"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>MYO</td><td>3735</td><td>5</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_young_MYO"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>EPD</td><td>9240</td><td>6</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_fetal_EPD"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>MC</td><td>6942</td><td>5</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_MC"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>HF</td><td>31936</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_HF_JQ1_inhibitor"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Heart</td><td>MI</td><td>13707</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_MI_TanIIA_treatment"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>


<!-- <tr><td>Heart </td><td>Cardiac hypertrophy (CH)</td><td>14651</td><td>7</td><td><a href="DatasetDetailsMus.jsp?daset=E_MTAB_11268"> <i class="fa-solid fa-share-from-square"></i> </a>  </td> -->

						                                        
						                                    </tbody>
						                                </table>
						                            </div>
						                        </div>
						                    </div>
                                	</div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                
           
                
            
    <section class="footer-section" style="margin-top:200px;">
        <div class="container">
            <div class="row">
                <div class="col-md-12" style="font-size:16px;">
                   Copyright &copy; 2023.Harbin Medical University </div>

            </div>
        </div>
    </section>
    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.js"></script>
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>

</body>
</html>