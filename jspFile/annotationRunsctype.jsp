<%@ page import="Util.*" import="java.sql.*" import="java.util.ArrayList"  language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*"%>
    <%@ page import="java.util.List" %>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Run cluster here</title>
</head>
<body>
<%
// get parm
String UserTaskID=request.getParameter("UserTaskID");
String email_address=request.getParameter("email_address");
String resolution=request.getParameter("resolution");
String share_reference=request.getParameter("share_reference");

String nFeature_RNA_form=request.getParameter("nFeature_RNA_form");
String nFeature_RNA_to=request.getParameter("nFeature_RNA_to");
String nCount_RNAt_form=request.getParameter("nCount_RNAt_form");
String nCount_RNA_to=request.getParameter("nCount_RNA_to");
String percent_mt_form=request.getParameter("percent_mt_form");
String percent_mt_to=request.getParameter("percent_mt_to");
//function
String tt="human";
String Rfunction_path_all="";
if(share_reference.contains(String.valueOf(tt))){
	 Rfunction_path_all = getServletContext().getRealPath("/Rfunction")+"/cluster_sctype_annotation_human.R";
}else{
	 Rfunction_path_all = getServletContext().getRealPath("/Rfunction")+"/cluster_sctype_annotation_mouse.R";
}

Rfunction_path_all=Rfunction_path_all.replaceAll("\\\\","/");
//得到taskPath 对应的id文件的位置
String taskPath=getServletContext().getRealPath("/innerpath");
taskPath=taskPath.replaceAll("\\\\","/");
String filePath=getServletContext().getRealPath("/upload")+"/"+UserTaskID;
filePath=filePath.replaceAll("\\\\","/");

RConnection rc = new RConnection();
response.setContentType("text/html;charset=utf-8");
//获取PrintWriter
PrintWriter pw = response.getWriter();
try {
rc.assign("TaskID",UserTaskID);
rc.assign("filePath",filePath);
rc.assign("innerpath",taskPath);
rc.assign("nFeature_RNA_form",nFeature_RNA_form);
rc.assign("nFeature_RNA_to",nFeature_RNA_to);
rc.assign("nCount_RNAt_form",nCount_RNAt_form);
rc.assign("nCount_RNA_to",nCount_RNA_to);
rc.assign("percent_mt_form",percent_mt_form);
rc.assign("percent_mt_to",percent_mt_to);

rc.assign("resolution",resolution);
rc.assign("share_reference",share_reference);

rc.assign("Rfunction_path_all",Rfunction_path_all);
rc.eval("source(Rfunction_path_all)");


REXP result = rc.eval("cluster_sctype_annotation(TaskID,filePath,innerpath,nFeature_RNA_form,nFeature_RNA_to,nCount_RNAt_form,nCount_RNA_to,percent_mt_form,percent_mt_to,resolution,share_reference)");


//pw.println("{"+'"'+"stat"+'"'+":"+'"'+"state_tese"+'"'+','+'"'+"error_attention"+'"'+":"+'"'+"success"+'"'+"}");
//输出数据
 pw.println(result.asString());

System.out.println("down completed");
} catch (Exception e) {
    e.printStackTrace();
    pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"yes"+'"'+"}");
}
//清空缓存
pw.flush();
//关闭
pw.close();
rc.close();
%>
<%
System.out.println(Rfunction_path_all);
// System.out.println(UserTaskID);
// System.out.println(resolution);
// System.out.println(share_reference);
// System.out.println(nFeature_RNA_form);
// System.out.println(nFeature_RNA_to);
// System.out.println(nCount_RNAt_form);
// System.out.println(nCount_RNA_to);
// System.out.println(percent_mt_form);
// System.out.println(percent_mt_to);

%>
</body>
</html>