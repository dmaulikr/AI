package viewer;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.util.ArrayList;
import java.util.List;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JLayeredPane;
import javax.swing.JPanel;

import domain.Board;
import domain.Position;

public class GameViewer {

	Board model;
	
    private JFrame boardFrame;
    private JLayeredPane layeredPane;
    private JPanel chessBoard;
    
    private List<ImageIcon> icons;
    
    private int CELLSIZE = 50;
    
	public GameViewer(String windowTitle, Board model){
		this.model = model;
		
		boardFrame = new JFrame(windowTitle);
		
		icons = new ArrayList<ImageIcon>();
		for(int i = 0; i < model.getColors()+1; i++) {
			icons.add(new ImageIcon(ClassLoader.getSystemResource("resources/" + i + ".png")));
		}
		
		Dimension boardSize = new Dimension(CELLSIZE * model.getCols(), CELLSIZE * model.getRows());
		layeredPane = new JLayeredPane();
        layeredPane.setPreferredSize(boardSize);
        boardFrame.getContentPane().add(layeredPane, BorderLayout.CENTER);

        // Add a chess board to the Layered Pane 
        chessBoard = new JPanel();
        layeredPane.add(chessBoard, JLayeredPane.DEFAULT_LAYER);
        chessBoard.setLayout(new GridLayout(model.getRows(), model.getCols()) );
        chessBoard.setPreferredSize( boardSize );
        chessBoard.setBounds(0, 0, boardSize.width, boardSize.height);
        
        for (int i = 0; i < model.getCols() * model.getRows(); i++) {
            JPanel square = new JPanel( new BorderLayout() );
            chessBoard.add( square );
            square.setBackground(Color.DARK_GRAY);
        }

        refreshModel();
        boardFrame.pack();
        
        boardFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    	boardFrame.setVisible(true);
	}

	public void refreshModel(){
		JPanel panel;
		for(int i = 0; i < model.getRows(); i++){
			for(int j = 0; j < model.getCols(); j++){
				panel = (JPanel)chessBoard.getComponent(i*model.getCols() + j);
				if(panel.getComponents().length != 0){
					panel.remove(0);
				}
				int newColor = model.getColor(new Position(i, j));
				ImageIcon image = icons.get(newColor); 
				panel.add(new JLabel(image));
			}
		}
	}
	
	public void refresh(Board matrix){
		this.model = matrix;
		refreshModel();
		boardFrame.pack();
	}

	public void refresh(int i, int j){
		if( !isValidCoor(i,j,model.getRows())){
			return;
		}
		
//		switchComponent(i, j, greenLabel);
//        greenCross(i, j);
//        boardFrame.pack();
//        sleep(400);

//        refreshModel();
//        switchComponent(i, j, greenLabel);
//        goBack(i, j);
//        boardFrame.pack();
//        sleep(400);
        
//        greenCross(i, j);
//        boardFrame.pack();
//        sleep(400);
//        
//        hit(i,j);
//		refresh(model);
	}
	
//	private void hit(int i, int j){
//		for(int[] move: moves){
//        	int mi = i + move[0];
//        	int mj = j + move[1];
//        	if(isValidCoor(mi, mj, model.length)){
//        		model[mi][mj] = !model[mi][mj];;
//        	}
//        }
//		model[i][j] = !model[i][j]; 
//	}
	
	private boolean isValidCoor(int i, int j, int dim){
		return i >= 0 && i < dim && j >= 0 && j < dim;
	}
	
//	private void sleep(int milis){
//		try {
//			Thread.sleep(milis);
//		} catch (InterruptedException e) {
//			e.printStackTrace();
//		}
//	}
	
//	private void switchComponent(int i, int j, Component component){
//		JPanel panel = (JPanel)chessBoard.getComponent(i*model.length + j);
//		panel.remove(0);
//        panel.add(component);
//        return;
//	}
	
//	private void switchComponent(int i, int j,ImageIcon image){
//		switchComponent(i,j,new JLabel(greenLabel));
//	}
	
//	private void greenCross(int i, int j){
//		for(int[] move: moves){
//        	int mi = i + move[0];
//        	int mj = j + move[1];
//        	if(isValidCoor(mi, mj, model.length)){
//        		switchComponent(mi, mj, greenLabel);
//        	}
//        }
//		return;
//	}
	
	// TODO: Reusar código!
//	private void goBack(int i, int j){
//		JPanel panel;
//		for(int[] move: moves){
//        	int mi = i + move[0];
//        	int mj = j + move[1];
//        	if(isValidCoor(mi, mj, model.length)){
//        		panel = (JPanel)chessBoard.getComponent(mi*model.length + mj);
//				if(panel.getComponents().length != 0){
//					panel.remove(0);
//				}
//				ImageIcon image = (model[mi][mj] == WHITE) ? whiteLabel: blackLabel; 
//		        panel.add(new JLabel(image));
//        	}
//        }
//	}
}
