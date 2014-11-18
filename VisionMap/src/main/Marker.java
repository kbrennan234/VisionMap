package main;

public class Marker {
	public int x;
	public int y;
	public int type;
	
	public Marker() {
		this.x = 0;
		this.y = 0;
		this.type = Landmark.CAMERA;
	}		
	
	public Marker(Landmark landmark) {
		// TODO gps to pixel
		this.x = 0;
		this.y = 0;
		this.type = landmark.type;
	}
}
