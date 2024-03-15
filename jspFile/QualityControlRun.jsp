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
<title>Run QC here</title>
</head>
<body>
<%
String UserTaskID=request.getParameter("UserTaskID");
String UserUploadFileName=request.getParameter("UserUploadFileName");
String email_address=request.getParameter("email_address");
String share_reference=request.getParameter("share_reference");
String resolution=request.getParameter("resolution");

// System.out.println(UserTaskID);
// System.out.println(UserUploadFileName);
// System.out.println(email_address);
// System.out.println(share_reference);
// System.out.println(resolution);
%>
<%
String Rfunction_path_all = getServletContext().getRealPath("/Rfunction")+"/SeuratQC.R";
Rfunction_path_all=Rfunction_path_all.replaceAll("\\\\","/");

//得到taskPath 对应的id文件的位置
String taskPath=getServletContext().getRealPath("/innerpath");
taskPath=taskPath.replaceAll("\\\\","/");
String filePath=getServletContext().getRealPath("/upload")+"/"+UserTaskID;
filePath=filePath.replaceAll("\\\\","/");

//获取PrintWriter
PrintWriter pw = response.getWriter();
RConnection rc = new RConnection();

try {

rc.assign("ID_new",UserTaskID);
rc.assign("email_address",email_address);
rc.assign("share_reference",share_reference);
rc.assign("resolution",resolution);
rc.assign("filePath",filePath);
rc.assign("fileName",UserUploadFileName);
rc.assign("innerpath",taskPath);
rc.assign("Rfunction_path_all",Rfunction_path_all);

rc.eval("source(Rfunction_path_all)");
REXP result = rc.eval("SeuratQC(ID_new,filePath,fileName,innerpath,email_address,share_reference,resolution)");
System.out.println(result.asString());

response.setContentType("text/html;charset=utf-8");
//pw.println("{"+'"'+"stat"+'"'+":"+'"'+"state_tese"+'"'+','+'"'+"error_attention"+'"'+":"+'"'+"no"+'"'+"}");
// //输出数据
pw.println(result.asString());
//清空缓存

System.out.println("QC completed");
} catch (Exception e) {
    e.printStackTrace();
    pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"yes"+'"'+"}");
    
}

pw.flush();
//关闭
pw.close();
rc.close();
%>

</body>
</html>