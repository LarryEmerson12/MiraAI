import json
import re
import difflib
from pathlib import Path

CONFIG_DIR = Path.home() / ".config" / "mira"
MEMORY_FILE = CONFIG_DIR / "memory.json"

def normalize(text):
    text = text.lower()
    text = re.sub(r"[^\w\s]", "", text)  # remove punctuation
    text = re.sub(r"\s+", " ", text).strip()
    return text

def fuzzy_lookup(prompt, knowledge, cutoff=0.75):
    matches = difflib.get_close_matches(
        prompt,
        knowledge.keys(),
        n=1,
        cutoff=cutoff
    )
    return matches[0] if matches else None

class MiraModel:
    def __init__(self):
        self.memory = self.load_memory()

        # Normalize all knowledge keys for faster lookup
        normalized_knowledge = {}
        for k, v in self.memory.get("knowledge", {}).items():
            nk = normalize(k)
            normalized_knowledge[nk] = v
        self.memory["knowledge"] = normalized_knowledge

    def load_memory(self):
        if MEMORY_FILE.exists():
            try:
                return json.loads(MEMORY_FILE.read_text())
            except Exception:
                pass
        return {
            "name": None,
            "knowledge": {}
        }

    def save_memory(self):
        CONFIG_DIR.mkdir(parents=True, exist_ok=True)
        MEMORY_FILE.write_text(json.dumps(self.memory, indent=2))

    def get_response(self, prompt):
        prompt_norm = normalize(prompt)

        if prompt_norm in self.memory["knowledge"]:
            return self.memory["knowledge"][prompt_norm]

        close = fuzzy_lookup(prompt_norm, self.memory["knowledge"])
        if close:
            return self.memory["knowledge"][close]

        if prompt_norm in ("hi", "hello", "hey"):
            return "Hello 🌕"

        return "I don't know that yet 🌕 You can teach me with 'ai train question|answer'!"
