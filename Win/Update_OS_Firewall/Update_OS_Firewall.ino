#include <DigiKeyboard.h>

void setup() {
  DigiKeyboard.delay(1000);
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(500);
  DigiKeyboard.print("powershell");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);
  //Update History
  DigiKeyboard.print("wmic qfe list > updatehistory.txt");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);

  //Firewall
  
  DigiKeyboard.print("Get-NetFirewallProfile | select Name,Enabled > firewallstatus.txt");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);

  //OS Report
  DigiKeyboard.print("$sysWMI = Get-WmiObject Win32_OperatingSystem");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);
  DigiKeyboard.print("$osreport=$sysWMI.Caption + \" \" + $sysWMI.Version + \" \" + $sysWMI.OSArchitecture");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);
  DigiKeyboard.print("New-Item osreport.txt -ItemType file -Force");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);

  
  DigiKeyboard.print("Set-Content osreport.txt $osreport");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);
  DigiKeyboard.print("exit");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);




  //new
  DigiKeyboard.delay(1000);
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(500);
  DigiKeyboard.print("powershell");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);
  //Open Ports
  DigiKeyboard.println("Get-NetTCPConnection | Select-Object LocalAddress,LocalPort,RemoteAddress,RemotePort,State,ProcessName | Format-Table -AutoSize  > open_ports.txt");
  DigiKeyboard.sendKeyStroke(0, KEY_ENTER);
  DigiKeyboard.delay(5000);
  DigiKeyboard.print("exit");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  
}

void loop() {}
