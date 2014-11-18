package main;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.io.File;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class Gui extends JFrame {
	private static final long serialVersionUID = -1243782978314441718L;
	
	private static MapPanel map;
	private static VideoPanel video;
	private static ControlPanel controls;
	
	public Gui() {
		this.setLayout(new GridBagLayout());
		this.setTitle("18-798 : VisionMap");
		try {
			this.setIconImage(ImageIO.read(new File("images/icon.png")));
		} catch (Exception e) {
			System.out.println("Unable to read icon image!");
		}
		
		// Read in json file of landmark types and positions
		ArrayList<Landmark> landmarks = readInLandmarks("");
		
		GridBagConstraints gbc = new GridBagConstraints();
		gbc.gridx = 0;
		gbc.gridy = 0;
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weightx = 0.33;
		gbc.weighty = 1;
		this.add(controls = new ControlPanel(), gbc);
		
		gbc.gridy = 1;
		gbc.weightx = 0.67;
		JPanel bottomPanel = new JPanel();
		bottomPanel.setLayout(new GridLayout(1,2));
		bottomPanel.add(map = new MapPanel(landmarks));
		bottomPanel.add(video = new VideoPanel(landmarks));
		this.add(bottomPanel, gbc);
		
		pack();
		this.setVisible(true);
	}
	
	public void setVideoFile(String filename) {
		video.setFile(filename);
	}
	
	public static void UpdatePosition(double latitude, double longitude) {
		map.updatePosition(latitude, longitude);
		controls.updatePosition(latitude, longitude);
	}
	
	private ArrayList<Landmark> readInLandmarks(String filename) {
		ArrayList<Landmark> landmarks = new ArrayList<Landmark>();
		
		// TODO implement reading landmarks from json file
		
		return landmarks;
	}
	
	/**
	 * Main method for instantiating simple Gui
	 * @param args
	 */
	public static void main(String args[]) {		
		new Gui();
	}
}
