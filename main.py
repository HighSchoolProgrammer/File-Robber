import os
import subprocess
import json
import shutil
from tqdm import tqdm
from colorama import Fore, Back, Style

print("Setting up...")

# Define Variables
scriptdir = os.path.dirname(os.path.abspath(__file__))
output = subprocess.check_output('wmic os get csname /value', shell=True)
computername = output.decode().split('=')[1].split('.')[0]
outputfolder = 'output'

# Parse config.json
with open('config.json') as config_raw:
    config = json.load(config_raw)

# ---
# Define Functions
def clear():
    os.system('cls' if os.name == 'nt' else 'clear')

def copy_files_to_output_folder(source_folder, output_folder):
    # Calculate the total number of files and sub-folders in the source folder
    total_count = 0
    for root, dirs, files in os.walk(source_folder):
        total_count += len(dirs) + len(files)

    # Initialize the progress bar
    progress_bar = tqdm(total=total_count, unit='item')

    # Copy each file and sub-folder one by one
    for root, dirs, files in os.walk(source_folder):
        for file in files:
            source_path = os.path.join(root, file)
            destination_path = os.path.join(output_folder, source_folder, file)
            os.makedirs(os.path.dirname(destination_path), exist_ok=True)
            shutil.copy2(source_path, destination_path)
            progress_bar.update(1)

        for dir in dirs:
            source_path = os.path.join(root, dir)
            destination_path = os.path.join(output_folder, source_folder, dir)
            os.makedirs(destination_path, exist_ok=True)
            progress_bar.update(1)

    # Close the progress bar
    progress_bar.close()

# ---

clear()

print(Fore.BLUE + "--------------------------------------------------------------------")
print(Fore.CYAN + "--------------------------------------------------------------------")
print("")

if config["version-type"] == "BETA":
    print(Fore.WHITE + config["name"] + Fore.CYAN + " V" + config["version"] + " " + config["version-type"])
elif config["version-type"] == "DEVELOPMENT":
    print(Fore.WHITE + config["name"] + Fore.YELLOW + " V" + config["version"] + " " + config["version-type"])
elif config["version-type"] == "STABLE":
    print(Fore.WHITE + config["name"] + Fore.GREEN + " V" + config["version"] + " " + config["version-type"])

print("")
print(Fore.WHITE + "Created by " + Fore.GREEN + config["author"] + Fore.WHITE + " on " + Fore.GREEN + "GitHub" + Fore.WHITE)
print(Fore.LIGHTMAGENTA_EX + "https://github.com/HighSchoolProgrammer/File-Robber")
print("")
print(Fore.WHITE + "This program is licensed under " + Fore.GREEN + config["license"])
print("")
print(Fore.CYAN + "--------------------------------------------------------------------")
print(Fore.BLUE + "--------------------------------------------------------------------")

input(Fore.CYAN + "Press Enter to continue...")