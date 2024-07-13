import os
import subprocess
import json
import shutil
from tqdm import tqdm
from colorama import Fore, Back, Style

# Get the current directory of the script
scriptdir = os.path.dirname(os.path.abspath(__file__))

# Get the computer name
output = subprocess.check_output('wmic os get csname /value', shell=True)
computername = output.decode().split('=')[1].split('.')[0]

# Create the folder name with computer name
outputfolder = 'output'

print("scriptdir:", scriptdir)
print("computername:", computername)
print("outputfolder:", outputfolder)

# --

# Read the config.json file
with open('config.json') as config_raw:
    config = json.load(config_raw)

# Extract the data from the config_data dictionary
name = config['name']
version = config['version']
author = config['author']

# Use the variables as needed
print("name:", name)
print("version:", version)
print("author:", author)

# Print functions with different colors
print(Fore.RED + "This is a red message")
print(Fore.GREEN + "This is a green message")
print(Fore.BLUE + "This is a blue message")
print(Fore.YELLOW + "This is a yellow message")
print(Fore.MAGENTA + "This is a magenta message")
print(Fore.CYAN + "This is a cyan message")
print(Fore.WHITE + "This is a white message")

# --
# Calculate the total number of files and sub-folders in the folder
total_count = 0
for root, dirs, files in os.walk(os.path.join(os.path.expanduser("~"), "Downloads")):
    total_count += len(dirs) + len(files)

# Initialize the progress bar
progress_bar = tqdm(total=total_count, unit='item')

# Copy each file and sub-folder one by one
for root, dirs, files in os.walk(os.path.join(os.path.expanduser("~"), "Downloads")):
    for file in files:
        source_path = os.path.join(root, file)
        destination_path = os.path.join(outputfolder, root.replace(os.path.join(os.path.expanduser("~"), "Downloads"), ''), file)
        os.makedirs(os.path.dirname(destination_path), exist_ok=True)
        shutil.copy2(source_path, destination_path)
        progress_bar.update(1)

    for dir in dirs:
        source_path = os.path.join(root, dir)
        destination_path = os.path.join(outputfolder, root.replace(os.path.join(os.path.expanduser("~"), "Downloads"), ''), dir)
        os.makedirs(destination_path, exist_ok=True)
        progress_bar.update(1)

# Close the progress bar
progress_bar.close()

#---

input("Press Enter to continue...")