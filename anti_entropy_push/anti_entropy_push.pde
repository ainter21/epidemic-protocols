import controlP5.*;

import epidemic.*;
import epidemic.utils.*;


ControlP5 cp5;
GraphSI g;

int N = 20;

void setup() {
  size(1000, 1000);

  g = new GraphSI(this, N);

  //il bottone serve per nascondere le connessioni tra i nodi.
  //ATTENZIONE: da non utilizzare quando ci sono molti nodi!
  cp5 = new ControlP5(this);
  cp5.addButton("switchEdges").setPosition(100, 50).updateSize();
}


void draw() {


  background(255);


  for (int i=0; i<N; i++) {
    Node n = g.getNode(i);
    if (n.timer==0) {
      if (n.status==Status.INFECTED) {
        Node p = g.getNode((int) random(0, N));
        n.sendInfo(p, Type.PUSH);
      }
      n.resetTimer();
    }
  }
  for (int i=0; i < N; i++) {

    Node n = g.getNode(i);
    if (n.hasReceived()) {
      Info info = n.receivedInfo();


      if (n.timestamp < info.timestamp) {
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
