package zookeeper.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.zookeeper.ZooKeeper;
import org.apache.zookeeper.data.Stat;

import zookeeper.utils.ZookeeperUtils;

public class SaveTreeDataServlet extends HttpServlet{

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
		
		try {
			
			zk=ZookeeperUtils.Instance().getZk();
			
			
			String path = req.getParameter("path");
			String data = req.getParameter("data");
			zk.setData(path, data.getBytes(), -1);
			JSONObject jo = new JSONObject();
			jo.put("message", "10001");
			System.out.println(jo.toString());
			resp.getWriter().println(jo);
		} catch (Exception e) {
			e.printStackTrace();
			JSONObject jo = new JSONObject();
			jo.put("message", "10002");
			resp.getWriter().println(jo);
		}
	}
	


	
}
