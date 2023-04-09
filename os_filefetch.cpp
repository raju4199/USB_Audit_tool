#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstdlib>

using namespace std;

int main()
{
    // Set the URL to the Github file to be downloaded
    string url_1 = "https://github.com/raju4199/sales-Forecasting-AIML/raw/master/dataset/salesdaily.csv";
    string url_2 = "https://github.com/raju4199/USB_Audit_tool/blob/master/script_irdump.py";
    // Open a connection to the URL
    system(("curl -s -L " + url_1 + " -o salesdaily.csv").c_str());
    system(("curl -s -L " + url_2 + " -o script_irdump.py").c_str());

    cout << "File downloaded successfully" << endl;

    return 0;
}
