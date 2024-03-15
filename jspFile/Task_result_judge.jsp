<%@ page import="Util.*" import="java.sql.*" import="java.util.ArrayList" import="java.text.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*"%>
    <%@ page import="java.util.*" %>
    <%@ page import="java.sql.ResultSet" %>
	<%@ page import="java.sql.ResultSetMetaData" %>
	<%@ page import="org.rosuda.REngine.REXP"%>
	<%@ page import="org.rosuda.REngine.REXPMismatchException"%>
	<%@ page import="org.rosuda.REngine.Rserve.RConnection"%>
	<%@ page import="org.rosuda.REngine.Rserve.RserveException"%>
	<%@ page import="java.io.File"%>
	<%@ page import="java.io.FileWriter"%>
	<%@ page import="java.io.BufferedWriter"%>
	<%@ page import="java.io.FileReader"%>
	<%@ page import="java.io.BufferedReader"%>
	<%@ page import="java.io.IOException"%>
	<%@ page import="javax.servlet.http.HttpServletRequest" %>
	<%@ page import="javax.servlet.http.HttpSession" %>
	<%@ page import="java.io.*" import="java.text.DateFormat" import="java.util.Date"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Task_ID</title>
</head>
<body>
<%
String task_id_user="";
task_id_user=request.getParameter("UserTaskID");//文件名


Hashtable TaskID_value = new Hashtable();
String file_id_p = getServletContext().getRealPath("/innerpath");
file_id_p=file_id_p.replaceAll("\\\\","/")+"/Job_ID.txt";
BufferedReader br = null;
br = new BufferedReader(new FileReader(file_id_p));
String text = null;
while ((text = br.readLine()) != null) {
	String [] arr=text.split("\t");
	TaskID_value.put(arr[0], arr[1]);
    
		 }
//System.out.println(TaskID_value);
br.close();
//////////使用XMLHttpRequest 输出数据
response.setContentType("text/html;charset=utf-8");
//获取PrintWriter
PrintWriter pw = response.getWriter();

//判断map中是否有key
if(!TaskID_value.containsKey(task_id_user)){
	//System.out.println("nokey");
	pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"No such task id, you can check your task id or submit a task first. "+'"'+"}");
}else{
	
	//System.out.println(TaskID_value.get(task_id_user));
	if (TaskID_value.get(task_id_user).equals("success")){
		//System.out.println("success");
		String re_filr=getServletContext().getRealPath("/upload")+"/"+task_id_user;
		re_filr=re_filr.replaceAll("\\\\","/");
		File file_re = new File(re_filr);  
		if (!file_re.exists()) {
			pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"The retention time has exceeded 180 days, please resubmit. "+'"'+"}");
        }else{
		pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"success"+'"'+"}");
        }
	}else if(TaskID_value.get(task_id_user).equals("dead")){
		pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"There is a problem with your task. Please check and resubmit."+'"'+"}");
	}
	else{		
		//任务正在进行
		pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"The task is in progress. Please wait patiently."+'"'+"}");
	}
}

//清空缓存
pw.flush();
//关闭
pw.close();
%>
</body>
</html>