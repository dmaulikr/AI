package viewer;

import java.util.Deque;
import java.util.LinkedList;
import java.util.List;

import domain.problem.DeepTripState;
import engine.api.GPSState;


public class SolutionViewer {

	public static void show(List<GPSState> states) {

		Deque<DeepTripState> boards = new LinkedList<DeepTripState>();
		for(GPSState state: states) {
			boards.push((DeepTripState)state);
		}
		GameViewer viewer = new GameViewer("test", boards.poll().getBoard());
		
		while(boards.peek() != null) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			viewer.refresh(boards.poll().getBoard());
		}
	}
}