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
  <script type="text/javascript" language="javascript" src="js/base/d3.min.js"></script>
  <link rel="stylesheet" href="layuisrc/css/layui.css">
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
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line" style="font-size:25px;">Disease types of human and mouse</h4>
            </div>
        </div>
            <div class="row" style="margin-top">
            	<div class="col-md-12 col-sm-12">
            	<div class="col-md-1 col-sm-1"></div>
	            	<div class="col-md-10 col-sm-10">
	      				 <div style="" id="cancer_human"></div>
	                </div>
	               
                </div>
                
                
                
                
                
                
                <div class="col-md-12 col-sm-12" style="margin-top:30px;">
                	<div class="panel panel-default" style="margin-top:10px;">
						<div class="panel-heading">
						<strong style="font-size:20px;"> Atlas of cardiovascular disease (human and mouse) </strong>
						</div>
						 <div class="panel-body">
						     <div class="table-responsive" style="max-height:480px;overflow:auto;">
						          <table class="table table-striped" style="font-size:18px; ">
						                <thead>
						                                        <tr>
						                                        	<th>Species</th>
						                                            <th>Tissue</th>
						                                            <th>Disease</th>
						                                            <th>No. of Cell</th>
						                                            <th>No. of Cell type</th>
						                                            <th>Detail</th>
						                                        </tr>
						                 </thead>
						           <tbody>
<tr><td>Human</td><td>Heart</td><td>Dilated cardiomyopathy (DCM)</td><td>202333</td><td>12</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_DCM"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Hypertrophic cardiomyopathy (HCM)</td><td>192206</td><td>11</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_HCM"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Heart failure (HF)</td><td>9655</td><td>9</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_HF"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Ischemic cardiomyopathy (ICM)</td><td>68315</td><td>10</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_ICM"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>141339</td><td>12</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_MI"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Congenital heart disease (CHD)</td><td>201704</td><td>13</td><td><a href="AtlasDetails.jsp?ats=atlas_human_CHD"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Cardiac hypertrophy (CH)</td><td>14651</td><td>5</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_CH"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Hypoplastic left heart syndrome (HLHS)</td><td>17714</td><td>10</td><td><a href="AtlasDetails.jsp?ats=atlas_human_HLHS"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Tetralogy of fallot (TOF)</td><td>14157</td><td>10</td><td><a href="AtlasDetails.jsp?ats=atlas_human_TOF"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal adult</td><td>39829</td><td>10</td><td><a href="AtlasDetails.jsp?ats=atlas_human_adult_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal young</td><td>26279</td><td>9</td><td><a href="AtlasDetails.jsp?ats=atlas_human_young_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal fetal</td><td>61419</td><td>12</td><td><a href="AtlasDetails.jsp?ats=atlas_human_fetal_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>


<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>80053</td><td>9</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_MI"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Heart failure (HF)</td><td>26499</td><td>9</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_HF"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Pressure overload (PO)</td><td>55959</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_PO"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Aorta</td><td>Atherosclerosis (AS)</td><td>25292</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_Aorta"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Septic myocardial injury (SICM)</td><td>76595</td><td>6</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_SICM"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Diabetic cardiomyopathy (Diabetes)</td><td>13468</td><td>7</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_DM"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial Hypertrophy (MH)</td><td>70217</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_adult_MH"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocarditis (MYO)</td><td>3735</td><td>5</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_young_MYO"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>epicardial-deficient (EPD)</td><td>9240</td><td>6</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_fetal_EPD"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Mitochondrial cardiomyopathy (MC)</td><td>6942</td><td>5</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_MC"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Heart failure (HF)</td><td>31936</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_HF_JQ1_inhibitor"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>13707</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_MI_TanIIA_treatment"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal </td><td>51051</td><td>8</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal young</td><td>29263</td><td>9</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_young_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal fetal</td><td>41010</td><td>9</td><td><a href="AtlasDetailsMus.jsp?ats=atlas_Mus_fetal_normal"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
						                                         
						                                    </tbody>
						                                </table>
						                            </div>
						                        </div>
						                    </div>
                                	</div>
                                	
                                	
                                	
                                	
                   <div class="col-md-12 col-sm-12" style="margin-top:30px;">
                	<div class="panel panel-default" style="margin-top:10px;">
						<div class="panel-heading">
						<strong style="font-size:20px;"> Datasets of cardiovascular disease  (human and mouse) </strong>
						</div>
						 <div class="panel-body">
						     <div class="table-responsive" style="max-height:480px;overflow:auto;">
						          <table class="table table-striped" style="font-size:18px; ">
						                <thead>
						                                        <tr>
						                                        	<th>Species</th>
						                                            <th>Tissue</th>
						                                            <th>Disease</th>
						                                            <th>No. of Cell</th>
						                                            <th>No. of Cell type</th>
						                                            <th>Detail</th>
						                                        </tr>
						                 </thead>
						           <tbody>
<tr><td>Human</td><td>Heart</td><td>Cardiac hypertrophy (CH)</td><td>14651</td><td>7</td><td><a href="DatasetDetails.jsp?daset=E_MTAB_11268&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Congenital heart disease (CHD)</td><td>54047</td><td>11</td><td><a href="DatasetDetails.jsp?daset=GSE204928&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Congenital heart disease (CHD)</td><td>137934</td><td>13</td><td><a href="DatasetDetails.jsp?daset=PMID35732239&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Congenital heart disease (CHD)</td><td>18369</td><td>13</td><td><a href="DatasetDetails.jsp?daset=PRJNA576243&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Dilated cardiomyopathy (DCM)</td><td>60045</td><td>14</td><td><a href="DatasetDetails.jsp?daset=GSE145154_DCM&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Dilated cardiomyopathy (DCM)</td><td>45881</td><td>13</td><td><a href="DatasetDetails.jsp?daset=GSE183852&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Dilated cardiomyopathy (DCM)</td><td>51560</td><td>12</td><td><a href="DatasetDetails.jsp?daset=GSE185100&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Dilated cardiomyopathy (DCM)</td><td>126932</td><td>13</td><td><a href="DatasetDetails.jsp?daset=SCP1303_DCM&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Heart failure (HF)</td><td>4571</td><td>9</td><td><a href="DatasetDetails.jsp?daset=GSE121893&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Heart failure (HF)</td><td>18815</td><td>12</td><td><a href="DatasetDetails.jsp?daset=GSE222144&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Hypertrophic cardiomyopathy (HCM)</td><td>166036</td><td>12</td><td><a href="DatasetDetails.jsp?daset=SCP1303_HCM&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Hypoplastic left heart syndrome (HLHS)</td><td>30647</td><td>14</td><td><a href="DatasetDetails.jsp?daset=GSE138979&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Ischemic cardiomyopathy (ICM)</td><td>59979</td><td>12</td><td><a href="DatasetDetails.jsp?daset=GSE145154_ICM&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Ischemic cardiomyopathy (ICM)</td><td>61445</td><td>10</td><td><a href="DatasetDetails.jsp?daset=SCP1849&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>39968</td><td>13</td><td><a href="DatasetDetails.jsp?daset=GSE145154_MI&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>172842</td><td>13</td><td><a href="DatasetDetails.jsp?daset=PMID35948637&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal adult</td><td>8138</td><td>11</td><td><a href="DatasetDetails.jsp?daset=GSE109816&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal adult</td><td>27631</td><td>11</td><td><a href="DatasetDetails.jsp?daset=GSE165838&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal adult</td><td>10852</td><td>6</td><td><a href="DatasetDetails.jsp?daset=GSE201333&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal adult</td><td>371336</td><td>16</td><td><a href="DatasetDetails.jsp?daset=PRJEB39602&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal adult</td><td>128969</td><td>11</td><td><a href="DatasetDetails.jsp?daset=SCP1303_Normal&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal adult</td><td>34974</td><td>12</td><td><a href="DatasetDetails.jsp?daset=SCP1479&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal adult</td><td>248189</td><td>13</td><td><a href="DatasetDetails.jsp?daset=SCP498&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal adult,Normal young,Normal fetal</td><td>44052</td><td>12</td><td><a href="DatasetDetails.jsp?daset=GSE156703&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal fetal</td><td>4674</td><td>12</td><td><a href="DatasetDetails.jsp?daset=GSE106118&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal fetal</td><td>15420</td><td>12</td><td><a href="DatasetDetails.jsp?daset=GSE114373&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Human</td><td>Heart</td><td>Normal fetal</td><td>22515</td><td>12</td><td><a href="DatasetDetails.jsp?daset=GSE134355&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>


<tr><td>Mus musculus</td><td>Aorta</td><td>Atherosclerosis (AS)</td><td>2914</td><td>6</td><td><a href="DatasetDetailsMus.jsp?daset=GSE149069&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Aorta</td><td>Atherosclerosis (AS)</td><td>22513</td><td>10</td><td><a href="DatasetDetailsMus.jsp?daset=GSE131776&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Aorta</td><td>Atherosclerosis (AS)</td><td>1969</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=GSE97310&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Cardiac hypertrophy (CH)</td><td>54652</td><td>8</td><td><a href="DatasetDetailsMus.jsp?daset=GSE198833&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Cardiac hypertrophy (CH)</td><td>32170</td><td>11</td><td><a href="DatasetDetailsMus.jsp?daset=E_MTAB_8810&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Diabetic cardiomyopathy (Diabetes)</td><td>11570</td><td>7</td><td><a href="DatasetDetailsMus.jsp?daset=GSE193746&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Diabetic cardiomyopathy (Diabetes)</td><td>14511</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=GSE213337&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>epicardial-deficient (EPD)</td><td>16972</td><td>7</td><td><a href="DatasetDetailsMus.jsp?daset=GSE100861&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Heart failure (HF)</td><td>15860</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=GSE122930&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Heart failure (HF)</td><td>22059</td><td>10</td><td><a href="DatasetDetailsMus.jsp?daset=syn26282495&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Heart failure (HF)</td><td>57529</td><td>11</td><td><a href="DatasetDetailsMus.jsp?daset=GSE155882&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Heart failure (HF)</td><td>13278</td><td>8</td><td><a href="DatasetDetailsMus.jsp?daset=GSE137167&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Mitochondrial cardiomyopathy (MC)</td><td>18529</td><td>6</td><td><a href="DatasetDetailsMus.jsp?daset=GSE118545&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>17326</td><td>8</td><td><a href="DatasetDetailsMus.jsp?daset=GSE168742&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>32577</td><td>6</td><td><a href="DatasetDetailsMus.jsp?daset=E_MTAB_7376&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>16197</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=GSE153480&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>112941</td><td>12</td><td><a href="DatasetDetailsMus.jsp?daset=GSE157244&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>4398</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=GSE135310&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>28803</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=GSE163465&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>27610</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=GSE132880&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>56978</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=E_MTAB_7895&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>24685</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=GSE128628&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>37030</td><td>11</td><td><a href="DatasetDetailsMus.jsp?daset=GSE163129&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>9528</td><td>6</td><td><a href="DatasetDetailsMus.jsp?daset=GSE152122&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>13332</td><td>6</td><td><a href="DatasetDetailsMus.jsp?daset=GSE136088&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocardial infarction (MI)</td><td>25234</td><td>7</td><td><a href="DatasetDetailsMus.jsp?daset=GSE130699&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Myocarditis (MYO)</td><td>6306</td><td>8</td><td><a href="DatasetDetailsMus.jsp?daset=GSE213486&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal adult</td><td>9216</td><td>7</td><td><a href="DatasetDetailsMus.jsp?daset=E_MTAB_6173&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal adult</td><td>11411</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=GSE157444&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal adult</td><td>22964</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=E_MTAB_7869&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal adult</td><td>5004</td><td>6</td><td><a href="DatasetDetailsMus.jsp?daset=GSE130710&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal fetal</td><td>18074</td><td>12</td><td><a href="DatasetDetailsMus.jsp?daset=GSE158941&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal fetal</td><td>113278</td><td>10</td><td><a href="DatasetDetailsMus.jsp?daset=PRJNA489304&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal fetal,Normal young</td><td>33583</td><td>12</td><td><a href="DatasetDetailsMus.jsp?daset=PRJNA562135 &annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Normal young</td><td>2921</td><td>8</td><td><a href="DatasetDetailsMus.jsp?daset=GSE122706&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Pressure overload (PO)</td><td>10258</td><td>10</td><td><a href="DatasetDetailsMus.jsp?daset=GSE120064&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Pressure overload (PO)</td><td>48075</td><td>11</td><td><a href="DatasetDetailsMus.jsp?daset=GSE179276&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Septic myocardial injury (SICM)</td><td>76522</td><td>10</td><td><a href="DatasetDetailsMus.jsp?daset=GSE190856&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
<tr><td>Mus musculus</td><td>Heart</td><td>Septic myocardial injury (SICM)</td><td>36193</td><td>9</td><td><a href="DatasetDetailsMus.jsp?daset=GSE207363&annotationType=small"> <i class="fa-solid fa-share-from-square"></i> </a>  </td>
					                                         
						                                    </tbody>
						                                </table>
						                            </div>
						                        </div>
						                    </div>
                                	</div>             	
            </div>
            
        


 <div id="layer-package" style="display:none;padding: 30px;">
        	<div style="margin-left:10px;font-size:18px;min-height:700px;">
<!-- /////////// asts /////        	 -->
 				<div class="col-md-12 col-sm-12" style="margin-top:0px;">
                	<div class="panel panel-default" style="margin-top:2px;">
						<div class="panel-heading">
						<strong style="font-size:20px;">  Atlas of cardiovascular disease </strong>
						</div>
						 <div class="panel-body">
						     <div class="table-responsive" style="max-height:250px;overflow:auto;">
						        <table id="browse_sub_table_ats" class="table table-bordered table-hover dataTable cell_infor_table_detail" style="width:100%;">
									<thead >
							 									<tr>
						                                        	<th>Species</th>
						                                            <th>Tissue</th>
						                                            <th>Disease</th>
						                                            <th>No. of Cell</th>
						                                            <th>No. of Cell type</th>
						                                            <th>Detail</th>
						                                        </tr>
									</thead>
								</table>
						     </div>
						 </div>
					</div>
                </div>
                
                
 <!-- /////////// datasets /////        	 -->    
 				<div class="col-md-12 col-sm-12" style="margin-top:2px;">
                	<div class="panel panel-default" >
						<div class="panel-heading">
						<strong style="font-size:20px;"> Datasets of cardiovascular disease     </strong>
						</div>
						 <div class="panel-body">
						     <div class="table-responsive" style="max-height:350px;overflow:auto;">
						        <table id="browse_sub_table_dataset" class="table table-bordered table-hover dataTable cell_infor_table_detail" style="width:100%;">
									<thead >
							 									<tr>
						                                        	<th>Species</th>
						                                            <th>Tissue</th>
						                                            <th>Disease</th>
						                                            <th>No. of Cell</th>
						                                            <th>No. of Cell type</th>
						                                            <th>Detail</th>
						                                        </tr>
									</thead>
								</table>
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
    
    <script src="layuisrc/layui.js"></script>
     <script src="js/browse.js"></script>
</body>
<script  type="text/javascript" charset="utf-8">


//////////

var svgNode = d3.select("#cancer_human");
var path;
d3.xml("img/h&m_f.svg", "image/svg+xml", function (error, xml) {
    if (error) throw error;
    var svg_content = xml.documentElement;
    svgNode.node().appendChild(svg_content); //append svg
    path = document.querySelectorAll('[id^=UBERON]');//匹配id用的
   changeImg(path);
  
   
});

</script>

</html>