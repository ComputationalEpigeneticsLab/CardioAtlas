function GoQC(){
	var share_reference="";
	share_reference = xmSelect.get('#share_reference', true).getValue('valueStr');
	var resolution="";
	var resolution=document.getElementById("resolution").value.replace(/(^\s*)|(\s*$)/g, "");
	if(share_reference == "" || null){alert("Please select a reference for your task!");return false;}
	if(resolution == "" || null){alert("Please input the resolution for your task!");return false;}
	// email 
    var email_address=document.getElementById("email_address").value.replace(/(^\s*)|(\s*$)/g, "");
	  if(email_address == "" || null){
		  alert("Please input email address for your research!");
			return false;
	  }else{
		  var reg = /^[0-9a-zA-Z_.-]+[@][0-9a-zA-Z_.-]+([.][a-zA-Z]+){1,2}$/;
		  if (!reg.test(email_address)) {
			  alert("Please input right address for your research!");
			  return false;
		  }
	  }
	//upload file infor
	var uploadFile = document.getElementById("upload_file_score");
    var file_e = uploadFile.value;
    if (file_e == "" || null) {
		alert("Please select Expression Data file for your search!");
		return false;
	}
    
    let formData = new FormData();
    formData.append("file",uploadFile.files[0]);//文件
    formData.append("fileSize",uploadFile.files[0].size.toString());//文件大小
    formData.append("fileName",uploadFile.files[0].name);//文件名

    var maxsize=1024 * 1024 * 500; // 最大上传文件大小：500MB
    if(uploadFile.files[0].size.toString()> maxsize){
    	alert("File too large !");
    	return false;
    }
    // file upload to web
	var xmlHttp=new XMLHttpRequest();
	xmlHttp.onreadystatechange =function(){
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
			var returnData=xmlHttp.responseText;
			var jsonobj=JSON.parse(returnData);
			var UserUploadFileName =jsonobj.filename;//文件名 全局变量
			var UserUploadFileNamePath =jsonobj.filepath;//上传的路径全局变量
			var UserTaskID=jsonobj.Randompathname;//上传的upload下的随机的文件名
			//show infor in page
			$("#taskIdShow").show();
			document.getElementById("taskIdShowContent").innerHTML="Task ID :&nbsp;&nbsp; <strong style=''> "+UserTaskID+"</strong> .";
			//satrt seurat qc////////////////////////
			var param_qc="";
			param_qc="UserTaskID="+UserTaskID+"&UserUploadFileName="+UserUploadFileName+"&email_address="+email_address+"&share_reference="+share_reference+"&resolution="+resolution;
			param_next="UserTaskID="+UserTaskID;
			var xmlHttp_run=new XMLHttpRequest();
			xmlHttp_run.onreadystatechange =function(){
				if(xmlHttp_run.readyState == 4 && xmlHttp_run.status == 200){
					var returnData_run=xmlHttp_run.responseText;
					var jsonobj_run=JSON.parse(returnData_run); 
					if(jsonobj_run.error_attention=="no"){
						//alert("success");
						window.location.href="AnnotationQC.jsp?"+param_next;	
					}else{
						$("#taskIdShowError").show();
					}
				}
			}
			xmlHttp_run.open("get","QualityControlRun.jsp?"+param_qc,true);
			xmlHttp_run.send();
			
		}
	}
	var param_address="email_address="+email_address;
	xmlHttp.open("POST","FileUploadSave_sendmaile?"+param_address,true);//文件用 post 传参
	xmlHttp.send(formData);
}

function goRest(){
	window.location.href="AnnotationCellType.jsp";
}
function goExample(){
	window.location.href="AnnotationResult.jsp?UserTaskID=functionExample";
}
//uesr File upload
//点击添加文件
$(document).on('click', '.addImg', function(){
	$(this).parent().find('.upload_input').click();
});
//点击删除选中的文件
$(document).on('click', '.delete', function(){
		  $("#FileSuccessNameTable").hide();
	$(this).parent().find('input').val('');
	//$(this).parent().find('img.preview').attr("src","img/base.png");
	//IE9以下
	$(this).parent().find('img.preview').css("filter","");
	$(this).hide();
	$(this).parent().find('.addImg').show();
	//$("#preview").show();
	//document.getElementById("successBack").innerHTML="";

});
//选择图片
function change(file) {
	//预览
	var pic = $(file).parent().find(".preview");
	//添加按钮
	var addImg = $(file).parent().find(".addImg");
	//删除按钮
	var deleteImg = $(file).parent().find(".delete");
	
	var ext=file.value.substring(file.value.lastIndexOf(".")+1).toLowerCase();
			
	// 判断文件类型
	if(ext!='txt'&&ext!='csv'){
	    if (ext != '') {
	        alert("The upload file format must be TXT or CSV！");
	    }
	    return;
	}else{
		  
		  //打开删除按钮
		      deleteImg.show();
		  //关闭初始图像
		      addImg.hide();
		    //获取文件名
		  var uploadFileName = document.getElementById("upload_file_score").files[0].name;
		      	if (uploadFileName.length>40){
		      		uploadFileName=uploadFileName.substring(0,10)+"..."+ext;
		      	}
		  //alert(uploadFileName.length);
		  //传递文件名并显示
		  document.getElementById("FileSuccessName").innerHTML=uploadFileName;
		  $("#FileSuccessNameTable").show();
	}

}

// ref select
var share_reference = xmSelect.render({
													el: '#share_reference',
													height: '500px',
													direction: 'up',//向上展开
													name: 'share_reference',//表单的name属性
													size: 'large',//选中的之后显示的字的大小
												    theme: {color: '#f0ad4e',},//主题颜色
												    tips: 'Select a reference for your job',
													autoRow: true,
													cascader: {
														show: true,
														indent: 400,
												 		strict: false,
												 		
													},
													
													iconfont: {
												 		parent: 'hidden',
													},
													radio: true,
													clickClose: true,
													data(){
														return [
															{name: 'Human', value: -1,  children: [
																
																{name: 'Dilated cardiomyopathy (DCM)', value: 'sctype_atlas_human_adult_DCM_marker',selected: true},
																{name: 'Cardiac hypertrophy (CH)', value: 'sctype_atlas_human_adult_CH_marker'},
																{name: 'Congenital heart disease (CHD)', value: 'sctype_atlas_human_CHD_marker'},
																{name: 'Heart failure (HF)', value: 'sctype_atlas_human_adult_HF_marker'},
																{name: 'Hypertrophic cardiomyopathy (HCM)', value: 'sctype_atlas_human_adult_HCM_marker'},
																{name: 'Hypoplastic left heart syndrome (HLHS)', value: 'sctype_atlas_human_HLHS_marker'},
																{name: 'Ischemic cardiomyopathy (ICM)', value: 'sctype_atlas_human_adult_ICM_marker'},
																{name: 'Myocardial infarction (MI)', value: 'sctype_atlas_human_adult_MI_marker'},
																{name: 'Tetralogy of fallot (TOF)', value: 'sctype_atlas_human_TOF_marker'},
																{name: 'Normal adult', value: 'sctype_atlas_human_adult_normal_marker'},
																{name: 'Normal young', value: 'sctype_atlas_human_young_normal_marker'},
																{name: 'Normal fetal', value: 'sctype_atlas_human_fetal_normal_marker'},
																
																{name: 'Minor cell type', value: 'sctype_human_heart_marker_small'},
																
															]},
															{name: 'Mouse', value: -2,  children: [
																{name: 'Atherosclerosis (AS)', value: 'sctype_atlas_Mus_adult_Aorta_marker'},
																{name: 'Cardiac hypertrophy (CH)', value: 'sctype_atlas_Mus_adult_MH_marker'},
																{name: 'Diabetic cardiomyopathy (Diabetes)', value: 'sctype_atlas_Mus_DM_marker'},
																{name: 'Epicardial deficient (EPD)', value: 'sctype_atlas_Mus_fetal_EPD_marker'},
																{name: 'Mitochondrial cardiomyopathy (MC)', value: 'sctype_atlas_Mus_MC_marker'},
																{name: 'Myocarditis (MYO)', value: 'sctype_atlas_Mus_young_MYO_marker'},
																{name: 'Pressure overload (PO)', value: 'sctype_atlas_Mus_adult_PO_marker'},
																{name: 'Septic myocardial injury (SICM)', value: 'sctype_atlas_Mus_adult_SICM_marker'},
																{name: 'Heart failure (HF)_JQ1_inhibitor', value: 'sctype_atlas_Mus_HF_JQ1_inhibitor_marker'},
																{name: 'Heart failure (HF)', value: 'sctype_atlas_Mus_adult_HF_marker'},
																{name: 'Myocardial infarction (MI)', value: 'sctype_atlas_Mus_adult_MI_marker'},
																{name: 'Myocardial infarction (MI)_TanIIA', value: 'sctype_atlas_Mus_MI_TanIIA_treatment_marker'},
																{name: 'Normal adult', value: 'sctype_atlas_Mus_normal_marker'},
																{name: 'Normal young', value: 'sctype_atlas_Mus_young_normal_marker'},
																{name: 'Normal fetal', value: 'sctype_atlas_Mus_fetal_normal_marker'},
																
																
																
																{name: 'Minor cell type (Aorta)', value: 'sctype_Mus_musculus_Aorta_marker_small'},
																{name: 'Minor cell type (heart)', value: 'sctype_Mus_musculus_heart_marker_small'},
																
																
															                     			]},
														]
													},
													on: function(data){//监听
														var arr = data.arr;
														var change = data.change;
														//isAdd, 此次操作是新增还是删除
														var isAdd = data.isAdd;
														//alert(arr[0]["value"]);	
														
													}
												})