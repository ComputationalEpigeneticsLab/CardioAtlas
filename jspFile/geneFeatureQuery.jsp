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

String ats=request.getParameter("ats");
String marker=request.getParameter("marker");
String database_name_feature=ats.toLowerCase()+"_genefeature";

String sql_feature="";
sql_feature="SELECT * FROM "+database_name_feature+" where gene = '"+marker+"'";

System.out.println(sql_feature);

DBConn db1 = new DBConn();
db1.open();
//feature////
	ResultSet rs=db1.executeQuery(sql_feature);
	rs.first();
	String tsne=rs.getString("tsne");
	String umap=rs.getString("umap");
	String max=rs.getString("max");
	rs.close();
	
//close
db1.close();

//////////使用XMLHttpRequest 输出数据
response.setContentType("text/html;charset=utf-8");
//获取PrintWriter.asString()
PrintWriter pw = response.getWriter();
String error_attention="no";
String re="{" +'"'+"error_attention"+'"'+":"+'"'+error_attention+'"'+","+'"'+"tsne"+'"'+":"+'"'+tsne+'"'+","+'"'+"umap"+'"'+":"+'"'+umap+'"'+","+'"'+"max"+'"'+":"+'"'+max+'"'+"}";

pw.println(re);

//清空缓存
pw.flush();
//关闭
pw.close();


%>

</body>
</html>