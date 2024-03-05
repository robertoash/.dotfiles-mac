#!/usr/bin/env python3

import os
import subprocess
import sys
from textwrap import dedent

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

def print_help():
    help_text = dedent(
        """
        Usage:

          ./package_requirements.py -s <filename> | --save <filename>
            To save the current list of packages to a file.

          ./package_requirements.py -r <filename> | --restore <filename> | --reinstall <filename>
            To reinstall packages from a file.

          If no filename is provided, 'all_packages.txt' will be used as a file name and it
          will be saved to the path set by XDG_CONFIG_HOME. If XDG_CONFIG_HOME is not set,
          the file will be saved to '~/.config/'.

        Options:
          -s, --save        Save the current list of packages to a file.
          -r, --restore     Reinstall packages from a file (alias: --reinstall).
          --help            Show this help message and exit.
    """
    )
    print(help_text)


def is_valid_path(path):
    # Additional logic can be added here to validate path further
    return os.path.exists(path) or not os.path.isabs(path)


if __name__ == "__main__":
    args = sys.argv[1:]

    if "--help" in args:
        print_help()
        sys.exit(1)

    action_map = {
        "-s": "save",
        "--save": "save",
        "-r": "restore",
        "--restore": "restore",
        "--reinstall": "restore",
    }
    action = None
    filename = None

    for arg in args:
        if arg.startswith("-") and len(arg) == 2 or arg in action_map:
            action = action_map.get(arg, None)
        elif is_valid_path(arg):
            filename = arg
        elif arg in action_map:
            action = action_map[arg]

    if action is None:
        print_help()
        sys.exit(1)

    if filename is None:
        filename = os.path.join(
            os.environ.get("XDG_CONFIG_HOME", os.path.expanduser("~/.config")),
            "all_packages.txt",
        )

    if action == "save":
        save_packages(filename)
        print(f"Packages saved to {filename}")
    elif action == "restore":
        reinstall_packages(filename)
        print(f"Packages reinstalled from {filename}")
    else:
        print("Invalid choice. Exiting.")
