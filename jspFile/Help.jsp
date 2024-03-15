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
.listyle1{width:400px;font-size:20px;text-align:center;font-weight:600;}
</style>
<body>

    <section class="menu-section">
	<div class="container">
		<div class="row ">
			<div class="col-md-12">
				<div class="navbar-collapse collapse ">
					<ul id="menu-top" class="nav navbar-nav navbar-right">
					<li><a class="navbar-brand" href="index.jsp">
							<img src="assets/img/logo_2.png" style="width:150px;height:60px;margin-top:-20px;" />
						</a>
						</li>
						<li><a href="index.jsp" >home</a></li>
					   
						<li ><a href="Browse.jsp">Browse</a></li>
						<li>
							<a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown">Search <i class="fa fa-angle-down"></i></a>
							<ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem" >
								<li role="presentation"><a role="menuitem" tabindex="-1" href="SearchAtlas.jsp" class="font-1" >Atlas</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1" href="SearchDatasets.jsp" class="font-1">Datasets</a></li>
							</ul>
						</li>
						<li><a href="AnnotationCellType.jsp">Function</a></li>
						<li><a href="Help.jsp" class="menu-top-active">Help</a></li>
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
<!--                 <h4 class="header-line" style="font-size:25px;">Frequently asked questions</h4> -->
<!--                             </div> -->
<!--         </div> -->
            <div class="row" style="margin-top:00px;">
            	<div class="col-md-12 col-sm-12">
                   	<div >
                       
                        <div class="panel-body">
                            <div class="panel-group" id="accordion">
<!-- Home                             -->
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                    
                                        <h4 class="panel-title" >
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed" ><strong style="font-size:20px;">Home</strong>  </a>
                                        </h4>
                                    </div>
                                    
                                    <div id="collapseOne" class="panel-collapse  in" style="height: auto;">
                                        <div class="panel-body">
                                        	<img  src="img/help/homepage-01.png" alt="" style="width: 100%;">
                                        </div>
                                        
                                    </div>
                                </div>
<!-- Browse                                 -->
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"><strong style="font-size:20px;">Browse</strong></a>
                                        </h4>
                                    </div>
                                    <div id="collapseTwo" class="panel-collapse collapse" style="height: auto;">
                                        <div class="panel-body">
                                        	<img  src="img/help/browse_human-01.png" alt="" style="width: 100%;">
                                        	<img  src="img/help/search_atlas_detail-01.png" alt="" style="width: 100%;">
                                        </div>
                                    </div>
                                </div>
<!-- Search                                 -->
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" class="collapsed"><strong style="font-size:20px;">Search</strong></a>
                                        </h4>
                                    </div>
                                    <div id="collapseThree" class="panel-collapse collapse">
                                        <div class="panel-body">
                                        	<img  src="img/help/search_atlas-01.png" alt="" style="width: 100%;">
                                        	<img  src="img/help/search_atlas_detail-01.png" alt="" style="width: 100%;">
                                        	
                                        </div>
                                    </div>
                                </div>
<!-- Function                                 -->
                                 <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse4"><strong style="font-size:20px;">Function</strong></a>
                                        </h4>
                                    </div>
                                    <div id="collapse4" class="panel-collapse collapse" style="height: auto;">
                                        <div class="panel-body">
                                        	<img  src="img/help/FUN-2-01.png" alt="" style="width: 100%;">
                                        	<img  src="img/help/FUN_upload-01.png" alt="" style="width: 100%;">
                                        	<img  src="img/help/FUN_analysis-01.png" alt="" style="width: 100%;">
                                        </div>
                                    </div>
                                </div>
<!-- celltype                                 -->
                                 <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse5"><strong style="font-size:20px;">Cell type names</strong></a>
                                        </h4>
                                    </div>
                                    <div id="collapse5" class="panel-collapse collapse" style="height: auto;">
                                        <div class="panel-body">
                                        	<div class="table-responsive" style="">
						                                <table class="table table-striped" style="font-size:18px; ">
						                                    <thead>
						                                        <tr>
						                                            <th>Short form	</th>
						                                            <th>Full name</th>
						                                            
						                                        </tr>
						                                    </thead>
						                                    <tbody>
						                                    <tr> <td>AC</td><td>Atrial cell</td> </tr>
<tr> <td>AV-bundle</td><td>Atrioventricular bundle cell</td> </tr>
<tr> <td>B</td><td>B cell</td> </tr>
<tr> <td>BEC</td><td>Blood vessel endothelial cell</td> </tr>
<tr> <td>BEPC-embryonic</td><td>Embryonic blood vessel endothelial progenitor cell</td> </tr>
<tr> <td>B-Fo</td><td>Follicular B cell</td> </tr>
<tr> <td>Bm</td><td>Memory B cell</td> </tr>
<tr> <td>cDC1</td><td>CD103-positive dendritic cell</td> </tr>
<tr> <td>cDC2</td><td>CD11b-positive dendritic cell</td> </tr>
<tr> <td>CEC</td><td>Capillary endothelial cell</td> </tr>
<tr> <td>CF</td><td>Fibroblast of cardiac tissue</td> </tr>
<tr> <td>Chondrocyte</td><td>Chondrocyte</td> </tr>
<tr> <td>Club</td><td>Club cell</td> </tr>
<tr> <td>CM</td><td>Cardiac muscle cell</td> </tr>
<tr> <td>CM-immature-hPSC</td><td>Immature hPSC-derived cardiomyocyte</td> </tr>
<tr> <td>CMM</td><td>Cardiac muscle myoblast</td> </tr>
<tr> <td>CPC</td><td>Cardiac progenitor cell</td> </tr>
<tr> <td>CTL</td><td>Cytotoxic T cell</td> </tr>
<tr> <td>DC</td><td>Dendritic cell</td> </tr>
<tr> <td>DC-MC</td><td>Migratory conventional dendritic cell</td> </tr>
<tr> <td>DivC</td><td>Dividing cell</td> </tr>
<tr> <td>EC</td><td>Endothelial cell</td> </tr>
<tr> <td>EC-artery</td><td>Endothelial cell of artery</td> </tr>
<tr> <td>EC-cardiac</td><td>Cardiac endothelial cell</td> </tr>
<tr> <td>EC-ciliated</td><td>Ciliated epithelial cell</td> </tr>
<tr> <td>EC-HEV</td><td>Endothelial cell of high endothelial venule</td> </tr>
<tr> <td>EC-VT</td><td>Endothelial cell of vascular tree</td> </tr>
<tr> <td>EndoC</td><td>Endocardial cell</td> </tr>
<tr> <td>EPC-adult</td><td>Adult endothelial progenitor cell</td> </tr>
<tr> <td>Epi</td><td>Epithelial cell</td> </tr>
<tr> <td>EpiA</td><td>Epicardial adipocyte</td> </tr>
<tr> <td>EpiC</td><td>Epicardial progenitor cell</td> </tr>
<tr> <td>EpiC-Mesothelial</td><td>Mesothelial cell of epicardium</td> </tr>
<tr> <td>Fat</td><td>Fat cell</td> </tr>
<tr> <td>FB</td><td>Fibroblast</td> </tr>
<tr> <td>FHF</td><td>First heart field cell</td> </tr>
<tr> <td>FHF-PC</td><td>Early the first heart field progenitor cell</td> </tr>
<tr> <td>GC</td><td>Goblet cell</td> </tr>
<tr> <td>Granulocyte</td><td>Granulocyte</td> </tr>
<tr> <td>HEC</td><td>Haemogenic endothelial cell</td> </tr>
<tr> <td>HPC</td><td>Hematopoietic precursor cell</td> </tr>
<tr> <td>HSC</td><td>Hematopoietic stem cell</td> </tr>
<tr> <td>HV</td><td>Heart valve cell</td> </tr>
<tr> <td>LC</td><td>Langerhans cell</td> </tr>
<tr> <td>LEC</td><td>Endothelial cell of lymphatic vessel</td> </tr>
<tr> <td>Lonocyte</td><td>Ionocyte</td> </tr>
<tr> <td>Lymphocyte</td><td>Lymphocyte</td> </tr>
<tr> <td>Mast</td><td>Mast cell</td> </tr>
<tr> <td>MC</td><td>Mesenchymal cell</td> </tr>
<tr> <td>Mesoderm-cardiac</td><td>Cardiac mesoderm cell</td> </tr>
<tr> <td>Mesothelial</td><td>Mesothelial cell</td> </tr>
<tr> <td>MFB</td><td>Myofibroblast cell</td> </tr>
<tr> <td>Mono</td><td>Monocyte</td> </tr>
<tr> <td>Mono-CD14</td><td>CD14-positive monocyte</td> </tr>
<tr> <td>MP</td><td>Macrophage</td> </tr>
<tr> <td>MP-Peritoneal</td><td>Peritoneal macrophage</td> </tr>
<tr> <td>MPP-hematopoietic</td><td>Hematopoietic multipotent progenitor cell</td> </tr>
<tr> <td>MSC</td><td>Mesenchymal stem cell</td> </tr>
<tr> <td>Myeloid</td><td>Myeloid cell</td> </tr>
<tr> <td>Myoendocrine</td><td>Myoendocrine cell</td> </tr>
<tr> <td>Neuroendocrine</td><td>Neuroendocrine cell</td> </tr>
<tr> <td>Neuron</td><td>Neuron</td> </tr>
<tr> <td>NEUT</td><td>Neutrophil</td> </tr>
<tr> <td>Neutrophil</td><td>Neutrophil</td> </tr>
<tr> <td>NK</td><td>Natural killer cell</td> </tr>
<tr> <td>NKT-mature</td><td>Mature NK T cell</td> </tr>
<tr> <td>Osteoblast</td><td>Osteoblast</td> </tr>
<tr> <td>PAPC</td><td>Professional antigen presenting cell</td> </tr>
<tr> <td>pDC</td><td>Plasmacytoid dendritic cell</td> </tr>
<tr> <td>Pericyte</td><td>Pericyte</td> </tr>
<tr> <td>Plasma-B</td><td>Plasma cell</td> </tr>
<tr> <td>Preadipocyte</td><td>Preadipocyte</td> </tr>
<tr> <td>RBC</td><td>Erythrocyte</td> </tr>
<tr> <td>Schwann</td><td>Schwann cell</td> </tr>
<tr> <td>Secretory</td><td>Secretory cell</td> </tr>
<tr> <td>SHF</td><td>Second heart field cell</td> </tr>
<tr> <td>SMC</td><td>Smooth muscle cell</td> </tr>
<tr> <td>SN-cardiac_pacemaker</td><td>Cardiac pacemaker cell of sinoatrial node</td> </tr>
<tr> <td>SNM</td><td>Myocyte of sinoatrial node</td> </tr>
<tr> <td>T</td><td>T cell</td> </tr>
<tr> <td>T-alpha-beta-CD8</td><td>CD8-positive, alpha-beta T cell</td> </tr>
<tr> <td>Teff-activated</td><td>Activated effector T cell</td> </tr>
<tr> <td>Teff-alpha-beta-CD4</td><td>Effector CD4-positive, alpha-beta T cell</td> </tr>
<tr> <td>Teff-exhausted-CD4</td><td>Exhausted CD4+ effector T-cell</td> </tr>
<tr> <td>Tex</td><td>Exhausted T cell</td> </tr>
<tr> <td>Th</td><td>Helper T cell</td> </tr>
<tr> <td>Th17</td><td>T-helper 17 cell</td> </tr>
<tr> <td>Th2</td><td>T-helper 2 cell</td> </tr>
<tr> <td>Tip</td><td>Tip cell</td> </tr>
<tr> <td>Tm-alpha-beta-CD4</td><td>CD4-positive, alpha-beta memory T cell</td> </tr>
<tr> <td>Tm-alpha-beta-CD8</td><td>CD8-positive, alpha-beta memory T cell</td> </tr>
<tr> <td>Tn</td><td>Naive T cell</td> </tr>
<tr> <td>Treg</td><td>Regulatory T cell</td> </tr>
<tr> <td>TRMs</td><td>Tissue-resident macrophage</td> </tr>
<tr> <td>VCC</td><td>Ventricular compact cell</td> </tr>
<tr> <td>VCM-Regular</td><td>Regular ventricular cardiac myocyte</td> </tr>
<tr> <td>VEC</td><td>Vein endothelial cell</td> </tr>
<tr> <td>VIC</td><td>Valvular interstitial cell</td> </tr>
<tr> <td>VSMC</td><td>Vascular associated smooth muscle cell</td> </tr>
<tr> <td>VTC</td><td>Ventricular trabecular cell</td> </tr>
<tr> <td>WBC</td><td>Leukocyte</td> </tr>
						                                    
						                                    </tbody>
						                                </table>
						                            </div>
                                        </div>
                                    </div>
                                </div>                                
                            
                            
<!-- contact                                 -->
                                 <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse7"><strong style="font-size:20px;">Contact</strong></a>
                                        </h4>
                                    </div>
                                    <div id="collapse7" class="panel-collapse collapse" style="height: auto;">
                                        <div class="panel-body">
                                        	<h3 style="">Please contact us when you have any questions .</h3>
                                        	<div class="table-responsive" style="margin-top:10px;">
						                                <table class="table table-striped" style="font-size:18px; ">
						                                	<tr class="ant-descriptions-row">
			        						<th class="ant-descriptions-item-label">
			        							<p  class="font_tableLeft">	Juan Xu,   </p>
			        						</th>
			        						<td class="ant-descriptions-item-content">
												<p  class="font_tableRight">	Email  : xujuanbiocc@ems.hrbmu.edu.cn </p>
											</td>
			        					</tr>
			        					<tr class="ant-descriptions-row">
			        						<th class="ant-descriptions-item-label">
			        							<p  class="font_tableLeft">	Yongsheng li,   </p>
			        						</th>
			        						<td class="ant-descriptions-item-content">
			        							<p  class="font_tableRight">	Email  : liyongsheng@ems.hrbmu.edu.cn </p>
			        						</td>
			        					</tr>
<!-- 			        					<tr class="ant-descriptions-row"> -->
<!-- 			        						<th class="ant-descriptions-item-label"> -->
<!-- 			        							<p  class="font_tableLeft">	Xia Li,   </p> -->
<!-- 			        						</th> -->
<!-- 			        						<td class="ant-descriptions-item-content"> -->
<!-- 			        							<p  class="font_tableRight">	Email  : lixia@hrbmu.edu.cn </p> -->
<!-- 			        						</td> -->
<!-- 			        					</tr> -->
			        					
			        					<tr class="ant-descriptions-row">
			        						<th class="ant-descriptions-item-label">
			        							<p  class="font_tableLeft">	Laboratory,   </p>
			        						</th>
			        						<td class="ant-descriptions-item-content">
			        							<p class="font_tableRight">	Email  : bioinformatics2021@163.com </p>
			        						</td>
			        					</tr>
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