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
                 <h4  style="font-size:25px;color:black;font-weight:600;">Annotation result</h4>
            </div>

        </div>

            <div class="row">
                <div class="col-md-12">
                      <!--    Striped Rows Table  -->
                    <div class="panel panel-success" id="summary">
                        <div class="panel-heading">
                            <strong style="font-size:20px;color:black">Dataset Summary</strong>
                        </div>
                        <div class="panel-body">
                        	<div class="col-md-6">
                            <div class="table-responsive">
                                <table class="table table-striped" style="font-size:16px;margin-top:40px;">
                                    <tbody>
                                    	<tr>
                                            <td class="summary-td1">Task id</td>
                                            <td id="taskID"></td>
                                        </tr>
                                    	
                                        <tr>
                                            <td class="summary-td1">Reference</td>
                                            <td id="ref"></td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1">Resolution</td>
                                            <td id="resolution"></td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1"> nFeature</td>
                                            <td id="nFeature"></td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1">nCount</td>
                                            <td id="nCount"></td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1">MT^</td>
                                            <td id="mt"></td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1">File name</td>
                                            <td id="fileName"></td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1"> No. of gene </td>
                                            <td id="geneNum"></td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1"> No. of cell </td>
                                            <td id="cellNum"></td>
                                        </tr>
                                        <tr>
                                            <td class="summary-td1"> No. of cell type</td>
                                            <td id="celltypeNum"></td>
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
			                                
			                                <li ><a href="#go" data-toggle="tab"><font class="font1">GO BP</font> </a></li>
			                                <li ><a href="#kegg" data-toggle="tab"><font class="font1">KEGG</font> </a></li>
			                            </ul>
			
			                            <div class="tab-content" style="text-align:center;">
			                                 
			                                 <div class="tab-pane fade  active in" id="go">
			                                	<div id="HeatmapGO_BP" ></div>
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
			                                	<div id="HeatmapKEGG"  ></div>
			                                	
			                                
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
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
    <script src="assets/js/custom.js"></script>
    <script src="js/echarts.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/AnnotationResult.js"></script>
</body>
</html>