<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
  
    <title></title>
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="assets/css/style.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
 <script src="js/73a252e5a4.js" crossorigin="anonymous"></script>
  <script src="js/xm-select.js" ></script>
  <script src="js/d3.min.js" ></script>
  <script src="js/plotly.js" ></script>
</head>
<style>
.span-advance-left-button-disable{font-size:18px;font-weight:600;background:white;color:black;border-radius:10px;border-color:#faebcc;width:100%;height:50px;margin-bottom: 10px;pointer-events:none;}
.datatable1{width:100%;font-size:16px;}
.datatableFather{width:100%;border-collapse:separate;border-spacing:3px;text-align:left;}
.span-advance-left-button-activate{font-size:18px;font-weight:600;background:#faebcc;color:black;border-radius:10px;border-color:#faebcc;width:100%;height:50px;margin-bottom: 10px;}
.span-advance-right-methodDes{font-size:15px;font-weight:600;text-align:left;}
.span-advance-left-button{font-size:18px;font-weight:600;background:white;color:black;border-radius:10px;border-color:#faebcc;width:100%;height:50px;margin-bottom: 10px;}
.span-advance-left-button-a{font-size:18px;font-weight:600;text-decoration:none;color:black;}
.td1{font-size:18px;color:black;font-weight:600;}
.font1{font-size:16px;color:black;font-weight:600;}
.summary-td1{width:30%;font-weight:600;}
.panel-body-font{font-size:25px;}
.panel-up-ww{background:white;color:black;border-radius:10px;border-color:#dff0d8;pointer-events:none;font-size:;}
.panel-down-ww{background:;color:;border-radius:10px;border-color:#faebcc;}
.panel-down-ww-a{color:white;font-size:px;text-decoration:none;}
.panel-li{font-size:16px;width:20px;}
.header-line1{font-weight: 900;padding-bottom: 10px;text-transform: uppercase}
.checkboxline{padding-bottom: 0px;border-bottom: 1px solid #eeeeee;}
</style>
<body>
    <div class="navbar navbar-inverse set-radius-zero" >
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html">

                    <img src="assets/img/logo.png" />
                </a>

            </div>

        </div>
    </div>
    <!-- LOGO HEADER END-->
    <section class="menu-section">
	<div class="container">
		<div class="row ">
			<div class="col-md-12">
				<div class="navbar-collapse collapse ">
					<ul id="menu-top" class="nav navbar-nav navbar-right">
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
						 <li><a href="table.html">Download</a></li>
						<li><a href="blank.html">Help</a></li>


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
                <h4 class="header-line">Atlas Details</h4>
                
                            </div>

        </div>

            <div class="row">
                <div class="col-md-6">
                      <!--    Striped Rows Table  -->
                    <div class="panel panel-success" id="summary">
                        <div class="panel-heading">
                            <strong style="font-size:20px;color:black">Atlas Summary</strong>
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped" style="font-size:16px;">
                                    <tbody>
                                    	<tr>
                                            <td class="summary-td1">Species</td>
                                            <td id="Species">Human</td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1">Technology</td>
                                            <td id="Technology">10X</td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1"> Disease</td>
                                            <td id="Disease">Normal</td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1"> Tissue</td>
                                            <td id="Tissue">Heart</td>
                                        </tr>
                                        
                                        <tr>
                                            <td class="summary-td1"> Cell Number</td>
                                            <td id="Cell_Number">32k</td>
                                        </tr>
                                        
                                        <tr>
                                            <td class="summary-td1"> Cell Type Number</td>
                                            <td id="Cell_Type_Number">13</td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1"> Marker Number</td>
                                            <td id="Marker_Number">1300</td>
                                        </tr>
<!--                                         <tr> -->
<!--                                             <td class="summary-td1"> Publication</td> -->
<!--                                             <td><a href="#"></a></td> -->
<!--                                         </tr> -->
                                        <tr>
                                            <td class="summary-td1"> Download</td>
                                            <td ><button class="btn btn-warning panel-down-ww">  <a id="atlas_download" class="panel-down-ww-a" href="#"><i class="fa-solid fa-download panel-li"></i> </a></button></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
<!--                         用来和右侧overview补高度差 -->
                        <div style="height:35px;"></div>
                        
                    </div>
                    <!--  End  Striped Rows Table  -->
                    
                </div>
                <div class="col-md-6">
                    <div class="panel panel-success" id="overview">
                        <div class="panel-heading">
                            <strong style="font-size:20px;color:black">Atlas Overview</strong>
                        </div>
                        <div class="panel-body">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#overview-umap" data-toggle="tab"> <font class="font1">UMAP</font>  </a></li>
                                <li ><a href="#overview-tsne" data-toggle="tab"><font class="font1">tSNE</font> </a></li>
<!--                                 <li ><a href="#cellDentisy" data-toggle="tab"><font class="font1">Cell Density</font> </a></li> -->
                            </ul>

                            <div class="tab-content" style="text-align:center;min-height:500px;">
                                <div class="tab-pane fade active in" id="overview-umap" >
									<div id="umap" ></div>
                                </div>
                                <div class="tab-pane fade" id="overview-tsne">
                                	<div id="tsne" ></div>
                                </div>
<!--                                 <div class="tab-pane fade" id="cellDentisy"> -->
<!--                                 	<h4>title</h4> -->
<!--                                 	<img alt="cellDentisy" src="img/celltype_num.png" height="300px"> -->
<!--                                 </div> -->
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                <!-- /. ROW  -->
            <div class="row">
            	<div class="col-md-12">
            		<div class="panel panel-warning">
            			<div class="panel-heading">
                            <strong style="font-size:20px;color:black">Advanced Analytics</strong>
                        </div>
                        <div class="panel-body" >
                        	<div class="col-md-3 col-sm-3">
                        		<span id="cellDensity"> <button id="cellDensityButton" class="btn btn-warning span-advance-left-button-activate" onclick="chEvent('cellDensity')"> Cell Density</button> </span>
                                <span id="cellCycle"> <button id="cellCycleButton" class="btn btn-warning span-advance-left-button" onclick="chEvent('cellCycle')"> Cell Cycle</button> </span>
                                <span id="cellCorr"> <button id="cellCorrButton" class="btn btn-warning span-advance-left-button" onclick="chEvent('cellCorr')"> Cell type Correlation</button> </span>
                        		<span id="cellCellCom"> <button id="cellCellComButton" class="btn btn-warning span-advance-left-button" onclick="chEvent('cellCellCom')"> Cell Cell Communication</button> </span>
                                <span id="goEnrich"> <button id="goEnrichButton" class="btn btn-warning span-advance-left-button" onclick="chEvent('goEnrich')"> Go BP </button> </span>
                                <span id="keggEnrich"> <button id="keggEnrichButton" class="btn btn-warning span-advance-left-button" onclick="chEvent('keggEnrich')"> KEGG</button> </span>
                                <span id="cellstateEnrich"> <button id="cellstateEnrichButton" class="btn btn-warning span-advance-left-button" onclick="chEvent('cellstateEnrich')"> Cell State </button> </span>
                                <span id="immEnrich"> <button id="immEnrichButton" class="btn btn-warning span-advance-left-button" onclick="chEvent('immEnrich')"> Immune Pathways </button> </span>
                                	
                                
                                <table style="width:100%;margin-bottom:10px;">
                                	<tr>
                                		<td class="td1">Cell Type</td>
                                		<td style="width:10px;"></td>
                                		<td style="width:70%;"><span id="celltype_select" ></span></td>
                                	</tr>
                                </table>
                                <div style="margin-left:30%;">
                                	<span id="celltypeMarker"> <button id="celltypeMarkerButton" class="btn btn-warning span-advance-left-button" onclick="chEvent('celltypeMarker')"> Celltype Marker</button> </span>
                                	<span id="TFnet"> <button id="TFnetButton" class="btn btn-warning span-advance-left-button" onclick="chEvent('TFnet')"> TF network</button> </span>
                                	<span id="RBPnet"> <button id="RBPnetButton" class="btn btn-warning span-advance-left-button" onclick="chEvent('RBPnet')"> RBP network</button> </span>
                                </div>
                                <span id="analyse"> <button id="" class="btn btn-warning span-advance-left-button" > <a  class="span-advance-left-button-a" href="#" >Annotation Cell Type</a> </button> </span>
                                			
                                			
                        	</div>
                        	<div class="col-md-9 col-sm-9" id="right-content">
                        		<div id="cellDensity-content" style="display:block;text-align:center;">
									<div id="cellDensityPlot"></div>
								</div>
								<div id="cellCycle-content" style="display:none;text-align:center;">
<!-- 									<div class="col-md-2 col-sm-2"> -->
<!-- 										<h4 class="span-advance-right-methodDes"> Method DescriptionMethod DescriptionMethod DescriptionMethod Description</h4> -->
<!-- 									</div> -->
									<div >
										<ul class="nav nav-tabs">
			                                <li class="active"><a href="#cycle-pie" data-toggle="tab"> <font class="font1">Pie</font>  </a></li>
			                                <li ><a href="#cycle-table" data-toggle="tab"><font class="font1">table</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="cycle-pie" >
												<div id="pieCellCycle" ></div>
			                                </div>
			                                <div class="tab-pane fade" id="cycle-table">
			                                
			                                	<table class="datatableFather">
			                                		<tr>
			                                			<td>
			                                				<table  id="tableCellCycle" class="table table-bordered table-hover dataTable datatable1" >
			                                					<thead >
																	<tr>
																		<th>Cell Name</th>
																		<th>Cell Type </th>	
																		<th>S.Score</th>	
																		<th>G2M.Score</th>
																		<th>Phase</th>							  			
																	</tr>
																</thead>
			                                				</table>
			                                			</td>
			                                			<td valign="top">
					              							<a id="tableCellCycle_download" href="download_loading.jsp?path=example/example_normal/Res_cellPredictDownload.txt&name=example_normal.txt" title="download table"> <i class="fa fa-arrow-circle-down fa-2x" aria-hidden="true"></i></a>									     		
					              						</td>
			                                		</tr>
			                                	</table>
			                                </div>
			                                
			                            </div>
									</div>
									
                        			
									
								</div>
                        		<div id="cellCorr-content" style="display:none;text-align:center;">
                        			<div >
										<ul class="nav nav-tabs">
			                                <li class="active"><a href="#cellCorr-heatmap" data-toggle="tab"> <font class="font1">Heatmap</font>  </a></li>
			                                <li ><a href="#cellCorr-table" data-toggle="tab"><font class="font1">table</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="cellCorr-heatmap" >
												<div id="HeatmapCellCorr" ></div>
			                                </div>
			                                <div class="tab-pane fade" id="cellCorr-table">
			                                
			                                	<table class="datatableFather">
			                                		<tr>
			                                			<td>
			                                				<table  id="tableCellCorr" class="table table-bordered table-hover dataTable datatable1" >
			                                					<thead >
																	<tr>
																		<th>Cell Type1</th>
																		<th>Cell Type2 </th>	
																		<th>AUROC</th>	
																	</tr>
																</thead>
			                                				</table>
			                                			</td>
			                                			<td valign="top">
					              							<a id="tableCellCorr_download" href="download_loading.jsp?path=example/example_normal/Res_cellPredictDownload.txt&name=example_normal.txt" title="download table"> <i class="fa fa-arrow-circle-down fa-2x" aria-hidden="true"></i></a>									     		
					              						</td>
			                                		</tr>
			                                	</table>
			                                </div>
			                                
			                            </div>
									</div>
										
                        		</div>
                        		<div id="cellCellCom-content" style="display:none; text-align:center;">
									<div >
										<ul class="nav nav-tabs">
			                                <li class="active"><a href="#cellCellCom-river" data-toggle="tab"> <font class="font1">river</font>  </a></li>
			                                <li ><a href="#cellCellCom-table" data-toggle="tab"><font class="font1">table</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="cellCellCom-river" >
												<div id="RiverCellCellCom" ></div>
			                                </div>
			                                <div class="tab-pane fade" id="cellCellCom-table">
			                                
			                                	<table class="datatableFather">
			                                		<tr>
			                                			<td>
			                                				<table  id="tableCellCellCom" class="table table-bordered table-hover dataTable datatable1" >
			                                					<thead >
																	<tr>
																		<th>Ligand</th>
																		<th>Sending Cell Type</th>
																		<th>Ligand Expression</th>
																		<th>Receptor</th>
																		<th>Receiving Cell Type</th>
																		<th>Receptor Expression</th>
																		<th>Function</th>
																		<th>Score</th>	
																	</tr>
																</thead>
			                                				</table>
			                                			</td>
			                                			<td valign="top">
					              							<a id="tableCellCellCom_download" href="download_loading.jsp?path=example/example_normal/Res_cellPredictDownload.txt&name=example_normal.txt" title="download table"> <i class="fa fa-arrow-circle-down fa-2x" aria-hidden="true"></i></a>									     		
					              						</td>
			                                		</tr>
			                                	</table>
			                                </div>
			                                
			                            </div>
									</div>

                        		</div>
                        		
                        		<div id="goEnrich-content" style="display:none; text-align:center;">
<!--                         			####### -->
									<div >
										<ul class="nav nav-tabs">
			                                <li class="active"><a href="#GO-heatmap" data-toggle="tab"> <font class="font1">heatmap</font>  </a></li>
			                                <li ><a href="#GO-table" data-toggle="tab"><font class="font1">table</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="GO-heatmap" >
												<div id="HeatmapGO_BP" ></div>
			                                </div>
			                                <div class="tab-pane fade" id="GO-table">
			                                
			                                	<table class="datatableFather">
			                                		<tr>
			                                			<td>
			                                				<table  id="tableGO" class="table table-bordered table-hover dataTable datatable1" >
			                                					<thead >
																	<tr>
																		<th>Celltype</th>
																		<th>Pathway</th>
																		<th>P value</th>
																		<th>FDR value</th>
																		<th>Markers</th>
																	</tr>
																</thead>
			                                				</table>
			                                			</td>
			                                			<td valign="top">
					              							<a id="tableGO_download" href="download_loading.jsp?path=example/example_normal/Res_cellPredictDownload.txt&name=example_normal.txt" title="download table"> <i class="fa fa-arrow-circle-down fa-2x" aria-hidden="true"></i></a>									     		
					              						</td>
			                                		</tr>
			                                	</table>
			                                </div>
			                                
			                            </div>
									</div>
<!--                         			####### -->
                        		</div>
                        		<div id="keggEnrich-content" style="display:none; text-align:center;">
<!--                         			####### -->
									<div >
										<ul class="nav nav-tabs">
			                                <li class="active"><a href="#KEGG-heatmap" data-toggle="tab"> <font class="font1">heatmap</font>  </a></li>
			                                <li ><a href="#KEGG-table" data-toggle="tab"><font class="font1">table</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="KEGG-heatmap" >
												<div id="HeatmapKEGG" ></div>
			                                </div>
			                                <div class="tab-pane fade" id="KEGG-table">
			                                
			                                	<table class="datatableFather">
			                                		<tr>
			                                			<td>
			                                				<table  id="tableKEGG" class="table table-bordered table-hover dataTable datatable1" >
			                                					<thead >
																	<tr>
																		<th>Celltype</th>
																		<th>Pathway</th>
																		<th>P value</th>
																		<th>FDR value</th>
																		<th>Markers</th>
																	</tr>
																</thead>
			                                				</table>
			                                			</td>
			                                			<td valign="top">
					              							<a id="tableKEGG_download" href="download_loading.jsp?path=example/example_normal/Res_cellPredictDownload.txt&name=example_normal.txt" title="download table"> <i class="fa fa-arrow-circle-down fa-2x" aria-hidden="true"></i></a>									     		
					              						</td>
			                                		</tr>
			                                	</table>
			                                </div>
			                                
			                            </div>
									</div>
<!--                         			####### -->
                        		</div>
                        		<div id="cellstateEnrich-content" style="display:none; text-align:center;">
<!--                         			####### -->
									<div >
										<ul class="nav nav-tabs">
			                                <li class="active"><a href="#cellstat-heatmap" data-toggle="tab"> <font class="font1">heatmap</font>  </a></li>
			                                <li ><a href="#cellstat-table" data-toggle="tab"><font class="font1">table</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="cellstat-heatmap" >
												<div id="Heatmapcellstat" ></div>
			                                </div>
			                                <div class="tab-pane fade" id="cellstat-table">
			                                
			                                	<table class="datatableFather">
			                                		<tr>
			                                			<td>
			                                				<table  id="tablecellstat" class="table table-bordered table-hover dataTable datatable1" >
			                                					<thead >
																	<tr>
																		<th>Celltype</th>
																		<th>Pathway</th>
																		<th>P value</th>
																		<th>FDR value</th>
																		<th>Markers</th>
																	</tr>
																</thead>
			                                				</table>
			                                			</td>
			                                			<td valign="top">
					              							<a id="tablecellstat_download" href="download_loading.jsp?path=example/example_normal/Res_cellPredictDownload.txt&name=example_normal.txt" title="download table"> <i class="fa fa-arrow-circle-down fa-2x" aria-hidden="true"></i></a>									     		
					              						</td>
			                                		</tr>
			                                	</table>
			                                </div>
			                                
			                            </div>
									</div>
<!--                         			####### -->
                        		</div>
                        		<div id="immEnrich-content" style="display:none; text-align:center;">
<!--                         			####### -->
									<div >
										<ul class="nav nav-tabs">
			                                <li class="active"><a href="#immue-heatmap" data-toggle="tab"> <font class="font1">heatmap</font>  </a></li>
			                                <li ><a href="#immue-table" data-toggle="tab"><font class="font1">table</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="immue-heatmap" >
												<div id="Heatmapimmue" ></div>
			                                </div>
			                                <div class="tab-pane fade" id="immue-table">
			                                
			                                	<table class="datatableFather">
			                                		<tr>
			                                			<td>
			                                				<table  id="tableimmue" class="table table-bordered table-hover dataTable datatable1" >
			                                					<thead >
																	<tr>
																		<th>Celltype</th>
																		<th>Pathway</th>
																		<th>P value</th>
																		<th>FDR value</th>
																		<th>Markers</th>
																	</tr>
																</thead>
			                                				</table>
			                                			</td>
			                                			<td valign="top">
					              							<a id="tableimmue_download" href="download_loading.jsp?path=example/example_normal/Res_cellPredictDownload.txt&name=example_normal.txt" title="download table"> <i class="fa fa-arrow-circle-down fa-2x" aria-hidden="true"></i></a>									     		
					              						</td>
			                                		</tr>
			                                	</table>
			                                </div>
			                                
			                            </div>
									</div>
<!--                         			####### -->
                        		</div>
<!--  celltype single                       		 -->
                        		
                        		<div id="celltypeMarker-content" style="display:none; text-align:center;" >
                        			
                        			<table style="width:40%;margin-bottom:10px;text-align:left;">
	                                	<tr>
	                                		<td class="td1">Marker</td>
	                                		<td style="width:10px;"></td>
	                                		<td style="width:70%;"><span id="marker_select" ></span></td>
	                                	</tr>
	                                </table>
<!--                         			###### -->
                        			<div >
										<ul class="nav nav-tabs">
			                                <li class="active"><a href="#marker-violin" data-toggle="tab"> <font class="font1">violin</font>  </a></li>
			                                <li ><a href="#marker-feature" data-toggle="tab"><font class="font1">feature</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="marker-violin" >
												<div id="markerViolin" ></div>
			                                </div>
			                                <div class="tab-pane fade" id="marker-feature">
			                                	<div class="col-md-6 col-sm-6" id="markerFeatureUMAP" style="height:600px;"></div>
			                                	<div class="col-md-6 col-sm-6" id="markerFeaturetSNE" style="height:600px;"></div>
			                                	
			                                	
			                                </div>
			                                
			                            </div>
									</div>
<!--                         			####### -->
                        			
                        		</div>
                        		<div id="TFnet-content" style="display:none; text-align:center;">
                        			<h4 class="span-advance-right-methodDes"> Method Description</h4>
                        			<table style="width:40%;margin-bottom:10px;text-align:left;">
	                                	<tr>
	                                		<td class="td1">TF</td>
	                                		<td style="width:10px;"></td>
	                                		<td style="width:70%;"><span id="TF_select" ></span></td>
	                                	</tr>
	                                </table>
<!--                         		###### -->
                        			<div >
										<ul class="nav nav-tabs">
			                                <li class="active"><a href="#tf-circos" data-toggle="tab"> <font class="font1">circos</font>  </a></li>
			                                <li ><a href="#tf-table" data-toggle="tab"><font class="font1">table</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="tf-circos" >
												<div id="tfCircos" ></div>
			                                </div>
			                                <div class="tab-pane fade" id="tf-table">
			                                	<table  id="tableTF" class="table table-bordered table-hover dataTable datatable1" >
			                                		<thead >
														<tr>
															<th>TF</th>
															<th>Cell </th>	
															<th>Cell type </th>	
															<th>AUC score </th>			
														</tr>
														</thead>
			                                	</table>
			                                	
			                                	
			                                </div>
			                                
			                            </div>
									</div>
<!--                             ####### -->
                        		</div>
                        		<div id="RBPnet-content" style="display:none; text-align:center;">
                        			<h4 class="span-advance-right-methodDes"> Method Description</h4>
                        			<table style="width:40%;margin-bottom:10px;text-align:left;">
	                                	<tr>
	                                		<td class="td1">RBP</td>
	                                		<td style="width:10px;"></td>
	                                		<td style="width:70%;"><span id="RBP_select" ></span></td>
	                                	</tr>
	                                </table>
<!--                         		<!--                         		<!--                         			###### -->
                        			<div >
										<ul class="nav nav-tabs">
			                                <li class="active"><a href="#rbp-circos" data-toggle="tab"> <font class="font1">circos</font>  </a></li>
			                                <li ><a href="#rbp-table" data-toggle="tab"><font class="font1">table</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="rbp-circos" >
												<div id="rbpCircos" ></div>
			                                </div>
			                                <div class="tab-pane fade" id="rbp-table">
			                                	<table  id="tableRBP" class="table table-bordered table-hover dataTable datatable1" >
			                                		<thead >
														<tr>
															<th>RBP</th>
															<th>Cell </th>	
															<th>Cell type </th>	
															<th>AUC score </th>			
														</tr>
														</thead>
			                                	</table>
			                                	
			                                	
			                                </div>
			                                
			                            </div>
									</div>
<!--                         			####### -->
                        		</div>
                        		
                        		
                        	</div>
                        </div>
            		</div>
            	</div>
            </div>    
                
            
     <!-- CONTENT-WRAPPER SECTION END-->
    <section class="footer-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12" style="font-size:16px;">
                   Copyright &copy; 2023.Harbin Medical University & Hainan  Medical University</div>

            </div>
        </div>
    </section>
      <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT FILES PLACED AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <!-- CORE JQUERY  -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
    <!-- DATATABLE SCRIPTS  -->
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
    <script src="js/echarts.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/AtlasDetailsOld.js"></script>
</body>
</html>