package main;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.ArrayList;

import javax.swing.BorderFactory;
import javax.swing.JPanel;

public class VideoPanel extends JPanel {
	private static final long serialVersionUID = 4576183309956313830L;
	
	private BufferedImage frame;
	private final int WIDTH = 640;
	private final int HEIGHT = 480;
	
	private double latitude;
	private double longitude;
	
	private ArrayList<Landmark> landmarks;
	private ArrayList<Detection> detections;
	
	public VideoPanel(ArrayList<Landmark> landmarks) {
		this.setBorder(BorderFactory.createLineBorder(Color.black));
		this.setMinimumSize(new Dimension(WIDTH, HEIGHT));
		
		this.landmarks = landmarks;
		this.detections = new ArrayList<Detection>();
	}
	
	public void setFile(String filename) {
		// TODO load video file
	}
	
	/*					Methods for Localization					*/
	private void triangulate() {
		// TODO triangulate position based on detections;
		
		Gui.UpdatePosition(latitude, longitude);
	}
	
	
	/*			Methods for Displaying Video and Detections			*/
	@Override 
	public void paintComponent(Graphics g) {
		g.drawImage(frame, 0, 0, Color.black, null);
		
		drawDetections(g);
	}
	
	private void drawDetections(Graphics g) {
		if (!detections.isEmpty()) {
			g.setColor(Color.GREEN);
			for (Detection point : detections) {
				// TODO draw marker on frame to show detection
				// TODO draw bounding box for detections??
			}
		}
	}
	
	private class Detection {
		private Landmark gpsPos;
		private Marker framePos;
		private int width;
		private int length;
		
		public Detection() {
			// TODO implement frame detections
		}
	}
}
