function taskQuery(){
	var taskId=document.getElementById("taskid").value.replace(/(^\s*)|(\s*$)/g, "");
	if (taskId == "" || null) {
		alert("Please input task id !");
		return false;
	}
	var param="UserTaskID="+taskId;
	/////1.创建异步对象
		var xmlHttp=new XMLHttpRequest();
	/////2.绑定事件
		xmlHttp.onreadystatechange =function(){
			if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
				//alert("success");
				var returnData=xmlHttp.responseText;

				var jsonobj=JSON.parse(returnData);
				if(jsonobj.error_attention=="success"){
					//alert("success");
					//$("#jobIDattention").show();	
					//document.getElementById("taskid_infor").innerHTML=jsonobj.error_attention;
					window.location.href="AnnotationResult.jsp?"+param;
				}else{
					alert(jsonobj.error_attention);
					return false;
				}
					}
				}			
	/////3.初始请求数据
		//获取dom的value数据
		//合并参数

		xmlHttp.open("get","Task_result_judge.jsp?"+param,true);
		//文件用 post 传参
	/////4.发起请求
		xmlHttp.send();
}


