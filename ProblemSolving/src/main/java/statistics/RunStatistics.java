package statistics;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.math.stat.descriptive.DescriptiveStatistics;

import domain.Board;
import domain.BoardSolver;
import domain.Heuristic;
import domain.Solver;
import engine.GPSEngine;
import engine.GPSEngineAStar;
import engine.GPSEngineBFS;
import engine.GPSEngineDFS;
import engine.GPSEngineGreedy;
import engine.GPSEngineID;
import engine.SearchStrategy;

public class RunStatistics {


//	private static final int ROUNDS = 5;
//
//	private static final int PLOT = 1;
	
	public static void main(String[] args) {
		
		List<Board> boards = getBoards("boards/hard");
		
		System.out.println("Cargando " + boards.size() + " boards");
		
		SearchStrategy ss = SearchStrategy.ASTAR;
		Heuristic h = null;
		List<Heuristic> hs = new ArrayList<Heuristic>();
//		hs.add(Heuristic.H0);
//		hs.add(Heuristic.H1);
//		hs.add(Heuristic.H2);
//		hs.add(Heuristic.H3);
		hs.add(Heuristic.H4);
		
		for(int j = 0; j < hs.size(); j++) {
			h = hs.get(j);
			System.out.println("Heuristica: " + h);
			DescriptiveStatistics totalTime = new DescriptiveStatistics();
			DescriptiveStatistics deepness = new DescriptiveStatistics();
			DescriptiveStatistics expanded = new DescriptiveStatistics();
			DescriptiveStatistics open = new DescriptiveStatistics();
			for(int i = 0; i < boards.size() ; i++){
//				System.out.println("Resolviendo board " + i + "...");
//				System.out.println(boards.get(i));
	//			if(i%PLOT == 0) {System.out.print("=");}
				
				GPSEngine engine = null;
				
				switch(ss) {
					case BFS:
						engine = new GPSEngineBFS();break;
					case DFS:
						engine = new GPSEngineDFS();break;
					case ID:
						engine = new GPSEngineID();break;
					case ASTAR:
						engine = new GPSEngineAStar();break;
					case GS:
						engine = new GPSEngineGreedy();break;
				}
				
				BoardSolver solver = new BoardSolver(boards.get(i), engine);
				if(ss == SearchStrategy.ASTAR || ss == SearchStrategy.GS) {
					solver.start(h);
				}else{
					solver.start();
				}
				
				totalTime.addValue(solver.getTotalTime());
				expanded.addValue(solver.getExpandedNodes());
				deepness.addValue(solver.getDeepness());
				open.addValue(solver.getOpenSize());
			}
			printStats(totalTime, "Tiempo transcurrido");
			printStats(expanded, "Nodos expandidos");
			printStats(open, "Nodos en frontera");
			printStats(deepness, "Profunidad explorada");
		}
//		System.out.println("|");
	}
	
	private static void printStats(DescriptiveStatistics stat, String title){
		System.out.println("\n "+ title +":");
		System.out.println("\t Media: " + stat.getMean());
		System.out.println("\t Std: " + stat.getStandardDeviation());
	}
	
	private static List<Board> getBoards(String directory) {
		List<Board> boards = new ArrayList<Board>();
		
		File dir = new File(directory);
		String[] files = dir.list();
		
		for(String file : files) {
			try {
				boards.add(Solver.parseReader(new BufferedReader(new FileReader(new File(directory + "/" + file)))));
			} catch (Exception e) {
				System.out.println("No se pudo cargar: " + file);
			}
		}
		
		return boards;
	}
	
}
