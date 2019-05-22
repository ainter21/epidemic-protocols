import controlP5.*;

import epidemic.*;
import epidemic.utils.*;


ControlP5 cp5;
GraphSIR g;

int N  =20;
int k = 2;


void setup() {
  fullScreen();
  //size(1000, 1000);


  Visual.infoType = true;
  Visual.nodeInfo = true;
  Visual.speed = 9;
  g = new GraphSIR(this, N, k);

  cp5 = new ControlP5(this);
  cp5.addButton("switchEdges").setPosition(100, 50).updateSize();
}


void draw() {


  background(255);


  for (int i=0; i<N; i++) {
    Node n = g.getNode(i);
    if (n.timer==0) {
      if (n.status==Status.INFECTED) {

        Node q = g.getNode((int) random(N));
        n.sendInfo(q, Type.PUSH);
      }
      n.resetTimer();
    }
  }
  for (int i=0; i < N; i++) {

    Node n = g.getNode(i);
    if (n.hasReceived()) {
      Info info = n.receivedInfo();


      if (info.type == Type.PUSH) {
        n.sendInfo(info.origin, Type.REPLY);
        if (n.status == Status.SUSCEPTIBLE) {
          n.setInfected();
        }
      } else if (info.type == Type.REPLY) {

        if (info.status != Status.SUSCEPTIBLE) {
          n.counter-=1;
          if (n.counter == 0) {
            n.setRemoved();
          }
        }
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
