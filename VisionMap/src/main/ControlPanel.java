package main;

import java.awt.Color;

import javax.swing.BorderFactory;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class ControlPanel extends JPanel {
	private static final long serialVersionUID = -4471553980104053571L;
	private final int MAX_LENGTH = 10;
	
	private JLabel latitude;
	private JLabel longitude;
	
	public ControlPanel() {
		this.setBorder(BorderFactory.createLineBorder(Color.black));
		
		JLabel latLabel = new JLabel("  Latitude:   ");
		latitude = new JLabel();
		this.add(latLabel);
		this.add(latitude);
		
		JLabel lonLabel = new JLabel("  Longitude:   ");
		longitude = new JLabel();
		this.add(lonLabel);
		this.add(longitude);
	}
	
	public void updatePosition(double latitude, double longitude) {
		String tmp = Double.toString(latitude);
		if (tmp.length() > 10) tmp = tmp.substring(0, MAX_LENGTH);
		this.latitude.setText(tmp);
		
		tmp = Double.toString(longitude);
		if (tmp.length() > 10) tmp = tmp.substring(0, MAX_LENGTH);
		this.longitude.setText(tmp);
	}
}
