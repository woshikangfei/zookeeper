package zookeeper.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import zookeeper.utils.ZookeeperUtils;

public class LoginServlet extends HttpServlet {


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String connect = req.getParameter("connect");
		String timeout = req.getParameter("timeout");
		if(timeout==null||timeout.length()==0)
			timeout="5000";
		
		try {
			if(username==null||username.length()==0||connect==null||connect.length()==0){
				//Ìø×ªµ½µÇÂ¼Ò³Ãæ
				resp.sendRedirect("login.jsp");
			}else{
				if((username.equals("kangfei")||username=="kangfei")&&(password.equals("kangfei")||password=="kangfei")){
					
					System.out.println("login");
					
					ZookeeperUtils.Instance().init(connect, Integer.parseInt(timeout));
					
					req.getSession().setAttribute("user", "vuclip");
					resp.sendRedirect(req.getContextPath()+"/demo/index.jsp");
				}else{
					resp.sendRedirect("login.jsp?type=1");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("login.jsp?type=2");
		}
		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}

}
