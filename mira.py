#!/usr/bin/env python3

import os
import subprocess
from termcolor import colored
from rich.console import Console
from model import MiraModel  # Your AI model class

VERSION = "1.0.5"
BOX_WIDTH = 54
console = Console()

def fit_text(text, max_len):
    if len(text) > max_len:
        return text[:max_len - 3] + "..."
    return text

def print_ui(name):
    name = fit_text(name, BOX_WIDTH - len("Welcome back, !"))
    welcome = f"Welcome back, {name}!".center(BOX_WIDTH)

    print(colored(f"\u256d------------------- Mira AI v{VERSION} -------------------\u256e", 'light_cyan'))
    print(colored("|" + " " * BOX_WIDTH + "|", 'light_cyan'))
    print(colored(f"|{welcome}|", 'light_cyan'))
    print(colored("|" + " " * BOX_WIDTH + "|", 'light_cyan'))

    # Alien pixel art
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
    print(colored("\u2570" + "-" * (BOX_WIDTH + 2) + "\u256f", 'light_cyan'))
    print()
    print("-" * 56)
    print()

def main():
    model = MiraModel()

    if not model.memory.get("name"):
        model.memory["name"] = input("What's your name? ").strip() or "there"
        model.save_memory()

    print_ui(model.memory["name"])

    current_dir = os.getcwd()

    while True:
        console.print("🌕 Type a command or `ai help`", style="dim")
        command = input("🌕 > ").strip()

        if not command:
            continue

        if command == "miraexit":
            console.print("Goodbye 🌕", style="cyan")
            break

        # Handle ai commands
        if command.startswith("ai "):
            ai_command = command[3:].strip()

            if ai_command == "help":
                console.print("[cyan]AI commands:\n - ai greet\n - ai help\n - ai train question|answer[/cyan]")
                continue

            elif ai_command == "greet":
                console.print("[cyan]Hello! How can I assist you today?[/cyan]")
                continue

            elif ai_command.startswith("train "):
                try:
                    _, qa = ai_command.split(" ", 1)
                    question, answer = qa.split("|", 1)
                    question = question.strip().lower()
                    answer = answer.strip()
                    normalized_question = question  # We'll keep keys normalized in model.py init
                    model.memory["knowledge"][normalized_question] = answer
                    model.save_memory()
                    console.print(f"[green]Trained! I now know the answer to: '{normalized_question}'[/green]")
                except Exception:
                    console.print("[red]Usage: ai train question|answer[/red]")
                continue

            else:
                response = model.get_response(ai_command)
                console.print(f"[cyan]Mira AI:[/cyan] {response}")
                continue

        # Handle cd separately to persist current_dir
        if command.startswith("cd "):
            path = command[3:].strip()
            try:
                new_dir = os.path.abspath(os.path.join(current_dir, path))
                os.chdir(new_dir)
                current_dir = new_dir
            except Exception as e:
                console.print(f"[red]cd failed:[/red] {e}")
            continue

        # Run any other shell command in current_dir
        try:
            subprocess.run(command, shell=True, cwd=current_dir)
        except Exception as e:
            console.print(f"[red]Command failed:[/red] {e}")

if __name__ == "__main__":
    main()
