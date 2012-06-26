package engine;

public class GPSEngineDFS extends GPSEngine {

	@Override
	public void addNode(GPSNode node) {
		open.add(0, node);
	}
	
}
