package main;

import java.awt.GridBagLayout;
import java.io.File;

import javax.imageio.ImageIO;
import javax.swing.JFrame;

public class Gui extends JFrame {
	private static final long serialVersionUID = -1243782978314441718L;

	public Gui() {
		this.setLayout(new GridBagLayout());
		this.setTitle("18-798 : VisionMap");
		try {
			this.setIconImage(ImageIO.read(new File("images/icon.png")));
		} catch (Exception e) {
			System.out.println("Unable to read icon image!");
		}
		
		pack();
		this.setVisible(true);
	}

	public static void main(String args[]) {
		new Gui();
	}
}
