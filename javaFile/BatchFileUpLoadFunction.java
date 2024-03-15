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
		//�õ� ��������ڵ��ļ�·��
		String filePathName=request.getParameter("UserRandompathname");
		String realPath = getServletContext().getRealPath("/upload/"+filePathName);
		realPath=realPath.replaceAll("\\\\","/")+"/";
		
		
		if (ServletFileUpload.isMultipartContent(request)){
			//����OperateUploadFileDTO�����õ��ļ�
            OperateUploadFileDTO dto = OperateUploadFileUtil.parseParam(request);

            String fileName = dto.getParamMap().get("fileName");//�ļ���
            //System.out.print(fileName);
            FileItem item = dto.getFileMap().get("file");//
            //System.out.print(item);

            try {
            	//���ļ�д�������ɵ�����ļ�              
                item.write(new File(realPath+"/"+fileName));
                String re="";
                //����json��ʽ���ļ����͵�ַ ��ע����js�л�ȡʱҪע��key��value�Ķ�Ӧ
                re="{" +'"'+"filename"+'"'+":"+'"'+fileName+'"'+"}";
                response.setContentType("text/html;charset=utf-8");
              //��ȡPrintWriter
                PrintWriter pw = response.getWriter();
              //���json���ݻ�ǰ�ˣ�ǰ̨ʹ��js��ȡ
                pw.println(re);
              //��ջ���
                pw.flush();
              //�ر�
                pw.close();

            } catch (Exception e) {
                e.printStackTrace();
            }

        }
		
	}

}
