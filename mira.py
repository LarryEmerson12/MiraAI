#!/usr/bin/env python3

import json
import subprocess
from pathlib import Path
from termcolor import colored
from rich.console import Console

# =========================
# Paths & Memory
# =========================

VERSION = "1.0.1"
BOX_WIDTH = 54

CONFIG_DIR = Path.home() / ".config" / "mira"
MEMORY_FILE = CONFIG_DIR / "memory.json"

console = Console()

def load_memory():
    if MEMORY_FILE.exists():
        try:
            return json.loads(MEMORY_FILE.read_text())
        except Exception:
            pass
    return {
        "name": None,
        "knowledge": {}
    }

def save_memory(memory):
    CONFIG_DIR.mkdir(parents=True, exist_ok=True)
    MEMORY_FILE.write_text(json.dumps(memory, indent=2))

# =========================
# UI Helpers
# =========================

def fit_text(text, width):
    """Trim text so it always fits inside the box."""
    if len(text) > width:
        return text[: width - 1] + "…"
    return text

def print_ui(name):
    name = fit_text(name, BOX_WIDTH - len("Welcome back, !"))
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

# =========================
# Mira AI Logic
# =========================

def mira_ai(prompt, memory):
    prompt = prompt.lower().strip()

    # Built-in commands
    if prompt == "help":
        return (
            "AI commands:\n"
            "  ai help   - show this message\n"
            "  ai greet  - say hello\n\n"
            "I can also learn from you 🌕"
        )

    if prompt == "greet":
        return "Hello 🌕 How can I help?"

    # Learned knowledge
    if prompt in memory["knowledge"]:
        return memory["knowledge"][prompt]

    console.print("[yellow]I don't know that yet.[/yellow]")
    answer = input("Teach me: ").strip()

    if answer:
        memory["knowledge"][prompt] = answer
        save_memory(memory)
        return "Got it! I'll remember that 🌕"

    return "Alright."

# =========================
# Main
# =========================

def main():
    memory = load_memory()

    if not memory.get("name"):
        name = input("What's your name? ").strip()
        memory["name"] = name if name else "Friend"
        save_memory(memory)

    print_ui(memory["name"])
    print(colored("Type `miraexit` to exit.", 'light_red'))

    while True:
        print(colored("🌕 Type a command or `ai help`", 'dark_grey'))
        command = input("🌕 > ").strip()

        if not command:
            continue

        if command.lower() == "miraexit":
            console.print("Goodbye 🌕", style="cyan")
            break

        if command.startswith("ai "):
            response = mira_ai(command[3:], memory)
            console.print(f"[cyan]Mira AI:[/cyan] {response}")
            continue

        subprocess.run(command, shell=True)

if __name__ == "__main__":
    main()
