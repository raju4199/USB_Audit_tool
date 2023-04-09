@echo off
rem *------------------------------------------------------------------------------------------------------*
rem *                                                                                                      *
rem * Script name:IR-dump.bat Version:1.92   By:Archan Choudhury  18/05/2020                    *
rem *                                                                                                      *
rem * Creates the following files                                                                          *
rem *    %Timestamp%-%COMPUTERNAME%-dump.7z:                                                               *
rem *         arp table of the current network                                                             *
rem *         ipconfig of this machine                                                                     *
rem *         dnscache                                                                                     *
rem *         ipv4 stack from netsh                                                                        *
rem *         firewall settings from netsh                                                                 *
rem *         wifi configuration from netsh (no passwords)                                                 *
rem *         System Information                                                                           *
rem *         Service list                                                                                 *
rem *         Process list                                                                                 *
rem *         Eventlogs:                                                                                   *
rem *           System                                                                                     *
rem *			Application                                                                        *
rem *			Security                                                                           *
rem * 			Powershell                                                                         *
rem *           Defenderlogs                                                                               *
rem *           Firewalllogs                                                                               *
rem *         GPO (text and HTML)                                                                          *
rem *         Windows Scheduler                                                                            *
rem *         Audit Policy                                                                                 *
rem *         net user                                                                                     *
rem *         net localgroups                                                                              *    
rem *         net session                                                                                  *
rem *         net share                                                                                    *
rem *         doskey /history                                                                              *
rem *         powershell logs for all users where accessible                                               *
rem *           Allscriptfiles                                                                             *
rem *         Registry                                                                                     *
rem *         Cylance logs  (if exist)                                                                     *
rem *         McAfee Logs   (if exist)                                                                     *  
rem *         Defender Logs (if exist)                                                                     *
rem *         Trend AV logs (if exist)                                                                     *                                                                                         
rem *         Firewall eventlog                                                                            *
rem *         registry backup                                                                              *
rem *         WMI consumer                                                                                 *
rem *         archive of local scripts                                                                     *
rem *                                                                                                      *
rem *    <Timestamp>-<COMPUTERNAME>-memory.dmp                                                             *
rem *         Memory dump of the machine if requested                                                      *
rem *                                                                                                      *
rem * Usage: open a CMD prompt                                                                             *
rem * Extract the IR-Dump.zip file                                                                       *
rem * cd .\IR-Dump                                                                                       *
rem *    /f File system permissions                                                                        *
rem *            File system permissions                                                                   *
rem *    /h c:\windows file hashes                                                                         *
rem *            Hashes for all operating system files                                                     *
rem *    /m Memory dump                                                                                    *
rem *            ^<date^>-^<machinename^>-memory.aff4:                                                     *
rem *                                                                                                      *
rem *                                                                                                      *
rem * IR-dump.bat             #Creates a dump of log files no switches required                          *
rem *                                                                                                      *
rem * Valid switches below can be used in any order or combination to capture additional information       *
rem *    /f File system permissions                                                                        *
rem *    /h c:\windows file hashes                                                                         *
rem *    /m Creates an additional Memory dump                                                              *
rem *                                                                                                      *
rem * Examples                                                                                             *
rem *   IR-dump.bat             #Detailed logs too big for email but great for malware diags             *
rem *   IR-dump.bat /m          #As above but also captures a memory dump                                *
rem *   IR-dump.bat /s          #Small eventvwr logs only - if you're short of space fits into email     * 
rem *                                (not much detail)                                                     *    
rem *  others options(These options consume quite a bit of disk space!!)                                   *
rem *   IR-dump.bat /f          #Also captures file system permissions (slow)                            *   
rem *   IR-dump.bat /h          #Capures with windows file system hashes (very slow)                     *   
rem *                                                                                                      *
rem *   IR-dump.bat /f /m /h #All options above (Very Very Slow you probably don't want this)            *     
rem *                                                                                                      *
rem *  Fixes and Enhancements 1.92                                                                         *
rem *   1. Added vbs,pl,asp files to the script captures                                                   *
rem *                                                                                                      *
rem *  Fixes and Enhancements 1.91                                                                         *
rem *   1. Removed HKCU and HU registry keys as they could contain user personal data                      *
rem *                                                                                                      *
rem *  Fixes and enhancements 1.9                                                                          *
rem *   1. Added switch to capture all hidden scripts as well as standard ones                             *
rem *   2. Added /s switch for quick capture (only eventlogs nothing else) quit boring but fits email      *
rem *                                                                                                      *
rem *  Fixes and enhancements 1.8                                                                          *
rem *   1. Modified scripts captured to include ps1, bat, js, php in file archive                          *                                                                                  *
rem *   2. Fixed memory capture issues                                                                     *
rem *                                                                                                      *
rem *  Fixes and enhancements 1.7                                                                          *
rem *   1. Added dnscache                                                                                  *
rem *   2. Added WMI Provider                                                                              *
rem *   3. Added Registry export                                                                           *
rem *   4. Added ps1 and bat archive                                                                       *
rem *                                                                                                      *
rem *  Fixes and enhancements 1.6                                                                          *
rem *   1. Added Standardised exported file names to include <%timestamp%-%computername%-logtype for all   *
rem *      Reports                                                                                         *
rem *                                                                                                      *
rem *  Fixes and enhancements 1.5                                                                          *
rem *   1. Included Trend AV logs                                                                          *
rem *   2. Fixed Syntax error stopping some logs generating                                                *
rem *                                                                                                      *
rem *  Fixes and enhancements 1.4                                                                          *
rem *   1. Changed the compression method to 7z to bring the output file size down so hopefull it's below  *
rem *      The 10MB limit for emails. Also improves cross platform compatibility between different versions*
rem *      of powershell.                                                                                  * 
rem *   2. Added local Cylance Logs if any exist                                                           *
rem *   3. Added local McAfee Logs if any exist                                                            *
rem *   4. Added local Windows Defender eventlogs                                                          *
rem *   5. Added local windows firewall eventlogs                                                          *
rem *                                                                                                      *
rem *                                                                                                      *
rem *  Fixes and enhancements 1.3                                                                          *
rem *   1. Check user has admin level Privs and suggested solution or to contact IR                      *
rem *   2. Captured doskey history                                                                         *
rem *   3. Captured powershell history for as many users as we have access to                              *
rem *   4. Provided ability to capture memory dump without page file see switches above                    *
rem *   5. Increase verbosity in script log                                                                *
rem *   6. Captured windows net data eg. net user, session, localgroups, shares                            *
rem *   7. Added date and computer watermark to memory and pagefile dumps                                  *
rem *                                                                                                      *
rem *  Fixes. 1.2                                                                                          *
rem *  ==========                                                                                          *
rem *   1. file format of processes.log is actually csv. renamed output file                               *
rem *   2. Date stamp was missing off the start of the output files                                        *
rem *                                                                                                      *
rem *------------------------------------------------------------------------------------------------------*

rem create the working directory

rem Set the output path
Set fs="false" 
set dump="false"
set hash="false"
set small="false"
set mypath=%cd%

mkdir %mypath%\dumps 2>nul

rem getting time and date
for /f "tokens=1-7 delims=/:. " %%a IN ("%Date%") do set timestamp=%%c%%b%%a


set Outpath=%mypath%\dumps
set OutputFile=%Outpath%\%Timestamp%-%COMPUTERNAME%
rem Check Commandline Args
if "%1" == "" (
    rem if %1 is blank there were no arguments. Show how to use this batch
	goto Main
    exit /b
)

Rem GetArgs
:again
rem if %1 is blank, we are finished
if not "%1" =="" (
	if "%1" == "/f" Set fs="true" 
	if "%1" == "/m" set dump="true"
	if "%1" == "/h" set hash="true"
	if "%1" == "/s" set small="true"
shift
goto again
)

:Main
rem pre-flight checks
rem check that we don't have any switches that might clash.
rem are we admin?

net session >nul 2>&1
if %errorLevel% == 0 (
	echo Success: Administrative permissions confirmed.
) else (
	echo NB. You don't have the required Administrator permissions. 
	echo .
	echo Please quit and try again, right click the CMD prompt to "runas Administrator" 
	echo .
	echo If this doesn't work please contact the IR team, they want you to go ahead anyway! Some important data 
	echo will not be captured and you will see messages in the report at the end, stateing "Access Denied" on some
	echo of the capture jobs.
	echo .
	echo Please press ^<ctrl^> c and then press Y to quit OR press other key to continue
	pause >nul
)


rem clean up old files so we can re-run if necessary
del %mypath%\dump.zip 2>nul
del %mypath%\Memory.aff4 2>nul

echo Depending on the number of Files and CPU perfomance of this machine it can take 10-30 mins to run

rem we only want eventlogs then
if /i %small%=="true" goto :Eventlogs


rem Network Stack
call :NEW_STEP 1
echo Capturing Network Stack >> %OutputFile%-dump.log
arp -a -v 1>>%OutputFile%-arp.log 2>>%OutputFile%-dump.log
call :NEW_STEP 2
ipconfig /all 1>>%OutputFile%-ipconfig.log 2>>%OutputFile%-dump.log
ipconfig /displaydns>%OutputFile%-dnscache.log 2>>%OutputFile%-dump.log
call :NEW_STEP 3
netsh interface ipv4 show config  1>>%OutputFile%-Network.log 2>>%OutputFile%-dump.log
call :NEW_STEP 4
netsh advfirewall show allprofiles 1>>%OutputFile%-firewall.log 2>>%OutputFile%-dump.log
call :NEW_STEP 5
netsh wlan show all 1>>%OutputFile%-wlan.log 2>>%OutputFile%-dump.log
call :NEW_STEP 6
netstat -noab 1>>%OutputFile%-netstat-noab.log 2>>%OutputFile%-dump.log
call :NEW_STEP 7
net user  1>>%OutputFile%-netusers.log 2>>%OutputFile%-dump.log
call :NEW_STEP 8
net session  1>>%OutputFile%-netsession.log 2>>%OutputFile%-dump.log
call :NEW_STEP 9
net view  1>>%OutputFile%-netview.log 2>>%OutputFile%-dump.log
call :NEW_STEP 10
net localgroup  1>>%OutputFile%-netlocalgroup.log 2>>%OutputFile%-dump.log
call :NEW_STEP 11
net share 1>>%OutputFile%-netshare.log 2>>%OutputFile%-dump.log
call :NEW_STEP 12

rem AuditPolicy
echo Capturing auditpol  >> %OutputFile%-dump.log
auditpol  /get /sd 1>>%OutputFile%-auditpol.log 2>>%OutputFile%-dump.log
call :NEW_STEP 20
auditpol  /get /category:* 1>>%OutputFile%-auditpol.log 2>>%OutputFile%-dump.log
call :NEW_STEP 22
auditpol  /get /option:CrashOnAuditFail 1>>%OutputFile%-auditpol.log 2>>%OutputFile%-dump.log
call :NEW_STEP 23
auditpol  /get /option:AuditBaseObjects 1>>%OutputFile%-auditpol.log 2>>%OutputFile%-dump.log
call :NEW_STEP 24
auditpol  /get /option:AuditBasedirectories 1>>%OutputFile%-auditpol.log 2>>%OutputFile%-dump.log
call :NEW_STEP 25
auditpol  /get /option:CrashOnAuditFail 1>>%OutputFile%-auditpol.log 2>>%OutputFile%-dump.log
call :NEW_STEP 26
auditpol  /get /option:FullPrivilegeAuditing 1>>%OutputFile%-auditpol.log 2>>%OutputFile%-dump.log
call :NEW_STEP 29

rem SystemInfo
echo Capturing systeminfo and config >> %OutputFile%-dump.log
systeminfo 1>>%OutputFile%-System.log 2>>%OutputFile%-dump.log
call :NEW_STEP 40
set 1>>%OutputFile%-Set.log 2>>%OutputFile%-dump.log
call :NEW_STEP 43
doskey /history 1>>%OutputFile%-doskey.log 2>>%OutputFile%-dump.log
call :NEW_STEP 48
echo Capturing powershell history ignore errors in this section >> %OutputFile%-dump.log
for /f "usebackq delims=|" %%f in (`dir /b "%HOMEDRIVE%\users"`) do (
	type "%HOMEDRIVE%\users\%%f\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt" 1>>%OutputFile%-PowershellHistory.log 2>>%OutputFile%-dump.log
)
call :NEW_STEP 49

Rem Services and Processes
echo Capturing Services and Processes>> %OutputFile%-dump.log
sc query 1>>%OutputFile%-Services.log 2>>%OutputFile%-dump.log
call :NEW_STEP 50
tasklist /V /FO CSV 1>>%OutputFile%-Processes-verbose.csv 2>>%OutputFile%-dump.log
call :NEW_STEP 53
tasklist /SVC /FO CSV 1>>%OutputFile%-Processes-Service.csv 2>>%OutputFile%-dump.log
call :NEW_STEP 56
tasklist /APPS /FO CSV 1>>%OutputFile%-Processes-apps.csv 2>>%OutputFile%-dump.log
call :NEW_STEP 59

reg export HKLM %OutputFile%-HKLM.reg >>%OutputFile%-dump.log
call :NEW_STEP 60
rem reg export HKCU %OutputFile%-HKCU.reg >>%OutputFile%-dump.log <-Removed
call :NEW_STEP 62
reg export HKCR %OutputFile%-HKCR.reg >>%OutputFile%-dump.log
call :NEW_STEP 63
rem reg export HKU %OutputFile%-HKU.reg >>%OutputFile%-dump.log <- Removed
call :NEW_STEP 64
reg export HKCC %OutputFile%-HKCC.reg >>%OutputFile%-dump.log
call :NEW_STEP 65

wmic/namespace:\\root\subscription PATH __EventConsumer get/format:list > %OutputFile%-wmi-Consumer.log 2>>%OutputFile%-dump.log
call :NEW_STEP 66
wmic/namespace:\\root\subscription PATH __EventFilter get/format:list > %OutputFile%-wmi-filter.log 2>>%OutputFile%-dump.log
call :NEW_STEP 67
wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding get/ format:list > %OutputFile%-wmi-consumerbinding.log 2>>%OutputFile%-dump.log
call :NEW_STEP 68
wmic/namespace:\\root\subscription PATH __TimerInstruction get/format:list >%OutputFile%-wmi-Timer.log 2>>%OutputFile%-dump.log
call :NEW_STEP 69
dir c:\*.ps1 /s /b /a >%OutputFile%-listscriptfiles.txt 2>>%OutputFile%-dump.log
dir c:\*.bat /s /b /a >>%OutputFile%-listscriptfiles.txt 2>>%OutputFile%-dump.log
dir c:\*.js /s /b /a >>%OutputFile%-listscriptfiles.txt 2>>%OutputFile%-dump.log
dir c:\*.php /s /b /a >>%OutputFile%-listscriptfiles.txt 2>>%OutputFile%-dump.log
dir c:\*.vbs /s /b /a >>%OutputFile%-listscriptfiles.txt 2>>%OutputFile%-dump.log
dir c:\*.pl /s /b /a >>%OutputFile%-listscriptfiles.txt 2>>%OutputFile%-dump.log
dir c:\*.asp /s /b /a >>%OutputFile%-listscriptfiles.txt 2>>%OutputFile%-dump.log
%mypath%\7za.exe a -t7z -spf -mx9 %OutputFile%-scriptfiles.7z @%OutputFile%-listscriptfiles.txt >>%OutputFile%-dump.log

Rem Scheduled Tasks
echo Capturing task scheduler >>%OutputFile%-dump.log
schtasks /Query /FO CSV /V 1>>%OutputFile%-Scheduler.csv 2>>%OutputFile%-dump.log
call :NEW_STEP 80

Rem copy cylancelogs if any
if exist "C:\Program Files\Cylance\Desktop\log" (
	echo Cylance Files exist copying Logs >>%OutputFile%-dump.log
	mkdir %Outpath%\CylanceLogs
	copy "C:\Program Files\Cylance\Desktop\log" "%Outpath%\CylanceLogs" 1>>%OutputFile%-CylanceLogs.log 2>>%OutputFile%-dump.log
)

rem copy McAfee Logs if any
if exist "C:\ProgramData\McAfee\DesktopProtection" (
	echo McAfee Files exist copying Logs >>%OutputFile%-dump.log
	mkdir %Outpath%\McAfeeLogs
	copy "C:\ProgramData\McAfee\DesktopProtection" "%Outpath%\McAfeeLogs" 1>>%OutputFile%-McAfeeLogs.log 2>>%OutputFile%-dump.log
)

rem copy Trend logs if any
if exist "C:\ProgramData\Trend Micro" (
	echo Trend AV Files exist copying Logs >>%OutputFile%-dump.log
	mkdir "%Outpath%\Trend Micro"
	mkdir "%Outpath%\Trend Micro\Deep Security Agent"
	mkdir "%Outpath%\Trend Micro\Deep Security Agent\am"
	mkdir "%Outpath%\Trend Micro\Deep Security Agent\diag"
	copy "C:\ProgramData\Trend Micro\Deep Security Agent\diag\*.log" "%Outpath%\Trend Micro\Deep Security Agent\diag" 1>>%OutputFile%-Trend.log 2>>%OutputFile%-dump.log
	copy "C:\ProgramData\Trend Micro\Deep Security Agent\am\*.db" + "C:\ProgramData\Trend Micro\Deep Security Agent\am\*.log" + "C:\ProgramData\Trend Micro\Deep Security Agent\am\*.txt" "%Outpath%\Trend Micro\Deep Security Agent\am" 1>>%OutputFile%-Trend.log 2>>%OutputFile%-dump.log
)
rem copy Symantec Logs if any
if exist "C:\ProgramData\Symantec\Symantec Endpoint Protection" (
	echo SEP Files exist copying Logs >>%OutputFile%-dump.log
	mkdir %Outpath%\SEPlogs
	copy "C:\ProgramData\Symantec\Symantec Endpoint Protection\14.2.5323.2000.105\Data\Logs" "%Outpath%\SEPlogs" 1>>%OutputFile%-SEPlogs.log 2>>%OutputFile%-dump.log
)


Rem GPO Audit
echo Capturing computer GPO as log and HTML >>%OutputFile%-dump.log
gpresult /Scope Computer /Z /F >>%OutputFile%-GPO.log 2>>%OutputFile%-dump.log
call :NEW_STEP 81
gpresult /Scope Computer /H %OutputFile%-GPO.html 2>>%OutputFile%-dump.log

:Eventlogs
Rem Eventlogs
echo Capturing eventlogs >>%OutputFile%-dump.log
wevtutil epl System %OutputFile%-Eventlog-System.evtx 2>>%OutputFile%-dump.log
call :NEW_STEP 82
wevtutil epl Application %OutputFile%-Eventlog-Application.evtx 2>>%OutputFile%-dump.log
call :NEW_STEP 83
wevtutil epl Security %OutputFile%-Eventlog-Security.evtx 2>>%OutputFile%-dump.log
call :NEW_STEP 84
wevtutil epl "Windows PowerShell" %OutputFile%-Eventlog-Powershell.evtx 2>>%OutputFile%-dump.log
call :NEW_STEP 85
wevtutil epl ForwardedEvents %OutputFile%-Eventlog-ForwardEvents.evtx 2>>%OutputFile%-dump.log
call :NEW_STEP 86
wevtutil epl "Microsoft-Windows-Windows Defender/Operational" %OutputFile%-Eventlog-Defender.evtx 2>>%OutputFile%-dump.log
call :NEW_STEP 87
wevtutil epl "Microsoft-Windows-Windows Defender/WHC" %OutputFile%-Eventlog-DefenderWHC.evtx 2>>%OutputFile%-dump.log
call :NEW_STEP 88
wevtutil epl "Microsoft-Windows-Windows Firewall With Advanced Security/Firewall" %OutputFile%-Eventlog-Firewall.evtx 2>>%OutputFile%-dump.log
call :NEW_STEP 89

Rem Extra Stuff
if /i %fs%=="true" call :DoFile
if /i %hash%=="true" call :Hash
if /i %dump%=="true" call :DoMem

Rem Let the user know how it's gone
echo.
echo **************Displaying process report**************
echo.
type %OutputFile%-dump.log
echo.
echo.
echo Compressing output to %COMPUTERNAME%-dump.7z please wait
%mypath%\7za.exe a -sdel -bt -t7z -mx9 -pinfected %Timestamp%-%COMPUTERNAME%-dump.7z dumps
echo Compression of %Timestamp%-%COMPUTERNAME%-dump.7z complete
echo.
call :finished
goto :EOF

:DoFile
echo Checking file system permissions
echo.
call :NEW_STEP 81
echo Capturing file systems attributes >>%OutputFile%-dump.log
attrib /s /d %HOMEDRIVE%\* 1>>%OutputFile%-attrib.log 2>>%OutputFile%-dump.log
call :NEW_STEP 82
echo Capturing file tree >>%OutputFile%-dump.log
tree %HOMEDRIVE%\ /f /a 1>>%OutputFile%-tree.log 2>>%OutputFile%-dump.log
call :NEW_STEP 83
echo Capturing file system directories >>%OutputFile%-dump.log
dir %HOMEDRIVE%\* /q /s /r 1>>%OutputFile%-dir.log 2>>%OutputFile%-dump.log
call :NEW_STEP 84
echo Capturing file system permissions >>%OutputFile%-dump.log
cacls %HOMEDRIVE%\ /T /C 1>>%OutputFile%-Cacls.log 2>>%OutputFile%-dump.log
call :NEW_STEP 85
exit /b

:Hash
call :NEW_STEP 86
echo Creating hashes to check with AV Signitures This can take a really long time Don't worry it hasn't stopped working.
echo Capturing file system Hashes for c:\windows >>%OutputFile%-dump.log
pushd C:\windows
for /R %%D in (.\*) do  @certutil -hashfile "%%D" MD5 |find /v "CertUtil" 1>>%OutputFile%-windowsHashes.log 2>>%OutputFile%-dump.log
call :NEW_STEP 100
popd
exit /b

:DoMem
echo.
echo Memory dump also requested generating please wait.
echo.
echo Capturing memory only dump >>%OutputFile%-dump.log
wmic os get osarchitecture |findstr 64
IF %ERRORLEVEL% == 0 (
	%mypath%\RamCapturer\x64\RamCapture64.exe %mypath%\%Timestamp%-%COMPUTERNAME%-memory.dmp >>%OutputFile%-dump.log
)
IF %ERRORLEVEL% == 1 (
	%mypath%\RamCapturer\x86\RamCapture.exe %mypath%\%%Timestamp%-%COMPUTERNAME%-memory.dmp >>%OutputFile%-dump.log
)
echo.
echo Memory dump complete
exit /b

:finished
echo.
echo ---------------------------------------------Capture complete------------------------------------
echo *                                                                                               *
echo *        Please send [30;32m%Timestamp%-%COMPUTERNAME%-dump.7z [30;37m to the IR team                                                  *
if /i %dump%=="true" echo *        Please also send the [30;32m%Timestamp%-%COMPUTERNAME%-memory.dmp[30;37m                                                      *
echo *                                                                                               *
echo *                                                                                               *
echo ---------------------------------------------Capture complete------------------------------------
echo.
title Command Prompt
exit /b

:NEW_STEP
REM We display a point without carriage return.
echo|set /p=.
title %1%%% Completed
exit /b

:EOF
