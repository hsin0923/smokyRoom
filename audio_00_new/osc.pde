
import oscP5.*;
import netP5.*;

String[] oscAddress = { 
  "/sound/start", "/sound/stop"
};
String[] oscMethod  = { 
  "start", "stop"
};

OscP5 osc;

int shin_id = 191;
int will_id = 150;
int luis_id = 146;
int riha_id = 121;
int clem_id = 214;
int adri_id = 170;
int laur_id = 146;
int evar_id = 115;
int mart_id = 200;

void setupOSC() {

  // initialize OSC
  osc = new OscP5(this, localport);

  // plug osc messages into callback methods
  for (int i = 0; i < oscAddress.length; i++) {
    osc.plug(this, oscMethod[i], oscAddress[i]);
  }
}


public void start(int x, int y) {
  println("RECEIVE: Start (" + x + ", " + y +")");
  soundEvent(x,  y);
}

public void stop(int x, int y) {
  println("RECEIVE: Stop (" + x + ", " + y +")");
  soundEvent(y, x);
}

// Show which OSC events were received but ignored
void oscEvent(OscMessage msg) {
  if (!msg.isPlugged()) {
    println("Unhandled OSC message " + msg.addrPattern() + "(" + msg.typetag());
  }
}






