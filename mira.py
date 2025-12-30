#!/usr/bin/env python3

from termcolor import colored
import subprocess
import json
from pathlib import Path

VERSION = "1.0.1"
BOX_WIDTH = 54

CONFIG_DIR = Path.home() / ".config" / "mira"
CONFIG_FILE = CONFIG_DIR / "config.json"


def load_name():
    if CONFIG_FILE.exists():
        try:
            with open(CONFIG_FILE, "r") as f:
                return json.load(f).get("name")
        except Exception:
            return None
    return None


def save_name(name):
    CONFIG_DIR.mkdir(parents=True, exist_ok=True)
    with open(CONFIG_FILE, "w") as f:
        json.dump({"name": name}, f)


def print_ui(name):
    welcome = f"Welcome back, {name}!".center(BOX_WIDTH)

    print(colored(f"╭------------------- Mira AI v{VERSION} -------------------╮", 'light_cyan'))
    print(colored("|" + " " * BOX_WIDTH + "|", 'light_cyan'))
    print(colored(f"|{welcome}|", 'light_cyan'))
    print(colored("|" + " " * BOX_WIDTH + "|", 'light_cyan'))

    # Alien
    print(colored("|                   ", 'light_cyan') + "  " +
          colored(" " * 12, None, 'on_light_cyan') + "  " +
          colored("                   |", 'light_cyan'))

    print(colored("|                   ", 'light_cyan') + "  " +
          colored("  ", None, 'on_light_cyan') + " " +
          colored(" " * 6, None, 'on_light_cyan') + " " +
          colored("  ", None, 'on_light_cyan') + "  " +
          colored("                   |", 'light_cyan'))

    print(colored("|                   ", 'light_cyan') +
          colored(" " * 16, None, 'on_light_cyan') +
          colored("                   |", 'light_cyan'))

    print(colored("|                   ", 'light_cyan') + "  " +
          colored(" " * 12, None, 'on_light_cyan') + "  " +
          colored("                   |", 'light_cyan'))

    print(colored("|                   ", 'light_cyan') + "   " +
          colored(" ", None, 'on_light_cyan') + " " +
          colored(" ", None, 'on_light_cyan') + "    " +
          colored(" ", None, 'on_light_cyan') + " " +
          colored(" ", None, 'on_light_cyan') + "   " +
          colored("                   |", 'light_cyan'))

    print(colored("|" + " " * BOX_WIDTH + "|", 'light_cyan'))
    print(colored("╰------------------------------------------------------╯", 'light_cyan'))
    print()
    print("--------------------------------------------------------")
    print()


def main():
    print()

    name = load_name()
    if not name:
        name = input("What's your name? ").strip() or "there"
        name = name[:30]
        save_name(name)

    print_ui(name)

    print(colored("Type 'miraexit' to quit!", 'light_red'))
    print(colored("Type 'ai help' for help!", 'light_cyan'))
    print()

    while True:
        print(colored("🌕 Type a command or `ai help`", 'dark_grey'))
        print(colored("🌕 > ", 'green'), end="")
        commands = input()

        if commands.strip().lower() == 'miraexit':
            print(colored("Exiting Mira AI. Goodbye!", 'red'))
            break

        if not commands.strip():
            continue

        if commands.startswith("ai"):
            ai_command = commands[2:].strip()

            if ai_command == "greet":
                print(colored("Hello! How can I assist you today?", 'light_cyan'))

            elif ai_command == "help":
                print(colored(
                    "Available AI commands:\n"
                    " - ai greet\n"
                    " - ai help\n"
                    " - miraexit",
                    'light_cyan'
                ))

            else:
                print(colored(f"Unknown AI command: {ai_command}", 'yellow'))

        else:
            result = subprocess.run(commands, shell=True)
            if result.returncode != 0:
                print(colored(
                    f"Command failed with exit code {result.returncode}",
                    'red'
                ))


if __name__ == "__main__":
    main()
