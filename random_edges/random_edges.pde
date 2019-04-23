import controlP5.*;

import epidemic.*;
import epidemic.utils.*;


ControlP5 cp5;
GraphLattice g;

int N = 97;


void setup() {
  fullScreen();
  //size(1000, 1000);

  g = new GraphLattice(this, N);

  cp5 = new ControlP5(this);
  cp5.addButton("switchEdges").setPosition(100, 50).updateSize();
  cp5.addButton("addEdge").setPosition(100, 100).updateSize();
}


void draw() {


  background(255);


  for (int i=0; i<N; i++) {
    Node n = g.getNode(i);
    if (n.timer==0) {
      Node p = n.getRandomNeighbor();
      n.sendInfo(p, Type.PUSH);
      n.resetTimer();
    }
  }
  for (int i=0; i < N; i++) {

    Node n = g.getNode(i);
    Info info = g.receivedInfo(n);
    if (info != null) {
      
        if (info.value > n.value) {
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

void addEdge(){

  g.addEdge();
}

void mousePressed() {

  g.overGraph();
}
