import os

directory = "E:\IR-Flash-main\IR-Dump"
files = os.listdir(directory)
user_input = input("Press 1: ")
bat_file_map = {
    "1": "IR-dump.bat",  
    # ...
}
if user_input in bat_file_map:
  
    file_name = bat_file_map[user_input]
    file_path = os.path.join(directory, file_name)
    print("Running:", file_path)
    os.system(file_path)  
else:
    print("Invalid choice.")
