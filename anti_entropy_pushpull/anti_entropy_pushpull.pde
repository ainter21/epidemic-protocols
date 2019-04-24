import controlP5.*;

import epidemic.*;
import epidemic.utils.*;


ControlP5 cp5;
GraphSI g;

int N  =50;


void setup() {
  fullScreen();
  //size(1000, 1000);

  g = new GraphSI(this, N);

  cp5 = new ControlP5(this);
  cp5.addButton("switchEdges").setPosition(100, 50).updateSize();
}


void draw() {


  background(255);


  for (int i=0; i<N; i++) {
    Node n = g.getNode(i);
    if (n.timer==0) {
      Node p = g.getNode((int) random(0, N));
      n.sendInfo(p, Type.PUSH_PULL);
      n.resetTimer();
    }
  }
  for (int i=0; i < N; i++) {
    
    Node n = g.getNode(i);
    Info info = g.receivedInfo(n);
    if (info != null) {
      if (info.type == Type.PUSH_PULL) {
        if (info.time < n.time) {
          n.sendInfo(info.origin, Type.REPLY);
        }else if(info.time > n.time){
          n.setValue(info);  
        }
      } else if (info.type == Type.REPLY) {


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
