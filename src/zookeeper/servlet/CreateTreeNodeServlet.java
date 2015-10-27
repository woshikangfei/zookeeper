package zookeeper.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.ZooKeeper;
import org.apache.zookeeper.ZooDefs.Ids;
import org.apache.zookeeper.data.Stat;

import zookeeper.utils.ZookeeperUtils;

public class CreateTreeNodeServlet extends HttpServlet{

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
			
			
			String parentPath = req.getParameter("parentPath");
			String nodename = req.getParameter("nodename");
			
			String createpath = parentPath+"/"+nodename;
			
			if(parentPath=="/"||parentPath.equals("/")){
				createpath ="/"+nodename;
			}
			
			 Stat stat = zk.exists(createpath, true);
			 if (stat != null) {
				JSONObject jo = new JSONObject();
				jo.put("message", "10002");
				resp.getWriter().println(jo);
				return;
			 }else{
				 zk.create(createpath, "".getBytes(), Ids.OPEN_ACL_UNSAFE,CreateMode.PERSISTENT);
			 }
			
			
			
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
