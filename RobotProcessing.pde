import processing.serial.*; //import serial library
Serial myPort;

float Ard_values;

PrintWriter output_width;
PrintWriter output_depth;
PrintWriter output_height;


void setup() {
  // Create a new file in the sketch directory
  printArray(Serial.list());  // list all available serial ports
  myPort = new Serial(this, Serial.list()[0], 115200);   //use your correct serial port
  myPort.clear();  // clear the port of any initial junk
  output_width = createWriter("width.csv"); //create a CSV file to log data
  output_depth = createWriter("depth.csv"); //create a CSV file to log data
  output_height = createWriter("height.csv"); //create a CSV file to log data
  myPort.bufferUntil('\n');

}

//void draw()
//{
//}
void draw() {
  while (myPort.available () > 0) {  // make sure port is open
  String inString = myPort.readStringUntil('\n');  // read input string
    if (inString != null) {  // ignore null strings
      inString = trim(inString);  // trim off any whitespace
      Ard_values=float(inString); //convert to float
      output_width.println(str(Ard_values)); // output length
      println(Ard_values);
      if (keyPressed) { //if statement to look for keyboard input
        if (key == 'w') {
          output_width.flush();  // Writes the remaining data to the file
          output_width.close();  // Finishes the file
          //exit();  // Stops the program
        }
       }
    }
    if (inString != null) {  // ignore null strings
      inString = trim(inString);  // trim off any whitespace
      Ard_values=float(inString); //convert to int
      output_depth.println(str(Ard_values)); // output length
      if (keyPressed) { //if statement to look for keyboard input
        if (key == 'd') {
          output_depth.flush();  // Writes the remaining data to the file
          output_depth.close();  // Finishes the file
          //exit();  // Stops the program
        }
       }
    }
    if (inString != null) {  // ignore null strings
      inString = trim(inString);  // trim off any whitespace
      Ard_values=float(inString); //convert to int
      output_height.println(str(Ard_values)); // output length
      if (keyPressed) { //if statement to look for keyboard input
        if (key == 'h') {
          output_height.flush();  // Writes the remaining data to the file
          output_height.close();  // Finishes the file
          //exit();  // Stops the program
        }
       }
    }
      if (keyPressed) { //if statement to look for keyboard input
       if (key == 'e') {
         exit();  // Stops the program
       }
    }
  }
}
