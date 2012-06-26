package domain;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Deque;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

public class Board {

	private int[][] board;
	int qtyColors[];
	int colors;
	
	public static Board createEmptyBoard(int rows, int cols, int colors) {
		return new Board(rows, cols, colors);
	}
	
	public Board(int colors, int[][] board) {
		this.board = board;
		this.colors = colors;
		this.qtyColors = new int[colors];
		calculateQtyColors();
	}
	
	private Board(int rows, int cols, int colors) {
		this.board = new int[rows][cols];
		this.colors = colors;
		this.qtyColors = new int[colors];
		
	}
	
	private Board(int rows, int cols, int colors, int[] qtyColors) {
		this.board = new int[rows][cols];
		this.colors = colors;
		this.qtyColors = Arrays.copyOf(qtyColors, qtyColors.length);
	}
	
	/**
	 * Se rellena el tablero de forma aleatoria.
	 * Se considera 0 a la celda sin color.
	 */
	public Board randomFill() {
		Random r = new Random(System.currentTimeMillis());
		for(int i = 0; i < board.length; i++) {
			for(int j = 0; j < board[0].length; j++) {
				if(board[i][j] == 0) {
					board[i][j] = r.nextInt(colors) + 1;
				}
			}
		}
		
		clearColors();
		
		for(int i = 0; i < getCols(); i++) {
			if(board[getRows()-1][i] == 0) {
				return randomFill();
			}
		}
		
		calculateQtyColors();
		
		return this;
	}
	
	/**
	 * Se vacía el tablero
	 */
	public Board makeEmpty() {
		for(int i = 0; i < board.length; i++) {
			for(int j = 0; j < board[0].length; j++) {
				board[i][j] = 0;
			}
		}
		return this;
	}
	
	public Board shiftRowRight(int row, int times) {
		int aux[] = new int[getCols()];int i;
		
		for(i = 0; i < getCols(); i++) {
			aux[(i + times) % getCols()] = board[row][i];
		}
		
		for(i = 0; i < getCols(); i++) {
			board[row][i] = aux[i];
		}
		
		return this;
	}

	public int[][] getData() {
		return board;
	}
	
	public Board newInstance() {
		Board ret = new Board(getRows(), getCols(), getColors(), qtyColors);
		for(int i = 0; i < getRows(); i++) {
			ret.board[i] = Arrays.copyOf(board[i], getCols());
		}
		return ret;
	}
	
	/**
	 * Remueve los colores y aplica gravedad
	 */
	public Board clearColors() {
		applyGravity();
		while(_clearColors()) {
			applyGravity();
		}
		return this;
	}
	
	private boolean _clearColors() {
		Deque<Position> q = new LinkedList<Position>();
		List<Position> checked = new LinkedList<Position>();
		boolean ret = false;
		for(int i = 0; i < getRows(); i++) {
			for(int j = 0; j < getCols(); j++) {
				if(board[i][j] > 0 && !checked(checked, i, j)) {
					q.add(new Position(i, j));
					clearColors(q, Dir.UP);
					if(q.size() > 2) {
						removeColors(q);
						ret = true;
					}else{
						checked.addAll(q);
					}
					q.clear();
				}
			}
		}
		return ret;
	}
	
	private boolean checked(List<Position> checked, int x, int y) {
		for(Position p : checked) {
			if(p.equals(x, y)) {
				return true;
			}
		}
		return false;
	}
	
	private static enum Dir {
		UP, LEFT, RIGHT;
	}
	
	/**
	 * @param removeList colores que recolecto
	 * @param d Dirección de la que venía
	 */
	private void clearColors(Deque<Position> removeList, Dir d) {
		Position cp = removeList.peek();
		int cc = getColor(cp);
		if(cp.x >= 0 && cp.y >= 0 && cp.x < getRows() && cp.y < getCols()) {
			if(cp.x + 1 < getRows() && (board[cp.x + 1][cp.y] == cc)) {
				removeList.push(new Position(cp.x + 1, cp.y));
				clearColors(removeList, Dir.UP);
			}
			if(d != Dir.RIGHT && cp.y - 1 >= 0 && (board[cp.x][cp.y - 1] == cc)) {
				removeList.push(new Position(cp.x, cp.y -1));
				clearColors(removeList, Dir.LEFT);
			}
			if(d != Dir.LEFT && cp.y + 1 < getCols() && (board[cp.x][cp.y + 1] == cc)) {
				removeList.push(new Position(cp.x, cp.y + 1));
				clearColors(removeList, Dir.RIGHT);
			}
		}
	}
	
	private void removeColors(Collection<Position> positions) {
		for(Position p : positions) {
			if(board[p.x][p.y] > 0) {
				qtyColors[board[p.x][p.y] - 1]--;
				board[p.x][p.y] = 0;
			}
		}
	}
	
	public int getColor(Position p) {
		return board[p.x][p.y];
	}

	private void applyGravity() {
		for(int j = 0; j < getCols(); j++) {
			int k = 0;
			for(int i = 0; i < getRows(); i++) {
				if(board[i][j] != 0) {
					board[k++][j] = board[i][j];
				}
			}
			for(;k < getRows(); k++) {
				board[k][j] = 0;
			}
		}
	}
	
	/**
	 * @return La cantidad de colores
	 */
	public int getColors() {
		return colors;
	}
	
	@Override
	public int hashCode() {
		return Arrays.deepHashCode(board);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Board other = (Board) obj;
		return Arrays.deepEquals(board, other.board);
	}

	
	
	@Override
	public String toString() {
		StringBuilder s = new StringBuilder();
		s.append("Tablero:\n");
		for(int i = 0; i < board.length; i++) {
			for(int j = 0; j < board[0].length; j++) {
				s.append(" " + board[i][j] + " ");
			}
			s.append("\n");
		}
		s.append("\n");
		return s.toString();
	}
	
	public int getRows() {
		return this.board.length;
	}
	
	public int getCols() {
		return this.board[0].length;
	}
	
	public boolean isSolvable() {
		for(int i = 0; i < getColors(); i++) {
			if(qtyColors[i] > 0 && qtyColors[i] < 3) {
				return false;
			}
		}
		return true;
	}
	
	private void calculateQtyColors() {
		int i;
		for(i = 0; i < getColors(); i++) {
			qtyColors[i] = 0;
		}
		
		for(i = 0; i < getRows(); i++) {
			for(int j = 0; j < getCols(); j++) {
				if(board[i][j] > 0) {
					qtyColors[board[i][j] - 1]++;
				}
			}
		}
		
	}
	
	public int getAmountOfColors() {
		int ret = 0;
		for(int i = 0; i < qtyColors.length; i++) {
			if(qtyColors[i] > 0) {
				ret++;
			}
		}
		return ret;
	}
	
	public int getAmountofColor(int color) {
		if(color >= colors || color < 0) {
			throw new IllegalArgumentException("Invalid colors");
		}
		return qtyColors[color - 1];
	}
	
	public int[] getColorQty() {
		return qtyColors;
	}
 	
	public int getBlankAmount() {
		int num = 0;
		for(int i = 0; i < board.length; i++) {
			for(int j = 0; j < board[0].length; j++) {
				if(board[i][j] == 0) {
					num++;
				}
			}
		}
		
		return num;
	}
	
	public int getSize(){
		return getCols() * getRows();
	}

	/**
	 * Calculates the amount of clusters with size >= 2
	 * @return Amount of clusters
	 */
	public int clusters() {
		int clusters = 0;
		List<Position> checked = new ArrayList<Position>(getRows()*getCols());
		List<Position> cluster = new LinkedList<Position>();
		for(int i = 0; i < getRows(); i++) {
			for(int j = 0; j < getCols(); j++) {
				if(!checked(checked, i, j)) {
					cluster(new Position(i,j), cluster, Dir.UP);
					if(cluster.size() > 1) {
						clusters++;
						checked.addAll(cluster);
						cluster.clear();
					}
					cluster.clear();
				}
			}
		}
		return clusters;
	}
	
	private void cluster(Position p, List<Position> cluster, Dir dir) {
		cluster.add(p);
		if(p.x + 1 < getRows() && board[p.x][p.y] == board[p.x + 1][p.y]) {
			cluster(new Position(p.x + 1, p.y), cluster, Dir.UP); 
		}
		if(p.y + 1 < getCols() && dir != Dir.LEFT && board[p.x][p.y] == board[p.x][p.y + 1]) {
			cluster(new Position(p.x, p.y + 1), cluster, Dir.RIGHT);
		}
		if(p.y - 1 >= 0 && dir != Dir.RIGHT && board[p.x][p.y] == board[p.x][p.y - 1]) {
			cluster(new Position(p.x, p.y - 1), cluster, Dir.LEFT);
		}
	}
	
	/**
	 * Calculates clusters with size = 2
	 * @return
	 */
	public int clusters2() {
		int c = 0;
		for(int i = 0; i < getRows() - 1; i++) {
			for(int j = 0; j < getCols() - 1; j++) {
				if(board[i][j] == board[i][j+1] || board[i][j] == board[i+1][j]) {
					c++;
				}
			}
		}
		return c;
	}
	
}
