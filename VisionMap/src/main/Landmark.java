package main;

public class Landmark {
	public static final int CAMERA = 0;
	public static final int STOP_SIGN = 1;
	
	public int x;
	public int y;
	public int type;
	
	public Landmark(int x, int y) {
		this.x = x;
		this.y = y;
		this.type = Landmark.CAMERA;
	}
	
	public Landmark(int x, int y, int type) {
		this.x = x;
		this.y = y;
		this.type = type;
	}
}
