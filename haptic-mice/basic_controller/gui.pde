/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void fill_click(GButton source, GEvent event) { //_CODE_:btn_fill:689985:
  fill();
} //_CODE_:btn_fill:689985:

public void startstop_click(GButton source, GEvent event) { //_CODE_:btn_startstop:979319:
  if (checkFields()&&(runLoop==false)){
    btn_startstop.setVisible(false);
    btn_stop.setVisible(true);
    thread("doExperiment");
  }
} //_CODE_:btn_startstop:979319:

public void open_click(GButton source, GEvent event) { //_CODE_:btn_open:975310:
  thread("openDataFolder");
} //_CODE_:btn_open:975310:

public void vibr_click1(GButton source, GEvent event) { //_CODE_:btn_vibrate:960415:
  vibrate(fld_freq.getValueI(),fld_vibr_duration.getValueI());
  
} //_CODE_:btn_vibrate:960415:

public void feed_click1(GButton source, GEvent event) { //_CODE_:btn_feed:917356:
  feed();
} //_CODE_:btn_feed:917356:

public void setPort_click(GButton source, GEvent event) { //_CODE_:btn_setPort:379419:
  setArduino();
} //_CODE_:btn_setPort:379419:

public void stop_click(GButton source, GEvent event) { //_CODE_:btn_stop:341474:
  btn_startstop.setVisible(true);
  btn_stop.setVisible(false);
  runLoop=false;
} //_CODE_:btn_stop:341474:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Haptic Mice - Basic Controller");
  lbl_frequency = new GLabel(this, -70, 50, 200, 20);
  lbl_frequency.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_frequency.setText("Frequency (Hz):");
  lbl_frequency.setOpaque(false);
  lbl_vibr_duration = new GLabel(this, -70, 90, 200, 20);
  lbl_vibr_duration.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_vibr_duration.setText("Vibration duration (ms)");
  lbl_vibr_duration.setOpaque(false);
  lbl_time_response = new GLabel(this, -70, 130, 200, 20);
  lbl_time_response.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_time_response.setText("Time to response(ms)");
  lbl_time_response.setOpaque(false);
  lbl_repeat = new GLabel(this, -70, 170, 200, 20);
  lbl_repeat.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_repeat.setText("Repeats (times);");
  lbl_repeat.setOpaque(false);
  lbl_wait_experiments = new GLabel(this, 10, 210, 120, 30);
  lbl_wait_experiments.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_wait_experiments.setText("Time between experiments (ms):");
  lbl_wait_experiments.setOpaque(false);
  fld_freq = new GTextField(this, 130, 50, 110, 20, G4P.SCROLLBARS_NONE);
  fld_freq.setOpaque(true);
  fld_vibr_duration = new GTextField(this, 130, 90, 110, 20, G4P.SCROLLBARS_NONE);
  fld_vibr_duration.setOpaque(true);
  fld_response_time = new GTextField(this, 130, 130, 110, 20, G4P.SCROLLBARS_NONE);
  fld_response_time.setOpaque(true);
  fld_repeats = new GTextField(this, 130, 170, 110, 20, G4P.SCROLLBARS_NONE);
  fld_repeats.setOpaque(true);
  fld_time_experiments = new GTextField(this, 130, 220, 110, 20, G4P.SCROLLBARS_NONE);
  fld_time_experiments.setOpaque(true);
  btn_fill = new GButton(this, 20, 290, 80, 30);
  btn_fill.setText("Fill");
  btn_fill.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  btn_fill.addEventHandler(this, "fill_click");
  btn_startstop = new GButton(this, 170, 290, 80, 30);
  btn_startstop.setText("Start");
  btn_startstop.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  btn_startstop.addEventHandler(this, "startstop_click");
  btn_open = new GButton(this, 520, 290, 80, 30);
  btn_open.setText("Open...");
  btn_open.addEventHandler(this, "open_click");
  btn_vibrate = new GButton(this, 270, 140, 80, 30);
  btn_vibrate.setText("vibrate");
  btn_vibrate.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  btn_vibrate.addEventHandler(this, "vibr_click1");
  btn_feed = new GButton(this, 520, 140, 80, 30);
  btn_feed.setText("feed");
  btn_feed.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  btn_feed.addEventHandler(this, "feed_click1");
  lbl_port = new GLabel(this, 50, 10, 80, 20);
  lbl_port.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_port.setText("port:");
  lbl_port.setOpaque(false);
  lst_port = new GDropList(this, 130, 10, 110, 80, 3, 10);
  lst_port.setItems(Arduino.list(), 0);
  btn_setPort = new GButton(this, 270, 10, 80, 20);
  btn_setPort.setText("Open Port");
  btn_setPort.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  btn_setPort.addEventHandler(this, "setPort_click");
  btn_stop = new GButton(this, 340, 290, 80, 30);
  btn_stop.setText("Stop!");
  btn_stop.setLocalColorScheme(GCScheme.RED_SCHEME);
  btn_stop.addEventHandler(this, "stop_click");
  lbl_connected = new GLabel(this, 370, 10, 186, 20);
  lbl_connected.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_connected.setText("disconnected");
  lbl_connected.setOpaque(false);
}

// Variable declarations 
// autogenerated do not edit
GLabel lbl_frequency; 
GLabel lbl_vibr_duration; 
GLabel lbl_time_response; 
GLabel lbl_repeat; 
GLabel lbl_wait_experiments; 
GTextField fld_freq; 
GTextField fld_vibr_duration; 
GTextField fld_response_time; 
GTextField fld_repeats; 
GTextField fld_time_experiments; 
GButton btn_fill; 
GButton btn_startstop; 
GButton btn_open; 
GButton btn_vibrate; 
GButton btn_feed; 
GLabel lbl_port; 
GDropList lst_port; 
GButton btn_setPort; 
GButton btn_stop; 
GLabel lbl_connected; 
