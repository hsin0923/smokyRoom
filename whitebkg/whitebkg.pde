import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture cam;
PImage src, dst;
OpenCV opencv;

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
  //  opencv.startBackgroundSubtraction(0, 3, 0.5);

  cam.start();

  setupOSC();

  contours = opencv.findContours();
  // println("found " + contours.size() + " contours");
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    opencv.loadImage(cam);
    //opencv.flip(OpenCV.VERTICAL);
    opencv.blur(100);
    //opencv.updateBackground();
    opencv.gray();
    opencv.threshold(70);
    //opencv.dilate();
    //opencv.erode();
    dst = opencv.getOutput();
    contours = opencv.findContours();
    //println("found " + contours.size() + " contours");


   // scale(0.5);

    image(dst, 0, 0);

    noFill();
    strokeWeight(1);

    for (Contour contour : contours) {
      stroke(255, 255, 255);
      contour.draw();

      stroke(0, 0, 0);
       beginShape();
       for (PVector point : contour.getPolygonApproximation ().getPoints()) {
       sendStart_local((int)point.x, (int)point.y);
         vertex(point.x, point.y);
       
       }
       endShape();

     /* beginShape();
      for (PVector point : contour.getConvexHull ().getPoints()) {
        //sendStart_local((int)point.x, (int)point.y);
        point(point.x, point.y);
      }
      endShape();*/
    }
  }
}

