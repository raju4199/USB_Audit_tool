net accounts > C:\Users\skans\admin_password.txt
wbadmin get status > C:\Users\skans\backup_status.txt 
ipconfig /all > C:\Users\skans\network_status.txt 
netstat -ano > C:\Users\skans\open_ports.txt 
systeminfo > C:\Users\skans\os_report.txt 
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"Hotfix(s)" > C:\Users\skans\os_version.txt 