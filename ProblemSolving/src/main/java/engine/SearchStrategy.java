package engine;


public enum SearchStrategy {
	BFS(false), DFS(false), ID(false), GS(true), ASTAR(true);
	
	private boolean h;
	
	private SearchStrategy(boolean heuristic) {
		this.h = heuristic;
	}
	
	public boolean needsHeuristic() {
		return h;
	}
}
