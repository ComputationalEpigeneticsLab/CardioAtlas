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
	<%@ page import="java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CardioAtlas Run method here</title>
</head>
<body>
<%
String RdataPath="F:/hert-data/CardioWebOther/CardioAtlasDownload";
//String RdataPath="/pub1/Download/xujuan_web/CardioAtlasDownload";
//String path=request.getParameter("path");
String name=request.getParameter("name");
//String loc=request.getParameter("loc");

String orgpath=RdataPath+"/"+name+".rds";
orgpath=orgpath.replaceAll("\\\\","/");
String outpath=getServletContext().getRealPath("/download/")+name+".rds";
outpath=outpath.replaceAll("\\\\","/");
//System.out.println(orgpath);
//System.out.println(outpath);

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


//System.out.println("file copy completed.");

String filePath = "/download"+name+".rds";
String fileName = name;  
response.setContentType("application/x-download");//设置为下载application/x-download
String filenamedownload = filePath;//即将下载的文件的相对路径
String filenamedisplay = fileName;//下载文件时显示的文件保存名称
filenamedisplay = URLEncoder.encode(filenamedisplay,"UTF-8");
response.addHeader("Content-Disposition","attachment;filename=" + filenamedisplay);    
try
{
    RequestDispatcher dispatcher = application.getRequestDispatcher(filenamedownload);
    if(dispatcher != null)
    {
        dispatcher.forward(request,response);
    }
    response.flushBuffer();
}
catch(Exception e)
{
    e.printStackTrace();
}  
out.clear();
out = pageContext.pushBody();
//System.out.println("file download completed.");
%>

</body>
</html>