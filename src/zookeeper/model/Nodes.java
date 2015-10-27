package zookeeper.model;

import java.util.List;

public class Nodes {

	private String nodeName;
	private String path;
	
	private List<Nodes> child;

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public List<Nodes> getChild() {
		return child;
	}

	public void setChild(List<Nodes> child) {
		this.child = child;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
}
