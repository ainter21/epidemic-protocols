import controlP5.*;

import epidemic.*;
import epidemic.utils.*;


ControlP5 cp5;
GraphSIR g;
int N  =20;
int k = 5;


void setup() {
  fullScreen();
  //size(1080, 1030);

  g = new GraphSIR(this, N, k);

  cp5 = new ControlP5(this);
  cp5.addButton("switchEdges").setPosition(100, 50).updateSize();
}


void draw() {


  background(255);





  for (int i=0; i<N; i++) {

    Node n = g.getNode(i);

    if (n.timer==0) {
      if (n.status == Status.INFECTED) {
        Node q = g.getNode((int) random(N));

        n.sendInfo(q, Type.PUSH);
        float coin = random(1);


        if (coin < (1.0/n.counter)) {
          n.setRemoved();
        }
      }
      n.resetTimer();
    }
  }
  for (int i=0; i < N; i++) {

    Node n = g.getNode(i);
    if (n.hasReceived()) {




      if (n.status == Status.SUSCEPTIBLE) {

        n.setInfected();
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
