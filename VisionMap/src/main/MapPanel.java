package main;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.swing.BorderFactory;
import javax.swing.JPanel;

public class MapPanel extends JPanel {
	private static final long serialVersionUID = -2309869159533528698L;
	private BufferedImage map;
	private final int WIDTH = 640;
	private final int HEIGHT = 480;
	
	private Marker camera;
	private ArrayList<Marker> landmarks;
	
	public MapPanel(ArrayList<Landmark> landmarks) {
		this.setBorder(BorderFactory.createLineBorder(Color.black));
		this.setMinimumSize(new Dimension(WIDTH, HEIGHT));
		
		try {
			map = ImageIO.read(new File("images/course_map.png"));
		} catch (Exception e) {
			System.out.println("Unable to open map background!");
		}
		
		this.camera = new Marker();
		
		// Convert set of gps landmarks to pixel markers
		this.landmarks = new ArrayList<Marker>();
		if (!landmarks.isEmpty()) {
			for (Landmark tmp : landmarks) {
				this.landmarks.add(new Marker(tmp));
			}
		}
	}
	
	public void updatePosition(double latitude, double longitude) {
		// TODO convert gps coordinates to pixel values
		
		repaint();
	}
	
	/*				Methods for Map Display				*/
	@Override
	public void paintComponent(Graphics g) {
		g.drawImage(map, 0, 0, Color.black, null);
		
		// Draw camera marker
		g.setColor(Color.GREEN);
		g.drawLine(camera.x, camera.y, camera.x, camera.y);
		
		// Draw landmark markers
		if (!landmarks.isEmpty()) {
			for (Marker point : landmarks) {
				switch (point.type) {
				case Landmark.STOP_SIGN:
					g.setColor(Color.RED);
					break;
				default:
					
				}
				
				g.drawLine(point.x, point.y, point.x, point.y);
			}
		}
	}
}
