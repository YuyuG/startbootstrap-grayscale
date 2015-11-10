Draggable draggable;
NullDraggableObject nullDraggableObject;
ArrayList draggables;
PImage marker1;
PImage marker2;

void setup() {
 size(1366, 768);
 smooth();
 nullDraggableObject = new NullDraggableObject();
 draggables = new ArrayList();
 marker1 = loadImage("http://i1093.photobucket.com/albums/i426/gyillowyy/Marker01.png");
 marker2= loadImage("http://i1093.photobucket.com/albums/i426/gyillowyy/Marker02.png");
  draggables.add(new DraggableImage(random(width), random(height/2), marker1));
  draggables.add(new DraggableImage(random(width), random(height/2), marker2));
}

void draw() {
 background(255);
 noFill();
 stroke(255);
 strokeWeight(3);
 draggable = nullDraggableObject;
 for(int i = 0; i < draggables.size(); i++)
 {
    Draggable d = (Draggable)draggables.get(i);
    d.draw();
    if(d.isBeingMouseHovered())
      draggable = d;
 }
}

void mousePressed() {
 draggable.mousePressed();
}

void mouseDragged() {
 draggable.mouseDragged();
}

void mouseReleased() {
 draggable.mouseReleased();
}

interface Draggable{
 boolean isBeingMouseHovered();
 boolean inside(float ix, float iy);
 void draw();
 void mousePressed();
 void mouseDragged();
 void mouseReleased();
}


class DraggableImage implements Draggable {
float x, y;
float radius;
boolean drag;
float dragX, dragY;
PImage anImage;

DraggableImage(float _x, float _y, PImage _anImage) {
  anImage = _anImage;
  x = _x; y = _y;
  //radius = 30;
  drag = false;
  dragX = 0;
  dragY = 0;
  
}

boolean isBeingMouseHovered()
{
  return inside(mouseX, mouseY);
}

boolean inside(float ix, float iy) {
  boolean answer = true;
  if(ix < x)
    answer = false;
  if(ix > (x + anImage.width))
    answer = false;
  if(iy < y)
    answer = false;
  if(iy > (y + anImage.height))
    answer = false;
    
  return answer;
}

void draw() {
  image(anImage, x, y);
}

void mousePressed() {
  drag = inside(mouseX, mouseY);
  if (drag) {
    dragX = mouseX - x;
    dragY = mouseY - y;
  }
}

void mouseDragged() {
  if (drag) {
    x = mouseX - dragX;
    y = mouseY - dragY;
  }
}

void mouseReleased() {
  drag = false;
}


}
class NullDraggableObject implements Draggable{
 boolean isBeingMouseHovered(){ return false;}
 boolean inside(float ix, float iy){return false;}
 void draw(){}
 void mousePressed(){}
 void mouseDragged(){}
 void mouseReleased(){}
}
class DraggableObject implements Draggable {
 float x, y;
 float radius;
 boolean drag;
 float dragX, dragY;
 
 DraggableObject(float _x, float _y) {
   x = _x; y = _y;
   radius = 30;
   drag = false;
   dragX = 0;
   dragY = 0;
 }
 
 boolean isBeingMouseHovered()
 {
   return inside(mouseX, mouseY);
 }

 boolean inside(float ix, float iy) {
   return (dist(x, y, ix, iy) < radius);
 }

 void draw() {
   ellipseMode(CENTER);
   ellipse(x, y, 2*radius, 2*radius);
 }

 void mousePressed() {
   drag = inside(mouseX, mouseY);
   if (drag) {
     dragX = mouseX - x;
     dragY = mouseY - y;
   }
 }

 void mouseDragged() {
   if (drag) {
     x = mouseX - dragX;
     y = mouseY - dragY;
   }
 }

 void mouseReleased() {
   drag = false;
 }
}

