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
    <link href="css/style.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
 <script src="js/73a252e5a4.js" crossorigin="anonymous"></script>
  <script src="js/xm-select.js" ></script>
  <script src="js/d3.min.js" ></script>
  <script src="js/plotly.js" ></script>
</head>
<style>

</style>
<body>
<input name="daset"  id="daset" type="hidden" value=<%=request.getParameter("daset") %> >
<input name="annotationType"  id="annotationType" type="hidden" value=<%=request.getParameter("annotationType") %> >
   
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
     <!-- MENU SECTION END-->
    <div class="content-wrapper">
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                 <table style="height:50px;">
                	<tr>
                		<td><h4  style="font-size:25px;color:black;font-weight:600;">Dataset Details</h4></td>
                		<td style="width:40px;"></td>
                		<td><div id="xml_annoType" style="width:400px;display:none;"> </div>  </td>
                		<td style=""><a id="big_Re" href="#" class="btn btn-default btn-lg" onclick="changeAnno('big')">Major cell type </a></td>
                		<td style="width:40px;"></td> 
                		<td style=""><a id="small_Re" href="#" class="btn btn-default btn-lg" onclick="changeAnno('small')">Minor cell type</a></td>
                		
                	</tr>
                </table>
            </div>

        </div>

            <div class="row">
                <div class="col-md-12">
                      <!--    Striped Rows Table  -->
                    <div class="panel panel-success" id="summary">
                        <div class="panel-heading">
                            <strong style="font-size:20px;color:black">Data Set Summary</strong>
                        </div>
                        <div class="panel-body">
                        	<div class="col-md-6">
                            <div class="table-responsive">
                                <table class="table table-striped" style="font-size:16px;margin-top:40px;">
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
<!--                                         <tr style="dispaly:none;"> -->
<!--                                             <td class="summary-td1"> Annotation </td> -->
<!--                                             <td><a id="Annotation" href="###"> Human adult atlas normal</a> </td> -->
<!--                                         </tr> -->
                                        
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
										<tr>
                                            <td class="summary-td1"> Publication</td>
                                            <td ><a id="Publication" href="#">NATURE</a></td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1"> Download</td>
                                            <td ><button class="btn btn-warning panel-down-ww">  <a id="dataset_download" class="panel-down-ww-a" href="#"><i class="fa-solid fa-download panel-li"></i> </a></button></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            </div>
                            <div class="col-md-6">
                            	<div id="cellDensityPlot"></div>
                            </div>
                        </div>                        
                    </div>
                    <!--  End  Striped Rows Table  -->
                    
                </div>
                <div class="col-md-12">
                    <div class="panel panel-success" id="overview">
                        <div class="panel-heading">
                            <strong style="font-size:20px;color:black">Dataset Overview</strong>
                        </div>
                        <div class="panel-body">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#overview-umap" data-toggle="tab"> <font class="font1">UMAP</font>  </a></li>
                                <li ><a href="#overview-tsne" data-toggle="tab"><font class="font1">tSNE</font> </a></li>
<!--                                 <li ><a href="#cellDentisy" data-toggle="tab"><font class="font1">Cell Density</font> </a></li> -->
                            </ul>

                            <div class="tab-content" style="text-align:center;min-height:600px;">
                                <div class="tab-pane fade active in" id="overview-umap" >
                                 <div class="col-md-6">
                                 	<div id="umap_cluster" ></div>
                                 </div>
                                 <div class="col-md-6">
                                 	<div id="umap" ></div>
                                 </div>
									
                                </div>
                                <div class="tab-pane fade" id="overview-tsne">
                                	<div class="col-md-6">
                                		<div id="tsne_cluster" ></div>
                                	</div>
                                	<div class="col-md-6">
                                		<div id="tsne" ></div>
                                	</div>
                                	
                                </div>

                                
                            </div>
                        </div>
                    </div>
                </div>
<!--                 ///////////////// marker  -->
				<div class="col-md-12">
                      <!--    Striped Rows Table  -->
                    <div class="panel panel-success" id="marker">
                        <div class="panel-heading">
                            <strong style="font-size:20px;color:black">Dataset Markers</strong>
                        </div>
                        <div class="panel-body">
                            <div id="markerTable" class="col-md-12">
                            	<p class="table_title"> Marker genes of cell types</p>
								<table class="datatableFather" >
			                                		<tr>
			                                			<td>
			                                				<table  id="marker_table" class="table table-bordered table-hover dataTable cell_infor_table_detail" style="width:100%;">
			                                					<thead >
																<tr class="table_head1">
																<th>Cell Type</th>
																<th>Marker</th>
																<th>P Value</th>	
																<th>FDR Value</th>		
																<th>log2FC</th>						  			
															</tr>
																</thead>
			                                				</table>
			                                			</td>
			                                			<td valign="top">
					              							<a id="marker_table_download" href="download_loading.jsp?path=example/example_normal/Res_cellPredictDownload.txt&name=example_normal.txt" title="download table"> <i class="fa fa-arrow-circle-down fa-2x" aria-hidden="true"></i></a>									     		
					              						</td>
			                                		</tr>
			                     </table>
			                     <div  id="marker_heatmap" style="max-height:800px;overflow:auto;">
									<img id="marker_heatmap_img" src=""  style="width:100%">
					              </div>
					            <div id="marker_cluster_marker_violin" class="col-md-7 ">
					            	 <table style="margin-top:50px;margin-bottom:10px;" >
	                                	<tr>
	                                		<td class="td1">Select a cell type and marker </td>
	                                		<td style="width:10px;"></td>
	                                		<td style="width:200px;"><span id="sc_celltype_select" ></span></td>
	                                		<td style="width:10px;"></td>
	                                		<td style="width:300px;"><span id="sc_celltype_marker_select" ></span></td>
	                                	</tr>
	                                </table>
					            </div>  
					            <div class="col-md-12 " id="markerViolin" ></div>
						            <div class="col-md-6 " id="markerFeatureUMAP" style="height:600px;"></div>
				                    <div class="col-md-6 " id="markerFeaturetSNE" style="height:600px;"></div>
			                    
                            </div>
                        </div>

                        
                    </div>
                    <!--  End  Striped Rows Table  -->
                    
                </div>
<!--                 ///////////////// marker end -->
<!-- 					////////////////// function -->
<div class="col-md-12" id="function">
                      <!--    Striped Rows Table  -->
                    <div class="panel panel-success" >
                        <div class="panel-heading">
                            <strong style="font-size:20px;color:black">Functional Annotation </strong>
                        </div>
                        <div class="panel-body">
                        	<div class="col-md-12">
                        				<ul class="nav nav-tabs">
			                                <li class="active"><a href="#cell_cycle" data-toggle="tab"> <font class="font1">Cell cycle</font>  </a></li>
			                                <li ><a href="#cell_corr" data-toggle="tab"><font class="font1">Cell type correlation</font> </a></li>
			                                
			                                <li ><a href="#imm" data-toggle="tab"><font class="font1">Immune pathway</font> </a></li>
			                                <li ><a href="#cell_state" data-toggle="tab"><font class="font1">Cell state</font> </a></li>
			                                <li ><a href="#go" data-toggle="tab"><font class="font1">GO BP</font> </a></li>
			                                <li ><a href="#kegg" data-toggle="tab"><font class="font1">KEGG</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                <div class="tab-pane fade active in" id="cell_cycle" >
												<div class="col-md-6">
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
												<div class="col-md-6" style="margin-top:30px;">
													<div id="pieCellCycle" ></div>
												</div>
			                                </div>
			                                <div class="tab-pane fade" id="cell_corr">
			                                	<div id="HeatmapCellCorr" ></div>
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
			                                
			                                 <div class="tab-pane fade" id="imm">
			                                	<div id="Heatmapimmue" ></div>
			                                	<table class="datatableFather" id="immue-table">
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
			                                 <div class="tab-pane fade" id="cell_state">
			                                	<div id="Heatmapcellstat" ></div>
			                                	<table class="datatableFather" id="cellstat-table">
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
			                                 <div class="tab-pane fade" id="go">
			                                	<div id="HeatmapGO_BP" style="max-height:600px;overflow:auto;"></div>
			                                	<table class="datatableFather" id="GO-table">
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
			                                 <div class="tab-pane fade" id="kegg">
			                                	<div id="HeatmapKEGG"  style="max-height:600px;overflow:auto;"></div>
			                                	
			                                
			                                	<table class="datatableFather" id="KEGG-table">
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
                        </div>                        
                    </div>
                </div>
<!--                    ///////////// function end -->
<!-- ////////////////// tf  -->
<div class="col-md-12">
                      <!--    Striped Rows Table  -->
                    <div class="panel panel-success" id="tf_act">
                        <div class="panel-heading">
                            <strong style="font-size:20px;color:black">Gene Regulatory Network</strong>
                        </div>
                        <div class="panel-body" id="tf_act_content">
                        	<div class="col-md-6">
		                        		<table style="width:100%;margin-bottom:10px;text-align:left;">
			                                	<tr>
			                                		<td class="td1">Select a cell type and TF </td>
			                                		<td style="width:200px;"><span id="celltype_select" ></span></td>
			                                		<td style="width:10px;"></td>
			                                		<td style="width:200px;"><span id="TF_select" ></span></td>
			                                	</tr>
			                             </table>
		                        	</div>
		                        	<div class="col-md-12">
                        		<div class="col-md-6">
                        			
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
                        		<div class="col-md-6">
                        			
                        			<div id="tfCircos" ></div>
                        		</div>
                        	</div>
                            
                        </div>                        
                    </div>
                    
                </div>
<!-- ////////////// tf end -->
<!-- ////////////// cel cell  -->
<div class="col-md-12">
                      <!--    Striped Rows Table  -->
                    <div class="panel panel-success" id="tf_act">
                        <div class="panel-heading">
                            <strong style="font-size:20px;color:black">Cell-cell Communication </strong>
                        </div>
                        <div class="panel-body">
                        	
		                  
                        		<div class="col-md-12">
                        			
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
                        		<div class="col-md-12">
                        			<div id="RiverCellCellCom" ></div>
                        		</div>
                        	
                            
                        </div>                        
                    </div>
                    
                </div>
<!-- ////////////// cel cell end -->
            </div>
             
                
            
     <!-- CONTENT-WRAPPER SECTION END-->
    <section class="footer-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12" style="font-size:16px;">
                   Copyright &copy; 2023.Harbin Medical University </div>

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
    <script src="js/DatasetDetails_1.js"></script>
    <script type="text/javascript">
    function changeAnno(type){
    	if (type=="small"){
    		window.location.href="DatasetDetails.jsp?daset="+daset+"&annotationType=small";
    	}else{
    		window.location.href="DatasetDetails.jsp?daset="+daset+"&annotationType=big";
    		}
    }
    </script>
</body>
</html>