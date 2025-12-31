import json
import re
from pathlib import Path

CONFIG_DIR = Path.home() / ".config" / "mira"
MEMORY_FILE = CONFIG_DIR / "memory.json"

class MiraModel:
    def __init__(self):
        self.memory = self.load_memory()

    def load_memory(self):
        if MEMORY_FILE.exists():
            try:
                return json.loads(MEMORY_FILE.read_text())
            except Exception:
                pass
        # Default memory structure
        return {
            "name": None,
            "knowledge": {}
        }

    def save_memory(self):
        CONFIG_DIR.mkdir(parents=True, exist_ok=True)
        MEMORY_FILE.write_text(json.dumps(self.memory, indent=2))

    def normalize(self, text):
        # Lowercase, strip whitespace, remove punctuation like ?, ., !
        text = text.lower().strip()
        text = re.sub(r'[?.!]', '', text)
        return text

    def get_response(self, prompt):
        prompt_norm = self.normalize(prompt)

        # Search knowledge with normalized keys
        for question, answer in self.memory["knowledge"].items():
            if self.normalize(question) == prompt_norm:
                return answer

        # Basic greetings
        if prompt_norm in ("hi", "hello", "hey"):
            return "Hello 🌕"

        return "I don't know that yet. Teach me with 'ai train question|answer'!"