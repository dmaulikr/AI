package engine;

import engine.api.GPSState;

public class GPSNode {

	private GPSState state;
	private GPSNode parent;
	private int cost;
	private int depth;

	public GPSNode(GPSState state, Integer cost, int depth) {
		super();
		this.state = state;
		this.cost = cost;
		this.depth = depth;
	}

	public GPSNode getParent() {
		return parent;
	}

	public void setParent(GPSNode parent) {
		this.parent = parent;
	}

	public GPSState getState() {
		return state;
	}

	public int getCost() {
		return cost;
	}
	
	public int getDepth() {
		return depth;
	}

	@Override
	public String toString() {
		return state.toString();
	}

	public String getSolution() {
		if (this.parent == null) {
			return this.state.toString();
		}
		return this.parent.getSolution() + "\n" + this.state;
	}
	
	
}
