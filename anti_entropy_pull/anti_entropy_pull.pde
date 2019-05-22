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
  Visual.infoType = true;
  Visual.nodeInfo = true;

  //decommenta se hai installato la libreria cp5
  //cp5 = new ControlP5(this);
  //cp5.addButton("switchEdges").setPosition(100, 50).updateSize();
}


void draw() {


  background(255);


  for(int i=0; i < N; i++){
  
    Node p = g.getNode(i);
    
    if(p.timer == 0){
    
      Node q = p.getRandomNeighbor();
      
      p.sendInfo(q,Type.PULL);
      
      p.resetTimer();
    }
  }
  
  for(int i=0; i < N; i++){
  
    Node p = g.getNode(i);
    
    if(p.hasReceived()){
    
      Info info = p.receivedInfo();
      
      if(info.type == Type.PULL){
      
        if(info.timestamp < p.timestamp){
        
          p.sendInfo(info.origin, Type.REPLY);
        }
      }else if(info.type == Type.REPLY){
      
        if(info.timestamp>p.timestamp){
        
          p.setValue(info);
        }
      }
    }
  }


  g.drawGraph();

  //g.updateTimer();
}


//decommenta se hai installato la libreria cp5
//void switchEdges() {
//  g.switchEdges();
//}


void mousePressed() {

  g.overGraph();
}
