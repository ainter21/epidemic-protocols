//decommenta se hai installato la libreria cp5
//import controlP5.*;

import epidemic.*;
import epidemic.utils.*;

//decommenta se hai installato la libreria cp5
//ControlP5 cp5;
GraphSI g;

int N  =20;


void setup() {
  //fullScreen();
  size(1000, 1000);

  g = new GraphSI(this, N);

  //decommenta se hai installato la libreria cp5
  //cp5 = new ControlP5(this);
  //cp5.addButton("switchEdges").setPosition(100, 50).updateSize();
}


void draw() {


  background(255);


  //scrivi il codice qui sotto


  g.drawGraph();

  g.updateTimer();
}


//decommenta se hai installato la libreria cp5
//void switchEdges() {
//  g.switchEdges();
//}


void mousePressed() {

  g.overGraph();
}
