package engine;


public class GPSEngineBFS extends GPSEngine {

	@Override
	public void addNode(GPSNode node) {
		open.add(node);
	}

}
