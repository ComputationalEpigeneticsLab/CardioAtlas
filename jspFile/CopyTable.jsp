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
<title>Run method here</title>
</head>
<body>
<%
String RdataPath="F:/hert-data/CardioWebOther";
//String RdataPath="/pub1/Download/xujuan_web/CardioWebOther";
String ats=request.getParameter("ats");
String reg=request.getParameter("reg");
String type=request.getParameter("type");
String celltype=request.getParameter("celltype");
String orgpath="";
if(ats.contains("atlas")){
	RdataPath=RdataPath+"/CardioAtlasWebFiles/webReg";
	orgpath=RdataPath+"/"+type+"/"+ats+"/table/"+celltype+"_"+reg+"_table.txt";
}else{
	String[] temp;
	temp = ats.split("@");
	RdataPath=RdataPath+"/CardioDatasetsWebFiles/webReg";
	orgpath=RdataPath+"/"+type+"/"+temp[0]+"/"+temp[1]+"/table/"+celltype+"_"+reg+"_table.txt";
}


orgpath=orgpath.replaceAll("\\\\","/");
String outpath=getServletContext().getRealPath("/copyFile")+"/table/"+celltype+"_"+reg+"_table.txt";
outpath=outpath.replaceAll("\\\\","/");

 //System.out.println(orgpath);
// System.out.println(outpath);
//////////使用XMLHttpRequest 输出数据
response.setContentType("text/html;charset=utf-8");
//获取PrintWriter
PrintWriter pw = response.getWriter();

File file_re = new File(outpath);  //判断文件是否存在存在的话就不用再copy一遍了
if (!file_re.exists()) {
	FileInputStream ins = null;
	FileOutputStream outs = null;
	File infile =new File(orgpath);
	File outfile =new File(outpath);
	ins = new FileInputStream(infile);
	outs = new FileOutputStream(outfile);
	byte[] buffer = new byte[1024];
	int length;
	while ((length = ins.read(buffer)) > 0) {
	   outs.write(buffer, 0, length);
	}          
	ins.close();
	outs.close();
	pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"no"+'"'+"}");
	//System.out.println("file copy completed.");
}else{
	pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"no"+'"'+"}");
	//System.out.println("file exists.");
}
//清空缓存
pw.flush();
//关闭
pw.close();


%>

</body>
</html>