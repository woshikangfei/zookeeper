package zookeeper.utils;

import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooKeeper;

public class ZookeeperUtils  implements Watcher {
	
	public static String auth_type = "digest";
	public static String auth_password = "password";

	private ZookeeperUtils(){
	}
	
	private static ZookeeperUtils instance = null;
	
	public static ZookeeperUtils Instance(){
		if(instance==null)
			instance = new ZookeeperUtils();
		
		return instance;
	}
	
	public void init(String url,int timeout)throws Exception{
		try {
			zk = new ZooKeeper(url,timeout,this);
			while(ZooKeeper.States.CONNECTED!=zk.getState()){
				 Thread.sleep(1000);
			 }
			//zk.addAuthInfo(auth_type, auth_password.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ZooKeeper zk;

	@Override
	public void process(WatchedEvent event) {
		// TODO Auto-generated method stub
		
	}

	public ZooKeeper getZk() {
		return zk;
	}

	public void setZk(ZooKeeper zk) {
		this.zk = zk;
	}
}
