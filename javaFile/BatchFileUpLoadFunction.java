package cn.CakeCN.util;

import cn.CakeCN.util.OperateUploadFileDTO;
import cn.CakeCN.util.OperateUploadFileUtil;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


/**
 * Servlet implementation class BatchFileUpLoadFunction
 */
public class BatchFileUpLoadFunction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BatchFileUpLoadFunction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//得到 表达谱所在的文件路径
		String filePathName=request.getParameter("UserRandompathname");
		String realPath = getServletContext().getRealPath("/upload/"+filePathName);
		realPath=realPath.replaceAll("\\\\","/")+"/";
		
		
		if (ServletFileUpload.isMultipartContent(request)){
			//调用OperateUploadFileDTO方法得到文件
            OperateUploadFileDTO dto = OperateUploadFileUtil.parseParam(request);

            String fileName = dto.getParamMap().get("fileName");//文件名
            //System.out.print(fileName);
            FileItem item = dto.getFileMap().get("file");//
            //System.out.print(item);

            try {
            	//将文件写出到生成的随机文件              
                item.write(new File(realPath+"/"+fileName));
                String re="";
                //生成json格式的文件名和地址 ：注意在js中获取时要注意key和value的对应
                re="{" +'"'+"filename"+'"'+":"+'"'+fileName+'"'+"}";
                response.setContentType("text/html;charset=utf-8");
              //获取PrintWriter
                PrintWriter pw = response.getWriter();
              //输出json数据回前端，前台使用js获取
                pw.println(re);
              //清空缓存
                pw.flush();
              //关闭
                pw.close();

            } catch (Exception e) {
                e.printStackTrace();
            }

        }
		
	}

}
