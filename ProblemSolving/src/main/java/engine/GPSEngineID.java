package engine;


public class GPSEngineID extends GPSEngine {

	private int depth = 0;
	
	@Override
	public void addNode(GPSNode node) {
		if(depth < node.getDepth()) {
			reset();
			open.add(new GPSNode(getProblem().getInitState(), 0, 0));
			depth++;
		}else{
			open.add(0, node);
		}
	}
	
	private void reset() {
		open.clear();
		closed.clear();
	}

}
