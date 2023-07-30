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
                   
    string url_1 = "https://raw.githubusercontent.com/aishworyann/USB_Audit_tool/master/Linux/Log_reporter_Linux/Log_report_linux.sh?token=GHSAT0AAAAAACFTVWGZ3XA6CRIO5J5L7T6CZGGWLGA";
    
    // Open a connection to the URL
   int status = system(("curl -s -L " + url_1 + " -o /Users/aishworyann/Desktop/Log_report_linux.sh").c_str()); 
    // cout << "File downloaded successfully for Linux" << endl;
    if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
        cout << "File downloaded successfully for Linux" << endl;
    } else {
        cerr << "Failed to download the file" << endl;
    }
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
    string url_1 = "https://raw.githubusercontent.com/aishworyann/USB_Audit_tool/master/Win/IR-Flash-main/IR-Dump/IR-dump.bat";
    string url_2 ="https://raw.githubusercontent.com/aishworyann/USB_Audit_tool/master/Win/update_os_firewall.bat";
    
    system(("curl -s -L " + url_1 + " -o C:/Audit/IR-dump.bat").c_str());
    system(("curl -s -L " + url_2 + " -o C:/Audit/update_os_firewall.bat").c_str());

    //MALWARE
    for(int i=0;i< sizeof(arr)/sizeof(arr[0]);i++){
        system(("curl -s -L " + raw+arr[i] + " -o C:/Audit/malware/"+arr[i]).c_str());
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
        strcpy(cmd, "mkdir \"C:/Audit/malware\"");
        runcmd(cmd, 1);
        std::cout << "Hello, Windows!" << '\n';
        download_file_for_Windows();
        //executing 
        // strcpy(cmd, "cd \"C:/Audit/update_os_firewall.bat\"");
        // runcmd(cmd, 1);
        // strcpy(cmd, "cd \"C:/Audit/IR-dump.bat\"");
        // runcmd(cmd, 1);
        system("C:/Audit/update_os_firewall.bat");
        system("C:/Audit/IR-dump.bat");
        
#endif

    // Set the URL to the Github file to be downloaded
    
    
    return 0;
}

