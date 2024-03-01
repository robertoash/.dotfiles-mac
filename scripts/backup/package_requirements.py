#!/usr/bin/env python3

import subprocess
import sys

SEPARATOR = "///"

package_managers = {
    "brew-tap": ("brew tap", "brew tap"),
    "brew": ("brew leaves", "brew install"),
    "brew-cask": ("brew list --cask", "brew install --cask"),
    "pipx": ("pipx list --short", "pipx install")
}

def save_packages(filename):
    with open(filename, 'w') as f:
        # Iterate through package managers and save packages
        for manager, commands in package_managers.items():
            list_command = commands[0].split()
            packages = subprocess.check_output(list_command).decode().splitlines()
            for package in packages:
                f.write(f"{package}{SEPARATOR}{manager}\n")

def reinstall_packages(filename):
    lines = []
    with open(filename) as f:
        lines = f.readlines()

    # Sort lines to prioritize taps
    lines.sort(key=lambda line: (0, line) if line.strip().endswith("brew-tap") else (1, line))

    for line in lines:
        package, manager = line.strip().split(SEPARATOR)
        if manager in package_managers:
            install_command = package_managers[manager][1].split() + [package]
            subprocess.run(install_command)

if __name__ == "__main__":
    if len(sys.argv) == 3:
        action = sys.argv[1]
        filename = sys.argv[2]
    else:
        print("Usage:")
        print("./package_requirements.py -s <filename> (to save packages)")
        print("./package_requirements.py -r <filename> (to reinstall packages)")
        sys.exit(1)

    if action == '-s':
        save_packages(filename)
        print(f"Packages saved to {filename}")
    elif action == '-r':
        reinstall_packages(filename)
        print(f"Packages reinstalled from {filename}")
    else:
        print("Invalid choice. Exiting.")
