#!/usr/bin/env python3
import sys
import os

# ---------- UTF-8 FIX (Windows + Linux) ----------
try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

# ---------- Ensure model.py is importable ----------
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
if SCRIPT_DIR not in sys.path:
    sys.path.insert(0, SCRIPT_DIR)

from termcolor import colored
from rich.console import Console
import subprocess
from model import MiraModel

VERSION = "1.0.2"
BOX_WIDTH = 54
console = Console()

def fit_text(text, max_len):
    if len(text) > max_len:
        return text[:max_len - 3] + "..."
    return text

def print_ui(name):
    name = fit_text(name, BOX_WIDTH - len("Welcome back, !"))
    welcome = f"Welcome back, {name}!".center(BOX_WIDTH)

    print(colored(f"╭------------------- Mira AI v{VERSION} -------------------╮", "light_cyan"))
    print(colored("|" + " " * BOX_WIDTH + "|", "light_cyan"))
    print(colored(f"|{welcome}|", "light_cyan"))
    print(colored("|" + " " * BOX_WIDTH + "|", "light_cyan"))

    # Alien pixel art
    print(colored("|                   ", "light_cyan") + "  " +
          colored(" " * 12, None, "on_light_cyan") + "  " +
          colored("                   |", "light_cyan"))

    print(colored("|                   ", "light_cyan") + "  " +
          colored("  ", None, "on_light_cyan") + " " +
          colored(" " * 6, None, "on_light_cyan") + " " +
          colored("  ", None, "on_light_cyan") + "  " +
          colored("                   |", "light_cyan"))

    print(colored("|                   ", "light_cyan") +
          colored(" " * 16, None, "on_light_cyan") +
          colored("                   |", "light_cyan"))

    print(colored("|                   ", "light_cyan") + "  " +
          colored(" " * 12, None, "on_light_cyan") + "  " +
          colored("                   |", "light_cyan"))

    print(colored("|                   ", "light_cyan") + "   " +
          colored(" ", None, "on_light_cyan") + " " +
          colored(" ", None, "on_light_cyan") + "    " +
          colored(" ", None, "on_light_cyan") + " " +
          colored(" ", None, "on_light_cyan") + "   " +
          colored("                   |", "light_cyan"))

    print(colored("|" + " " * BOX_WIDTH + "|", "light_cyan"))
    print(colored("╰------------------------------------------------------╯", "light_cyan"))
    print("\n--------------------------------------------------------\n")

def main():
    model = MiraModel()

    if not model.memory.get("name"):
        model.memory["name"] = input("What's your name? ").strip() or "there"
        model.save_memory()

    print_ui(model.memory["name"])

    while True:
        console.print("🌕 Type a command or `ai help`", style="dim")
        command = input("🌕 > ").strip()

        if not command:
            continue

        if command == "miraexit":
            console.print("Goodbye 🌕", style="cyan")
            break

        if command.startswith("ai "):
            ai_command = command[3:].strip()

            if ai_command == "help":
                console.print(
                    "[cyan]AI commands:\n"
                    " - ai greet\n"
                    " - ai help\n"
                    " - ai train question|answer[/cyan]"
                )
                continue

            elif ai_command == "greet":
                console.print("[cyan]Hello! How can I assist you today?[/cyan]")
                continue

            elif ai_command.startswith("train "):
                try:
                    _, qa = ai_command.split(" ", 1)
                    question, answer = qa.split("|", 1)
                    model.train(question, answer)
                    console.print(f"[green]Trained! I learned: '{question.strip()}'[/green]")
                except Exception:
                    console.print("[red]Usage: ai train question|answer[/red]")
                continue

            else:
                response = model.get_response(ai_command)
                console.print(f"[cyan]Mira AI:[/cyan] {response}")
                continue

        subprocess.run(command, shell=True)

if __name__ == "__main__":
    main()
