path_file="0_files/browse_subtable";


function browseSubTable_dataset(path){
	var path=path;
	$(document).ready(function() {
		$("#browse_sub_table_dataset").DataTable( {
		"bLengthChange": false, //开关，是否显示每页显示多少条数据的下拉框
        "aLengthMenu": [5,10,20],//设置每页显示数据条数的下拉选项
        'iDisplayLength': 5, //每页初始显示5条记录
		"deferRender": true,
		"bProcessing": true, 
		"paginationType": "full_numbers",
		"serverSide": false, 
		"order": [[ 0, 'desc' ]],
		'ajax': path,
		'columns':[
		{'data':'species'},
		{'data':'tissue'},
		{'data':'disease'},
		{'data':'cellnum'},
		{'data':'celltypenum'},
		{'data':null,
		"render": function ( data, type, row, meta ) {  
		if(row['species']=="Human"){
			return "<a target='_blank' href=DatasetDetails.jsp?daset="+row['datasets']+"&annotationType=small>" +"<i class='fa-solid fa-share-from-square' aria-hidden='true' style='font-size:15px;'></i></a>";  
		}else{
			return "<a target='_blank' href=DatasetDetailsMus.jsp?daset="+row['datasets']+"&annotationType=small>" +"<i class='fa-solid fa-share-from-square' aria-hidden='true' style='font-size:15px;'></i></a>";  
		}
		
								                    }
		}
		]
		} );  
		} );
}

function browseSubTable_ats(path){
	var path=path;
	$(document).ready(function() {
		$("#browse_sub_table_ats").DataTable( {
		"bLengthChange": false, //开关，是否显示每页显示多少条数据的下拉框
        "aLengthMenu": [5,10,20],//设置每页显示数据条数的下拉选项
        'iDisplayLength': 5, //每页初始显示5条记录
		"deferRender": true,
		"bProcessing": true, 
		"paginationType": "full_numbers",
		"serverSide": false, 
		"order": [[ 0, 'desc' ]],
		'ajax': path,
		'columns':[
		{'data':'species'},
		{'data':'tissue'},
		{'data':'disease'},
		{'data':'cellnum'},
		{'data':'celltypenum'},
		{'data':null,
		"render": function ( data, type, row, meta ) {  
		if(row['species']=="Human"){
			return "<a target='_blank' href=AtlasDetails.jsp?ats="+row['ats']+">" +"<i class='fa-solid fa-share-from-square' aria-hidden='true' style='font-size:15px;'></i></a>";  
		}else{
			return "<a target='_blank' href=AtlasDetailsMus.jsp?ats="+row['ats']+">" +"<i class='fa-solid fa-share-from-square' aria-hidden='true' style='font-size:15px;'></i></a>";  
		}
		
								                    }
		}
		]
		} );  
		} );
}

function changeImg(path){
	for(var dis_type of path){
       d3.select(dis_type)
           .on('click', function () {
               var dis_type_arr = (this.id.split('_'));
				dis_type_name=dis_type_arr[1];
				sp=dis_type_arr[2];
				file_name=dis_type_name+"_"+sp;
				//alert(file_name);
				layui.use(function(){
					  var layer = layui.layer;
					  var $ = layui.$;
						  layer.open({
							  type: 1, // page 层类型
							  area: ['1400px', 'auto'],// 宽高
							  title: '',
							  shade: 0.6, // 遮罩透明度
							  shadeClose: true, // 点击遮罩区域，关闭弹层
							  maxmin: true, // 允许全屏最小化
							  anim: 0, // 0-6 的动画形式，-1 不开启
							  content: $('#layer-package')//锁定到div展示这个div
								  });
						//ats
						var oldTable = $('#browse_sub_table_ats').dataTable();
						oldTable.fnClearTable(); //清空一下table
						oldTable.fnDestroy(); //还原初始化了的dataTable
						browseSubTable_ats(path_file+"/"+file_name+"_ats.txt");
						//_dataset
						var oldTable = $('#browse_sub_table_dataset').dataTable();
						oldTable.fnClearTable(); //清空一下table
						oldTable.fnDestroy(); //还原初始化了的dataTable
						browseSubTable_dataset(path_file+"/"+file_name+"_dataset.txt");
				})
				
           })
          
   }
}

