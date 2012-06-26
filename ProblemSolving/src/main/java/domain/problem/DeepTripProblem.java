package domain.problem;

import java.util.ArrayList;
import java.util.List;

import domain.Board;
import domain.Heuristic;
import engine.api.GPSProblem;
import engine.api.GPSRule;
import engine.api.GPSState;

public class DeepTripProblem implements GPSProblem {

	private GPSState init;
	private GPSState goal;
	private List<GPSRule> rules;
	private Heuristic heuristic;
	
	
	public DeepTripProblem(Board init, Heuristic h) {
		this.init = new DeepTripState(init);
		this.goal = new DeepTripState(Board.createEmptyBoard(init.getRows(), init.getCols(), init.getColors()));
		this.rules = new ArrayList<GPSRule>(init.getRows() * (init.getCols() - 1));
		this.heuristic = h;
		
		GPSRule r;
		for(int i = 0; i < init.getRows(); i++) {
			for(int j = 1; j < init.getCols(); j++) {
				r = new ShiftRowRightRule(i, j, h);
				rules.add(r);
			}
		}
	}
	
	public DeepTripProblem(Board init) {
		this(init, null);
	}

	public GPSState getInitState() {
		return init;
	}

	public GPSState getGoalState() {
		return goal;
	}

	public List<GPSRule> getRules() {
		return rules;
	}

	public Integer getHValue(GPSState parentState, GPSState state) {
		DeepTripState s = (DeepTripState)state;
		DeepTripState ps = (DeepTripState) parentState;
		Board board = s.getBoard();
		int ret = 0;
		if(heuristic != null) {
			switch(heuristic) {
			case H0:
				ret = (int) ((float) 1 / (1 + board.getBlankAmount()*s.getDepth())) * 100;break;
			case H1:
				ret = (int) (((float) board.getSize() - board.getBlankAmount()) / (2*(1+board.clusters2()))*100);break;
			case H2:
				ret = (int) (((float) board.getAmountOfColors() / s.getDepth())*100);break;
			case H3:
				int Q_e = ps.getBoard().getAmountOfColors() - board.getAmountOfColors();
				float min = ((float)board.getAmountofColor(1)) / ((s.getDepth() * Q_e) + 1);
				float aux;
				for(int i = 2; i < board.getColors(); i++) {
					aux = ((float)board.getAmountofColor(i)) / ((s.getDepth() * Q_e) + 1);
					if(aux < min) {
						min = aux;
					}
				}
				ret = (int) (min * 100);
				break;
			case H4:
				int h0 = (int) ((float) 1 / (1 + board.getBlankAmount()*s.getDepth())) * 100;
				int h2 = (int) (((float) board.getAmountOfColors() / s.getDepth())*100);
				ret = h0 + h2;
				break;
			}
		}
		return (int) ret;
	}

	@Override
	public boolean isInformed() {
		return heuristic != null;
	}

}
