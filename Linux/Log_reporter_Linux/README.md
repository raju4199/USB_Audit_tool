# AutoLLR
Script to automate Linux live evidence collection

AutoLLR is a live Linux evidence collection script that gathers key artifacts important for Incident Response investigations. In addition to gathering artifacts AutoLLR does some low overhead post processing to produce refined results that analysts can look at immediately.

Results are divided into three (3) categories: 
1. System artifacts
- General system information including 
- Dumps all process ENVIRON data
- Collects bash histories
- SSH info
- and more 
    
2. Network artifacts 
- Different network connection pulls
 - Artifacts that record useful network information 
    
3. Triage searches
- Hidden files, directories, executables 
- Targeted directory checks
- Deleted binaries still running 
- Binaries running from temporary directories 
- Executables in interesting directories
- Assorted data spoliation searches 
- Assorted persistence searches 

Findings are hashed (MD5 SHA256) and archived upon completion.

