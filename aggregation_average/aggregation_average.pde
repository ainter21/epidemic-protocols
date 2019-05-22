import epidemic.*;
import epidemic.utils.*;

GraphAggregation g;
int N = 20;
void setup(){
  
  fullScreen();
  Visual.nodeInfo = true;
  Visual.infoType = true;
  Visual.speed = 9;
  g = new GraphAggregation(this, N);
  
}


void draw(){
  
 
  background(255);
  
  
  for(int i=0; i < N; i++){
  
    NodeAggregation p = g.getNode(i);
    if(p.timer == 0){
    
      NodeAggregation q = p.getRandomNeighbor();
      
      p.sendInfo(q, Type.PUSH, p.value);
      p.resetTimer();
    }
  }
  
  
  for(int i=0; i < N; i ++){
  
    NodeAggregation p = g.getNode(i);
    
    if(p.hasReceived()){
    
      Info info = p.receivedInfo();
      
      if(info.type==Type.PUSH){
      
        float d = p.value - (p.value + info.value)/2;
        p.sendInfo(info.origin, Type.REPLY, d);
        p.setValue(p.value - d);
      }else if(info.type == Type.REPLY){
        
        p.setValue(p.value + info.value);
      }
    }
    
  }
  
  
  
  g.drawGraph();
}
