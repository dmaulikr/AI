package domain.problem;

import domain.Board;
import engine.GPSNode;
import engine.api.GPSRule;
import engine.api.GPSState;

public class DeepTripState implements GPSState {

	private Board board;
	private GPSRule rule;
	private GPSNode node;
	
	public DeepTripState(Board board) {
		this.board = board;
	}
	
	public DeepTripState(Board board, GPSRule rule) {
		this(board);
		this.rule = rule;
	}
	
	public boolean compare(GPSState state) {
		return board.equals(((DeepTripState) state).board);
	}

	public Board getBoard() {
		return board;
	}
	
	public GPSRule getRule() {
		return rule;
	}
	
	public int getDepth() {
		if(node == null){
			return 0;
		}
		return node.getDepth();
	}

	public void setNode(GPSNode node)  {
		this.node = node;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((board == null) ? 0 : board.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DeepTripState other = (DeepTripState) obj;
		if (board == null) {
			if (other.board != null)
				return false;
		} else if (!board.equals(other.board))
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		if(rule != null) {
			sb.append(rule.getName()).append("\n");
		}
		sb.append(board.toString());
		return sb.toString();
	}

}
