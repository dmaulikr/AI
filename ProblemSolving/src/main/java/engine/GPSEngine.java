package engine;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import engine.api.GPSProblem;
import engine.api.GPSRule;
import engine.api.GPSState;
import engine.exception.NotAppliableException;

public abstract class GPSEngine {

	protected List<GPSNode> open = new LinkedList<GPSNode>();

	protected List<GPSNode> closed = new LinkedList<GPSNode>();

	private GPSProblem problem;
	
	protected Set<GPSState> states = new HashSet<GPSState>();
	private GPSNode finalNode = null;
	
	private long explodedNodes = 0;
	private int deepness = 0;
	
	public void engine(GPSProblem myProblem, boolean printSolution) {

		this.problem = myProblem;

		GPSNode rootNode = new GPSNode(problem.getInitState(), 0, 0);
		boolean finished = false;
		boolean failed = false;
		long explosionCounter = 0;

		open.add(rootNode);
		while (!failed && !finished) {
			if (open.size() <= 0) {
				failed = true;
			} else {
				GPSNode currentNode = open.get(0);
				closed.add(currentNode);
				open.remove(0);
				if (isGoal(currentNode)) {
					finished = true;
					finalNode = currentNode;
					if(printSolution) {
						System.out.println(currentNode.getSolution());
						System.out.println("Expanded nodes: " + explosionCounter);
						System.out.println("Deepness: " + currentNode.getDepth());
					}
					explodedNodes = explosionCounter;
					deepness = currentNode.getDepth();
				} else {
					explosionCounter++;
					explode(currentNode);
				}
			}
		}

		if (finished) {
			System.out.println("OK! solution found!");
		} else if (failed) {
			System.err.println("FAILED! solution not found!");
		}
	}

	private  boolean isGoal(GPSNode currentNode) {
		return currentNode.getState() != null
				&& currentNode.getState().compare(problem.getGoalState());
	}

	private  boolean explode(GPSNode node) {
		if(problem.getRules() == null){
			System.err.println("No rules!");
			return false;
		}
		states.add(node.getState());
		for (GPSRule rule : problem.getRules()) {
			GPSState newState = null;
			try {
				newState = rule.evalRule(node.getState());
			} catch (NotAppliableException e) {
				continue;
			}
			if (newState != null && !checkBranch(node, newState) && !states.contains(newState) && !checkOpenAndClosed(node.getCost() + rule.getCost(newState), newState)) {
				GPSNode newNode = new GPSNode(newState, node.getCost() + rule.getCost(newState), node.getDepth() + 1);
				newNode.setParent(node);
				newState.setNode(newNode);
				addNode(newNode);
			}
		}
		return true;
	}
	
	private  boolean checkOpenAndClosed(Integer cost, GPSState state) {
		if(!problem.isInformed()) {
			return false;
		}
		for (GPSNode openNode : open) {
			if (openNode.getState().compare(state) && openNode.getCost() < cost) {
				return true;
			}
		}
		for (GPSNode closedNode : closed) {
			if (closedNode.getState().compare(state)
					&& closedNode.getCost() < cost) {
				return true;
			}
		}
		return false;
	}

	private  boolean checkBranch(GPSNode parent, GPSState state) {
		if (parent == null) {
			return false;
		}
		return checkBranch(parent.getParent(), state) || state.compare(parent.getState());
	}

	public GPSProblem getProblem() {
		return problem;
	}
	
	public long getExplodedNodes() {
		return explodedNodes;
	}
	
	public int getDeepness() {
		return deepness;
	}
	
	public int getOpenSize() {
		return open.size();
	}
	
	public List<GPSState> getSolutionStates() {
		List<GPSState> states = new ArrayList<GPSState>();
		GPSNode currentNode = finalNode;
		
		while(currentNode.getDepth() != 0) {
			states.add(currentNode.getState());
			currentNode = currentNode.getParent();
		}
		
		states.add(currentNode.getState());
		return states;
	}
	
	public abstract  void addNode(GPSNode node);
	
}
