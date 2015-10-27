package zookeeper.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooKeeper;

import zookeeper.model.Nodes;
import zookeeper.utils.ZookeeperUtils;

public class TreeServlet extends HttpServlet implements Watcher {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}
	
	ZooKeeper zk;
	String root = "/";

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		
		zk=ZookeeperUtils.Instance().getZk();
		
		
		List<String> s =null;
		try {
			s = zk.getChildren(root, true);
		} catch (KeeperException | InterruptedException e) {
			e.printStackTrace();
		}
		
		List<Nodes> nodesstr = new ArrayList<Nodes>();
		
		
		List<Nodes> nodechlid = new ArrayList<Nodes>();
		Nodes parent = new Nodes();
		
		for (String string : s) {
			
			Nodes no  = new Nodes();
			no.setNodeName(string);
			no.setPath(root+string);
			List<Nodes> child = educt(root+string);
			no.setChild(child);
			
			nodechlid.add(no);
		}
		
		parent.setChild(nodechlid);
		parent.setNodeName("/");
		parent.setPath("/");
		nodesstr.add(parent);
		
		JSONArray ja =JSONArray.fromObject(nodesstr);
	
		System.out.println(ja);
		
		resp.getWriter().println(ja);
	}
	
	public List<Nodes> educt(String path ){
		
		
		List<String> s =null;
		try {
			s = zk.getChildren(path, true);
		} catch (KeeperException | InterruptedException e) {
			e.printStackTrace();
		}
		if(s!=null&&s.size()>0){
			List<Nodes> nodesstr = new ArrayList<Nodes>();
		
			for (String string : s) {
				Nodes no  = new Nodes();
				no.setNodeName(string);
				no.setPath(path+"/"+string);
				List<Nodes> child = educt(path+"/"+string);
				no.setChild(child);
				nodesstr.add(no);
			}
			
			return nodesstr;
		}
		
		return null;
		
	}

	@Override
	public void process(WatchedEvent event) {
		// TODO Auto-generated method stub
		
	}

	
}
