UserTaskID=document.getElementById("UserTaskID").value;
webpath="upload/"+UserTaskID;
cluster_re="";
$.ajaxSettings.async = false;
$.getJSON(webpath+"/qc_re.txt", "", function(data_re) {
	cluster_re=data_re;
});
email_address=cluster_re.email_address;
resolution=cluster_re.resolution;
share_reference=cluster_re.share_reference;




 function goContinue(){
	var nFeature_RNA_form=document.getElementById("nFeature_RNA_form").value;
	var nFeature_RNA_to=document.getElementById("nFeature_RNA_to").value;
	var nCount_RNAt_form=document.getElementById("nCount_RNAt_form").value;
	var nCount_RNA_to=document.getElementById("nCount_RNA_to").value;
	var percent_mt_form=document.getElementById("percent_mt_form").value;
	var percent_mt_to=document.getElementById("percent_mt_to").value;
	
	$("#taskIdShow").show();
	document.getElementById("taskIdShowContent").innerHTML="Task ID :&nbsp;&nbsp; <strong style=''> "+UserTaskID+"</strong> ."
	//
	var param_cluster="";
	param_cluster="UserTaskID="+UserTaskID+"&nFeature_RNA_form="+nFeature_RNA_form+"&nFeature_RNA_to="+nFeature_RNA_to+"&nCount_RNAt_form="+nCount_RNAt_form+"&nCount_RNA_to="+nCount_RNA_to+"&percent_mt_form="+percent_mt_form+	"&percent_mt_to="+percent_mt_to+"&email_address="+email_address+"&resolution="+resolution+"&share_reference="+share_reference;
	param_next="UserTaskID="+UserTaskID;
	var xmlHttp=new XMLHttpRequest();
	xmlHttp.onreadystatechange =function(){
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
			var returnData=xmlHttp.responseText;
			var jsonobj=JSON.parse(returnData);
			if(jsonobj.error_attention=="no"){
				//alert("down success");
				if(share_reference.indexOf("human")!= -1){
					window.location.href="AnnotationResult.jsp?"+param_next;
				}else{
					window.location.href="AnnotationResultMus.jsp?"+param_next;
				}
				// send mail
				SendMail_success_part(email_address,UserTaskID)
			}else{
				$("#taskIdShowError").show();
				$("#taskIdShow").hide();
				// send error mail
				SendMail_error(email_address,UserTaskID)
			}
		}
	}
	
	xmlHttp.open("get","annotationRunsctype.jsp?"+param_cluster,true);
	xmlHttp.send();
}

function SendMail_error(address,jobID){
		var address=address;
		var jobID=jobID;
			var xmlHttp=new XMLHttpRequest();
			xmlHttp.onreadystatechange =function(){
				if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
					//console.log("success");
					//var returnData=xmlHttp.responseText;
					//var param="task_id="+jobID;
					//window.location.href="jobIDshow.jsp?"+param;
					console.log("mail error send success");
						}
					}			
		/////
			var RecipientAddress=address;
			var mailContent="Dear CardioAtlas user,something wrong with your task, please check your upload file or parameters.";
			var param="RecipientAddress="+RecipientAddress+"&mailContent="+mailContent;
			xmlHttp.open("get","MainSendMail?"+param,true);
			
			xmlHttp.send();
		}

function SendMail_success_part(address,jobID){
		var address=address;
		var jobID=jobID;
			var xmlHttp=new XMLHttpRequest();
			xmlHttp.onreadystatechange =function(){
				if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
					console.log("mail send success");
						}
					}			
		/////
			var RecipientAddress=address;
			var mailContent="Dear CardioAtlas user, your task is completed. You can check your results by clicking on the link : http://bio-bigdata.hrbmu.edu.cn/CardioAtlas/AnnotationResult.jsp?UserTaskID="+jobID;
			var param="RecipientAddress="+RecipientAddress+"&mailContent="+mailContent;
			xmlHttp.open("get","MainSendMail?"+param,true);
			
			xmlHttp.send();
		}
//violin
//QC_violin_percent_mt
function plotly_violin_percent_mt(filepath){
	d3.csv(filepath, function(err, rows){
		  function unpack(rows, key) {
		  return rows.map(function(row) { return row[key]; });
		  }
		  var data = [{
			  type: 'violin',
			  y: unpack(rows, 'violin_y'),
			  points: 'all',
			  box: {
			    visible: true
			  },
			  boxpoints: false,
			  line: {
			    color: '92D2EB'
			  },
			  fillcolor: '#8dd3c7',
			  //opacity: 0.6,
			  meanline: {
			    visible: true
			  },
			  x0: "percent MT"
			}]
			var layout = {
				height: 500,
			  title: "percent MT",
			  yaxis: {
			    zeroline: false
			  }
			}
			Plotly.newPlot('QC_violin_percent_mt', data, layout);
			});
}
//QC_violin_nCount_RNA
function plotly_violin_nCount(filepath){
	d3.csv(filepath, function(err, rows){
		  function unpack(rows, key) {
		  return rows.map(function(row) { return row[key]; });
		  }
		  var data = [{
			  type: 'violin',
			  y: unpack(rows, 'violin_y'),
			  points: 'all',
			  box: {
			    visible: true
			  },
			  boxpoints: false,
			  line: {
			    color: '#8CC1D6'
			  },
			  fillcolor: '#8dd3c7',
			  //opacity: 0.6,
			  meanline: {
			    visible: true
			  },
			  x0: "nCount RNA"
			}]
			var layout = {
				height: 500,
			  title: "nCount RNA",
			  yaxis: {
			    zeroline: false
			  }
			}
			Plotly.newPlot('QC_violin_nCount_RNA', data, layout);
			});
}
//violin nFeature RNA
function plotly_violin_nFeature(filepath){
	d3.csv(filepath, function(err, rows){
		  function unpack(rows, key) {
		  return rows.map(function(row) { return row[key]; });
		  }
		  var data = [{
			  type: 'violin',
			  y: unpack(rows, 'violin_y'),
			  points: 'all',
			  box: {
			    visible: true
			  },
			  boxpoints: false,
			  line: {
			    color: '#84ACBB'
			  },
			  fillcolor: '#8dd3c7',
			  //opacity: 0.6,
			  meanline: {
			    visible: true
			  },
			  x0: "nFeature RNA"
			}]
			var layout = {
				height: 500,
			  title: "nFeature RNA",
			  yaxis: {
			    zeroline: false
			  }
			}
			Plotly.newPlot('QC_violin_nFeature_RNA', data, layout);
			});
}










function plotly_violin(filepath){
	d3.csv(filepath, function(err, rows){
		  function unpack(rows, key) {
		  return rows.map(function(row) { return row[key]; });
		  }

		var data = [{
		  type: 'violin',
		  x: unpack(rows, 'violin_x'),
		  y: unpack(rows, 'violin_y'),
		  points: 'all',
		  box: {
		  	    visible: true
		  	  },    	  
		  meanline: {
		  	    visible: true
		  	  },
		  transforms: [{
		  	 type: 'groupby',
			 groups: unpack(rows, 'violin_x'),

			 styles: [
				{target: 'Sun', value: {line: {color: 'nFeature RNA'}}},
				{target: 'Sat', value: {line: {color: 'nCount RNA'}}},
				{target: 'Fri', value: {line: {color: 'percent MT'}}}
			 ]
			}]
		}]


		var layout = {
			height: 500,
		  title: "Multiple Traces Violin Plot",
		  yaxis: {
		    zeroline: false
		  }
		}
		Plotly.newPlot('QC_violin_nFeature_RNA', data, layout);

		});
}