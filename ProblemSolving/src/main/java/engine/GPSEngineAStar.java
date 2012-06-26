package engine;

import java.util.Comparator;

public class GPSEngineAStar extends GPSEngine {

	private Comparator<GPSNode> comparator = new Comparator<GPSNode>() {

		@Override
		public int compare(GPSNode node1, GPSNode node2) {
			int node1Hvale = getProblem().getHValue(node1.getParent().getState(), node1.getState());
			int node2Hvale = getProblem().getHValue(node2.getParent().getState(), node2.getState());
			return node1Hvale - node2Hvale;
		}
		
	};
	
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
