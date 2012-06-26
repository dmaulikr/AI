package viewer;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;

import domain.Board;
import domain.Solver;


public class ViewerTest {

	public static void main(String[] args) {
		Board b = null;
		try {
			b = Solver.parseReader(new BufferedReader(new FileReader(new File("boards/misc/notsol.txt"))));
//			InputStream is = ClassLoader.getSystemResourceAsStream("examples/" + args[1]);
		}catch(Exception e) {
			System.out.println("Archivo inválido");
			e.printStackTrace();
		}
		
		
//		b.randomFill();
		GameViewer viewer = new GameViewer("test", b);
		
		String line;
		List<String> arg = null;
		BufferedReader input = new BufferedReader(new InputStreamReader(System.in));
		
		while(true) {
			try {
				line = input.readLine();
				arg = Arrays.asList(line.split(" "));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(arg.size() == 2) {
				int row = Integer.valueOf(arg.get(0));
				int times = Integer.valueOf(arg.get(1));
				
				b.shiftRowRight(row, times);
				viewer.refresh(b);
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				b.clearColors();
				viewer.refresh(b);
			}

		}
	}
}