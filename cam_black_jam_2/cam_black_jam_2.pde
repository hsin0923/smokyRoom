import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture cam;
OpenCV opencv;

PImage src, dst;
ArrayList<Contour> contours;
ArrayList<Contour> polygons;
boolean sketchFullScreen() {
  return true;
}
void setup() {
  size(640, 480);
  frameRate(30);
  String[] cameras = Capture.list();
  for (int i = 0; i < cameras.length; i++) {
    println(cameras[i]);
  }
  cam = new Capture(this, cameras[0]);
  opencv = new OpenCV(this, 640, 480);
  opencv.startBackgroundSubtraction(0, 3, 0.5);

  cam.start();

  setupOSC();
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    opencv.loadImage(cam);
    opencv.flip(OpenCV.VERTICAL);
    opencv.blur(100);
    opencv.updateBackground();
    //opencv.dilate();
    //opencv.erode();
    dst = opencv.getOutput();
    contours = opencv.findContours();
    //println("found " + contours.size() + " contours");

    image(dst, 0, 0);

    noFill();
    strokeWeight(3);

    for (Contour contour : contours) {
      stroke(0, 0, 255);
      contour.draw();

      stroke(255, 0, 0);
      beginShape();
      for (PVector point : contour.getConvexHull ().getPoints()) {
        sendStart_local((int)point.x, (int)point.y);
        point(point.x, point.y);
      }
      endShape();
    }
  }
}

void mousePressed()
{
  sendStart_local(mouseX, mouseY);
}

void keyPressed()
{
  oscKeyPressed(key);
}

