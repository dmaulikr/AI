package domain.problem;

import domain.Board;
import domain.Heuristic;
import engine.api.GPSRule;
import engine.api.GPSState;
import engine.exception.NotAppliableException;

public class ShiftRowRightRule implements GPSRule {

	private int row;
	private int times;
	
	public ShiftRowRightRule(int row, int times, Heuristic h) {
		this.row = row;
		this.times = times;
	}

	public String getName() {
		return "RR(" + row + "," + times + ")"; 
	}

	public GPSState evalRule(GPSState state) throws NotAppliableException {
		DeepTripState s = (DeepTripState) state;
		if(isEmptyRow(s) || !s.getBoard().isSolvable()) {
			throw new NotAppliableException();
		}
		Board b = s.getBoard().newInstance().shiftRowRight(row, times).clearColors();
		return new DeepTripState(b, this);
 	}
	
	private boolean isEmptyRow(DeepTripState s) {
		Board b = s.getBoard();
		for(int i = 0; i < b.getCols(); i++) {
			if(b.getData()[row][i] != 0) {
				return false;
			}
		}
		return true;
	}

	@Override
	public String toString() {
		return getName();
	}

	@Override
	public Integer getCost(GPSState newState) {
		return 100;
	}
	
}
