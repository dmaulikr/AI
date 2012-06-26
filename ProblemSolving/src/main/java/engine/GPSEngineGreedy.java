package engine;

import java.util.Comparator;

public class GPSEngineGreedy extends GPSEngine {

	private Comparator<GPSNode> comparator = new GreedyNodeComparator();
	
	private class GreedyNodeComparator implements Comparator<GPSNode>{

		@Override
		public int compare(GPSNode node1, GPSNode node2) {
			if(node1.getDepth() == node2.getDepth()){
				int node1Hvale = GPSEngineGreedy.this.getProblem().getHValue(node1.getParent().getState(), node1.getState());
				int node2Hvale = GPSEngineGreedy.this.getProblem().getHValue(node2.getParent().getState(), node2.getState());
				return node1Hvale - node2Hvale;
			}else{
				return node2.getDepth() - node1.getDepth();
			}
		}
		
	}
	
	@Override
	public void addNode(GPSNode node) {
		if(open.isEmpty()){
			open.add(node);
			return;
		}
		for(int i = 0; i < open.size(); i++){
			if(comparator.compare(open.get(i), node) >=0){
				open.add(i, node);
				return;
			}
		}
		open.add(node);
	}
}
