import controlP5.*;

import epidemic.*;
import epidemic.utils.*;


ControlP5 cp5;
Graph g;

int N = 100;

void setup() {
  size(1000, 1000);

  g = new Graph(this, N);

  cp5 = new ControlP5(this);
  cp5.addButton("switchEdges").setPosition(100, 50).updateSize();
}


void draw() {


  background(255);


  for (int i=0; i<N; i++) {
    Node n = g.getNode(i);
    if (n.timer==0) {
      Node p = g.getNode((int) random(0, N));
      n.sendInfo(p, Type.PUSH);
      n.resetTimer();
    }
   
  }
  for(int i=0; i < N; i++){
  
    Node n = g.getNode(i);
    Info info = g.receivedInfo(n);
    if(info != null){
      
      if(n.value < info.value){
        n.setValue(info);
      }
    }
  }


  g.drawGraph();

  g.updateTimer();
}


void switchEdges() {
  g.switchEdges();
}


void mousePressed() {

  g.overGraph();
}
