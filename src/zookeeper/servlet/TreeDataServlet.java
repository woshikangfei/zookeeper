package zookeeper.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.zookeeper.KeeperException.ConnectionLossException;
import org.apache.zookeeper.KeeperException.NoNodeException;
import org.apache.zookeeper.KeeperException.SessionExpiredException;
import org.apache.zookeeper.ZooKeeper;

import zookeeper.utils.ZookeeperUtils;

public class TreeDataServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}
	
	ZooKeeper zk;
	

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		
		try {
			
			zk=ZookeeperUtils.Instance().getZk();
			
			
			String path = req.getParameter("path");
			
			String result = "";
			
			byte[] temp =zk.getData(path, true, null);
			
			if(temp!=null)
				result = new String(temp,"utf-8");
			
			JSONObject jo = new JSONObject();
			jo.put("message", result);
			jo.put("path", path);
			System.out.println(jo.toString());
			resp.getWriter().println(jo);
		}catch(ConnectionLossException e){
			e.printStackTrace();
			
			JSONObject jo = new JSONObject();
			jo.put("message", "100003");
			resp.getWriter().println(jo);
		}catch(NullPointerException e){
			e.printStackTrace();
			
			JSONObject jo = new JSONObject();
			jo.put("message", "100004");
			resp.getWriter().println(jo);
		}catch(SessionExpiredException e){
			e.printStackTrace();
			
			JSONObject jo = new JSONObject();
			jo.put("message", "100005");
			resp.getWriter().println(jo);
		}catch(NoNodeException e){
			e.printStackTrace();
			
			JSONObject jo = new JSONObject();
			jo.put("message", "100006");
			resp.getWriter().println(jo);
		}catch (Exception e) {
			e.printStackTrace();
			
			JSONObject jo = new JSONObject();
			jo.put("message", "100002");
			resp.getWriter().println(jo);
		}
	}
	


	
}
