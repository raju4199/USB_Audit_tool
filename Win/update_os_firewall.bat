echo @off
net accounts > C:\Audit\admin_password.txt
wbadmin get status > C:\Audit\backup_status.txt 
ipconfig /all > C:\Audit\network_status.txt 
netstat -ano > C:\Audit\skans\open_ports.txt 
systeminfo > C:\Audit\skans\os_report.txt 
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"Hotfix(s)" > C:\Audit\os_version.txt 
PAUSE
