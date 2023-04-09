#include <iostream>
#include <fstream>
#include <sstream>
#include <bits/stdc++.h>
#include <cstdlib>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
using namespace std;

char dest_linux[512] ="/Users/aishworyann/Desktop";
char dest_win[512] =" C:/";

void runcmd(char *cmd, int verbose) {
    char buffer[256];
    FILE *fp = popen(cmd, "r");
    if (fp == NULL) {
        printf("Failed to run command: %s\n", cmd);
        return;
    }
    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        if (verbose) {
            printf("%s", buffer);
        }
    }
    pclose(fp);
}

void download_file_for_Linux(){
                   
    string url_1 = "https://raw.githubusercontent.com/aishworyann/USB_Audit_tool/master/Linux/Log_reporter_Linux/Log_report_linux.sh";
    
    // Open a connection to the URL
    system(("curl -s -L " + url_1 + " -o /Users/aishworyann/Desktop/Log_report_linux.sh").c_str());
    cout << "File downloaded successfully for Linux" << endl;
}
 
void download_file_for_Windows(){
    //destination url
    string raw ="https://github.com/aishworyann/USB_Audit_tool/blob/e96ce1025cfde4285ab41adf0b94833938ac2a92/Win/Malware_analyzer/";
                   
                   string arr[]={"BAV.bat","BAVAutorun.bat",
                   "BAVConfig.bat","BAVDetail.bat",
                   "BAVFiles.txt", "BAVStatus.bat",
                   "BAVUpdate.bat","DeepScan.bat",
                   "InstallIntercept.bat","Quarantine.bat",
                   "RealTimeProtection.bat","ScanIntercept.bat",
                   "USBCleaner.bat","USBScan.bat",
                   "VirusDataBaseHash.bav","VirusDataBaseIP.bav",
                   "database.ver","gethex.exe",
                   "sha256.exe","waitdirchange.exe" };
    //IR FLASH          
    string url_1 = "https://github.com/aishworyann/USB_Audit_tool/blob/a0646984abbfb0c5e0d87a32e45b58b1b80b6f21/Win/IR-Flash-main/IR-Dump/IR-dump.bat";
    string url_2 ="https://github.com/aishworyann/USB_Audit_tool/blob/125f2229ac3b2240e660b7fb232aafc6b79c9e77/Win/update_os_firewall.ps1";
    
    system(("curl -s -L " + url_1 + " -o dest_win/Audit/IR-dump.bat").c_str());
    system(("curl -s -L " + url_1 + " -o dest_win/Audit/update_os_firewall.ps1").c_str());

    //MALWARE
    for(int i=0;i< sizeof(arr)/sizeof(arr[0]);i++){
        system(("curl -s -L " + raw+arr[i] + " -o dest_win/Audit/malware/"+arr[i]).c_str());
    }
    
    //
    cout << "File downloaded successfully" << endl;
}


int main()
{
        
    char cmd[512];
    #if defined(__linux__) // Or #if __linux__
         std::cout << "Hello, GNU/Linux!" << '\n';
         download_file_for_Linux();
         strcpy(cmd, "sh \"dest_linux/Log_report_linux.sh\"");
         runcmd(cmd, 1);
    #elif __APPLE__ // macOS code
         std::cout << "Hello, macOS!" << '\n';    
         download_file_for_Linux();
        strcpy(cmd, "sh \"/Users/aishworyann/Desktop/Log_report_linux.sh\"");
        runcmd(cmd, 1);
    #elif _WIN32 // Windows Code
        //for making malware folder
        strcpy(cmd, "mkdir \"C:/Audit\"");
        runcmd(cmd, 1);
        strcpy(cmd, "mkdir \"dest_win/Audit/malware\"");
        runcmd(cmd, 1);
        std::cout << "Hello, Windows!" << '\n';
        download_file_for_Windows();
        //executing 
        strcpy(cmd, "cd \"dest_win/Audit/update_os_firewall.ps1\"");
        runcmd(cmd, 1);
        strcpy(cmd, "cd \"dest_win/Audit/IR-dump.bat\"");
        runcmd(cmd, 1);
        
#endif

    // Set the URL to the Github file to be downloaded
    
    
    return 0;
}