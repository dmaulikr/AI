package domain;

import domain.problem.DeepTripProblem;
import engine.GPSEngine;
import engine.api.GPSProblem;

public class BoardSolver {

	private Board board;
	private GPSEngine engine;
	
	private long totalTime;
	
	public BoardSolver(Board board, GPSEngine engine) {
		this.board = board;
		this.engine = engine;
	}
	
	public void start() {
		GPSProblem p = new DeepTripProblem(board);
		runEngine(engine, p);
	}
	
	public void start(Heuristic h) {
		GPSProblem p = new DeepTripProblem(board, h);
		runEngine(engine, p);
	}
	
	private void runEngine(GPSEngine engine, GPSProblem p) {
		long b = System.currentTimeMillis();
		engine.engine(p, true);
		totalTime = System.currentTimeMillis() - b;
	}
	
	public long getTotalTime() {
		return totalTime;
	}
	
	public long getExpandedNodes() {
		return engine.getExplodedNodes();
	}
	
	public int getDeepness() {
		return engine.getDeepness();
	}
	
	public int getOpenSize() {
		return engine.getOpenSize();
	}
	
}
