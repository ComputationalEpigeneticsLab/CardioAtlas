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
<title>Insert title here</title>
</head>
<body>
<%
String key="";
String searchType="";
String sql="";
String dasetid="";
String database_name="";
String out_filename="";
key=request.getParameter("key");
searchType=request.getParameter("searchType");


//key="Human";
//searchType="datasets";


List<String> list_title = new ArrayList<String>();
int colnum=0;

if(searchType.equals("ats")){
	database_name="fuzzy_matching_ats";
	out_filename="ats_search.txt";
	colnum=11;
	
	  list_title.add("describetion");
	  list_title.add("ats");
	  list_title.add("species");
	  list_title.add("technology");
	  list_title.add("tissue");
	  list_title.add("disease");
	  list_title.add("celltype");
	  list_title.add("marker");
	  list_title.add("genenum");
	  list_title.add("cellnum");
	  list_title.add("celltypenum");
	  
	
}else{
	database_name="fuzzy_matching_datasets";
	out_filename="datasets_search.txt";
	colnum=14;
	
      list_title.add("describetion");
	  list_title.add("ats");
	  list_title.add("species");
	  list_title.add("technology");
	  list_title.add("tissue");
	  list_title.add("disease");
	  list_title.add("celltype");
	  list_title.add("marker");
	  
	  list_title.add("paper_name");
	  list_title.add("journal");
	  list_title.add("journal_http");
	  list_title.add("genenum");
	  list_title.add("cellnum");
	  list_title.add("celltypenum");
}
sql="SELECT * FROM "+database_name+" WHERE describetion LIKE " + "'%"+key+"%'  ";
//System.out.println(sql);
String ids="";
//////////使用XMLHttpRequest 输出数据
response.setContentType("text/html;charset=utf-8");
PrintWriter pw = response.getWriter();
try {
	DBConn db = new DBConn();
	db.open();
	ResultSet rs_gene=db.executeQuery(sql);
		int count=colnum;
		rs_gene.last();
		int recordCount=rs_gene.getRow();
		rs_gene.first();
		if(searchType.equals("ats")){
			ids=ids+rs_gene.getString("ats")+";";
		}else{
			ids=ids+rs_gene.getString("datasets")+";";
		}
	while(rs_gene.next()){
			if(searchType.equals("ats")){
				ids=ids+rs_gene.getString("ats")+";";
			}else{
				ids=ids+rs_gene.getString("datasets")+";";
			}
		 }
	
	
	ids=ids.substring(0,ids.length()-1);///删除最后一个；
	
	//System.out.println(ids);
	pw.println("{"+'"'+"ids"+'"'+":"+'"'+ids+'"'+","+'"'+"error_attention"+'"'+":"+'"'+"no"+'"'+"}");



	rs_gene.close();
	db.close();
} catch (Exception e) {
    e.printStackTrace();
    pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"yes"+'"'+"}");
    
    System.out.println("no such key");
}
pw.flush();
pw.close();

%>
</body>
</html>