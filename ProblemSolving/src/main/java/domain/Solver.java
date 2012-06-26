package domain;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import viewer.SolutionViewer;
import domain.problem.DeepTripProblem;
import engine.GPSEngine;
import engine.GPSEngineAStar;
import engine.GPSEngineBFS;
import engine.GPSEngineDFS;
import engine.GPSEngineGreedy;
import engine.GPSEngineID;
import engine.SearchStrategy;
import engine.api.GPSProblem;

public class Solver {

	//Para utilizar en la presentación
	private static boolean show = false;
	
	public static void main(String[] args) {

		try {
			SearchStrategy ss = null;
			Heuristic h = null;
			ss = SearchStrategy.valueOf(args[0].toUpperCase());
			
			if(ss.needsHeuristic()) {
				h = Heuristic.valueOf(args[2]);
			}else{
				if(args.length > 2) {
					throw new IllegalArgumentException();
				}
			}
			
			GPSEngine engine = null;
			
			switch(ss) {
			case BFS:
				engine = new GPSEngineBFS();break;
			case DFS:
				engine = new GPSEngineDFS();break;
			case ID:
				engine = new GPSEngineID();break;
			case GS:
				engine = new GPSEngineGreedy();break;
			case ASTAR:
				engine = new GPSEngineAStar();break;
			}
			
			try {
				Board b = parseReader(new BufferedReader(new FileReader(new File("boards/" + args[1]))));
                b.randomFill();
				new Solver().start(b, engine, h);
				if(show) {
                    SolutionViewer.show(engine.getSolutionStates());
				}
			}catch(Exception e) {
				System.out.println("Archivo inválido");
			}
		}catch(Exception e) {
			
			System.out.println("Invalid arguments");
			System.out.println("Usage for not informed algorithms: ./run.sh program.jar {BFS|DFS|ID} boardFile");
			System.out.println("Usage for informed algorithms: ./run.sh program.jar {GS,AStar} boardFile {H0,H1,H2,H3,H4}");
			System.out.println("The boardFile must to be in the examples folder");
			System.exit(1);
		}
		
		
	}
	
	private void start(Board initialBoard, GPSEngine engine, Heuristic h) {
		initialBoard.clearColors();
		System.out.println(initialBoard);
		System.out.println("Buscando solución...\n");
		GPSProblem p;
		if(h == null) {
			p = new DeepTripProblem(initialBoard);
		}else{
			p = new DeepTripProblem(initialBoard, h);
		}
		runEngine(engine, p);
	}
	
	private void runEngine(GPSEngine engine, GPSProblem p) {
		long b = System.currentTimeMillis();
		engine.engine(p, true);
		System.out.println("Solved in " + (System.currentTimeMillis() - b) + " ms");
	}
	
	public static Board parseReader(BufferedReader bis) throws IOException {

		Set<Integer> colors = new HashSet<Integer>();
		
		List<int[]> rows = new LinkedList<int[]>();
		int[] row; int cols = -1; int i; String line;
		
		while((line = bis.readLine()) != null) {
			String[] ns = line.split(",");
			if(cols < 0) {
				cols = ns.length;
			}
			row = new int[ns.length];
			i = 0;
			for(String s : ns) {
				row[i] = Integer.valueOf(s);
				colors.add(row[i]);
				i++;
			}
			rows.add(row);
		}
		
		int[][] board = new int[rows.size()][cols];
		i = 0;
		for(int[] cr : rows) {
			for(int j = 0; j < cr.length; j++) {
				board[i][j] = cr[j];
			}
			i++;
		}
		
		return new Board(colors.size(), board);
		
	}
	
}
