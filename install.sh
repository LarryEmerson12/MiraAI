#!/bin/bash

# Make mira.py executable
chmod +x mira.py

# Create ~/bin if it doesn't exist
mkdir -p ~/bin

# Copy mira.py and model.py to ~/bin
cp mira.py model.py ~/bin/

# Rename mira.py to mira (remove .py for CLI convenience)
mv ~/bin/mira.py ~/bin/mira

# Add ~/bin to PATH in .bashrc if not already present
if ! grep -q 'export PATH="$HOME/bin:$PATH"' ~/.bashrc; then
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
  echo "Added ~/bin to PATH in ~/.bashrc"
else
  echo "~/bin is already in your PATH"
fi

# Create config directory if missing
CONFIG_DIR="$HOME/.config/mira"
mkdir -p "$CONFIG_DIR"

# Create a seed memory.json with some smart knowledge if not exists
MEMORY_FILE="$CONFIG_DIR/memory.json"
if [ ! -f "$MEMORY_FILE" ]; then
  cat > "$MEMORY_FILE" << 'EOF'
{
  "name": null,
  "knowledge": {
    "what is the capital of france?": "The capital of France is Paris.",
    "who wrote hamlet?": "Hamlet was written by William Shakespeare.",
    "what is the speed of light?": "The speed of light is approximately 299,792 kilometers per second.",
    "who is albert einstein?": "Albert Einstein was a theoretical physicist famous for the theory of relativity.",
    "what is python?": "Python is a popular high-level programming language known for its readability and versatility.",
    "how many continents are there?": "There are seven continents: Asia, Africa, North America, South America, Antarctica, Europe, and Australia.",
    "what is mira?": "Mira is a lightweight Python CLI assistant that helps run commands and learn new information.",
    "who was the first president of the united states?": "George Washington was the first president of the United States.",
    "what is the boiling point of water?": "Water boils at 100 degrees Celsius or 212 degrees Fahrenheit at sea level.",
    "what is the largest ocean?": "The Pacific Ocean is the largest ocean on Earth.",
    "what is the atomic number of hydrogen?": "The atomic number of hydrogen is 1.",
    "what does cpu stand for?": "CPU stands for Central Processing Unit, the brain of a computer.",
    "what is the tallest mountain in the world?": "Mount Everest is the tallest mountain in the world, at 8,848 meters above sea level.",
    "who discovered penicillin?": "Alexander Fleming discovered penicillin in 1928.",
    "what is the currency of japan?": "The currency of Japan is the Japanese Yen (¥).",
    "what is photosynthesis?": "Photosynthesis is the process by which green plants convert sunlight into chemical energy.",
    "what is the formula for water?": "The chemical formula for water is H2O.",
    "what is the main language spoken in brazil?": "Portuguese is the main language spoken in Brazil.",
    "who painted the mona lisa?": "The Mona Lisa was painted by Leonardo da Vinci.",
    "what is the largest planet in our solar system?": "Jupiter is the largest planet in our solar system.",
    "what year did the world war ii end?": "World War II ended in 1945.",
    "what is the pythagorean theorem?": "In a right triangle, the square of the hypotenuse equals the sum of the squares of the other two sides (a² + b² = c²).",
    "what is the fastest land animal?": "The cheetah is the fastest land animal, capable of speeds up to 75 mph (120 km/h).",
    "what is the human body's largest organ?": "The skin is the largest organ of the human body.",
    "what is the meaning of life?": "Many philosophers debate this, but a common answer is to seek happiness, purpose, and connection.",
    "what is the formula for the area of a circle?": "The area of a circle is π times the radius squared (A = πr²).",
    "who invented the telephone?": "Alexander Graham Bell is credited with inventing the telephone.",
    "what is the speed of sound?": "The speed of sound is approximately 343 meters per second (1235 km/h) at sea level.",
    "what is the smallest country in the world?": "Vatican City is the smallest country in the world by both area and population.",
    "what is the primary gas in the earth's atmosphere?": "Nitrogen makes up about 78% of the Earth's atmosphere.",
    "what is the boiling point of ethanol?": "Ethanol boils at about 78.37 degrees Celsius (173.1 degrees Fahrenheit).",
    "what is machine learning?": "Machine learning is a branch of artificial intelligence where computers learn from data to make decisions.",
    "what is the tallest building in the world?": "The Burj Khalifa in Dubai is currently the tallest building in the world, at 828 meters.",
    "what is the first element on the periodic table?": "Hydrogen is the first element on the periodic table.",
    "what is the function of mitochondria?": "Mitochondria are the powerhouses of the cell, generating energy.",
    "what is a black hole?": "A black hole is a region in space where gravity is so strong that nothing, not even light, can escape.",
    "what is the capital of australia?": "Canberra is the capital of Australia.",
    "who wrote '1984'?": "'1984' was written by George Orwell.",
    "what is the formula for calculating force?": "Force is calculated as mass times acceleration (F = ma).",
    "what is the largest desert in the world?": "The Antarctic Desert is the largest desert by area.",
    "what is the basic unit of life?": "The cell is the basic unit of life.",
    "what year did man first land on the moon?": "Neil Armstrong and Buzz Aldrin landed on the moon in 1969.",
    "what is the main ingredient in bread?": "Flour is the main ingredient in bread.",
    "what is the function of DNA?": "DNA carries the genetic instructions used in growth, development, and reproduction.",
    "what is the capital of india?": "New Delhi is the capital of India.",
    "what does HTML stand for?": "HTML stands for HyperText Markup Language, used to create webpages.",
    "what is the internet?": "The internet is a global network of interconnected computers.",
    "who is the current president of the united states?": "As of 2025, Joe Biden is the President of the United States.",
    "what is an algorithm?": "An algorithm is a step-by-step procedure to solve a problem or perform a task.",
    "what is the tallest tree species?": "The tallest tree species is the coast redwood (Sequoia sempervirens), which can grow over 115 meters tall.",
    "who invented the light bulb?": "Thomas Edison is credited with inventing the practical incandescent light bulb.",
    "what is the currency of the united kingdom?": "The currency of the United Kingdom is the British Pound Sterling (£).",
    "what causes rainbows?": "Rainbows are caused by the refraction, dispersion, and reflection of light in water droplets.",
    "what is the largest mammal?": "The blue whale is the largest mammal, growing up to 30 meters long.",
    "what is the name of the longest river in the world?": "The Nile River is commonly considered the longest river in the world.",
    "what does HTTP stand for?": "HTTP stands for HyperText Transfer Protocol, the foundation of data communication for the web.",
    "who painted starry night?": "Starry Night was painted by Vincent van Gogh.",
    "what is the largest island in the world?": "Greenland is the largest island in the world.",
    "what is the process of cell division called?": "Cell division is called mitosis (for somatic cells) or meiosis (for reproductive cells).",
    "what is the freezing point of water?": "Water freezes at 0 degrees Celsius or 32 degrees Fahrenheit.",
    "who was the first person to propose the heliocentric theory?": "Nicolaus Copernicus proposed the heliocentric model where the Earth revolves around the Sun.",
    "what is quantum physics?": "Quantum physics studies the behavior of matter and energy at atomic and subatomic levels.",
    "what does USB stand for?": "USB stands for Universal Serial Bus, a standard for cables and connectors.",
    "what is the largest volcano on earth?": "Mauna Loa in Hawaii is the largest volcano on Earth.",
    "who wrote the declaration of independence?": "Thomas Jefferson is the principal author of the U.S. Declaration of Independence.",
    "what is a byte?": "A byte is a unit of digital information consisting of 8 bits.",
    "what is the tallest animal?": "The giraffe is the tallest land animal, with heights up to 5.5 meters.",
    "what is the fastest bird?": "The peregrine falcon is the fastest bird, reaching speeds over 240 mph during dives.",
    "what is the largest desert outside the poles?": "The Sahara Desert is the largest hot desert in the world.",
    "what is the capital of canada?": "Ottawa is the capital of Canada.",
    "who is known as the father of modern computers?": "Charles Babbage is considered the father of modern computers.",
    "what is the main ingredient in sushi?": "Rice is the main ingredient in sushi, often paired with raw fish or vegetables.",
    "what is the meaning of 'HTTP 404'?": "HTTP 404 means 'Not Found' — the requested webpage does not exist.",
    "who discovered gravity?": "Sir Isaac Newton formulated the law of universal gravitation.",
    "what is the most spoken language in the world?": "Mandarin Chinese is the most spoken language by number of native speakers.",
    "what is the chemical symbol for gold?": "The chemical symbol for gold is Au.",
    "what is the longest river in the united states?": "The Mississippi River is the longest river in the United States.",
    "what is the name of the galaxy we live in?": "We live in the Milky Way galaxy.",
    "what does AI stand for?": "AI stands for Artificial Intelligence.",
    "what is the tallest building in the usa?": "One World Trade Center in New York is the tallest building in the USA.",
    "what is the fastest car in the world?": "As of 2025, the Bugatti Chiron Super Sport 300+ is among the fastest cars, reaching speeds over 300 mph.",
    "what is the primary function of red blood cells?": "Red blood cells carry oxygen from the lungs to the rest of the body.",
    "who wrote the odyssey?": "The Odyssey is an ancient Greek epic poem attributed to Homer.",
    "what is the chemical formula for table salt?": "Table salt's chemical formula is NaCl (sodium chloride).",
    "what is the name of the first artificial satellite?": "Sputnik 1 was the first artificial satellite launched by the Soviet Union in 1957.",
    "what is the main purpose of the united nations?": "The United Nations aims to promote peace, security, and cooperation among countries.",
    "what is the largest moon of saturn?": "Titan is the largest moon of Saturn.",
    "what is the average distance between the earth and the sun?": "The average distance is about 149.6 million kilometers (93 million miles).",
    "what is the tallest waterfall in the world?": "Angel Falls in Venezuela is the tallest waterfall, with a height of 979 meters.",
    "what is the currency of russia?": "The currency of Russia is the Russian Ruble (₽).",
    "what is the function of the heart?": "The heart pumps blood throughout the body, supplying oxygen and nutrients.",
    "what is the capital of egypt?": "Cairo is the capital of Egypt.",
    "who was the first woman to win a nobel prize?": "Marie Curie was the first woman to win a Nobel Prize, and she won twice!",
    "what is the square root of 64?": "The square root of 64 is 8.",
    "what is the largest rainforest in the world?": "The Amazon rainforest is the largest tropical rainforest in the world.",
    "what is the tallest mountain in africa?": "Mount Kilimanjaro is the tallest mountain in Africa.",
    "what is the main language spoken in argentina?": "Spanish is the main language spoken in Argentina.",
    "what is the function of the liver?": "The liver processes nutrients and detoxifies harmful substances in the body.",
    "who is the author of 'to kill a mockingbird'?": "Harper Lee wrote 'To Kill a Mockingbird'.",
    "what is the boiling point of mercury?": "Mercury boils at 356.7 degrees Celsius (674.1 degrees Fahrenheit).",
    "what is the largest city in the world by population?": "Tokyo, Japan is the largest city by population.",
    "what is the name of the first computer programmer?": "Ada Lovelace is considered the first computer programmer.",
    "what is the main gas in the sun?": "The Sun is mostly made of hydrogen and helium gases.",
    "what is the capital of south korea?": "Seoul is the capital of South Korea.",
    "what does GPU stand for?": "GPU stands for Graphics Processing Unit, used mainly for rendering images and videos.",
    "what is the primary ingredient in chocolate?": "Cocoa beans are the primary ingredient in chocolate.",
    "what is the smallest bone in the human body?": "The stapes bone in the ear is the smallest bone in the human body.",
    "what is the largest organ inside the human body?": "The liver is the largest internal organ.",
    "who developed the theory of evolution?": "Charles Darwin developed the theory of evolution by natural selection.",
    "what is the name of the largest coral reef system?": "The Great Barrier Reef in Australia is the largest coral reef system.",
    "what is the capital of germany?": "Berlin is the capital of Germany.",
    "what is the name of shakespeare's famous play about two star-crossed lovers?": "Romeo and Juliet.",
    "what is the currency of canada?": "The currency of Canada is the Canadian Dollar (CAD).",
    "what is the name of the famous clock tower in london?": "Big Ben is the nickname of the Great Bell in the Elizabeth Tower at the Palace of Westminster.",
    "what is the freezing point of ethanol?": "Ethanol freezes at about -114 degrees Celsius (-173 degrees Fahrenheit).",
    "what is the human body's largest muscle?": "The gluteus maximus is the largest muscle in the human body.",
    "what is the capital of mexico?": "Mexico City is the capital of Mexico.",
    "what is the name of the first programmable electronic computer?": "The ENIAC was one of the earliest programmable electronic computers.",
    "what is the main function of the kidneys?": "The kidneys filter waste products from the blood to produce urine.",
    "who discovered electricity?": "Electricity was studied by many, but Benjamin Franklin and Michael Faraday made key contributions.",
    "what is the name of the famous French tower?": "The Eiffel Tower in Paris.",
    "what is the largest species of shark?": "The whale shark is the largest species of shark.",
    "what is the function of chlorophyll?": "Chlorophyll allows plants to absorb sunlight for photosynthesis.",
    "what is the capital of italy?": "Rome is the capital of Italy.",
    "who was the first man in space?": "Yuri Gagarin was the first human to travel into space.",
    "what is the unit of electrical resistance?": "Ohm (Ω) is the unit of electrical resistance.",
    "what is the name of the first artificial intelligence program?": "The Logic Theorist, created in 1956, is considered the first AI program.",
    "what is the name of the device used to measure earthquakes?": "A seismometer or seismograph.",
    "what is the largest lake in the world?": "The Caspian Sea is the largest enclosed inland body of water (lake).",
    "who was the first female prime minister of the united kingdom?": "Margaret Thatcher.",
    "what is the main language spoken in russia?": "Russian is the official language of Russia.",
    "what is the tallest building in europe?": "Lakhta Center in Saint Petersburg, Russia.",
    "what is the currency of china?": "The currency of China is the Renminbi (Yuan, ¥).",
    "what is the name of the biggest planet's largest moon?": "Ganymede, the largest moon of Jupiter.",
    "what is the freezing point of carbon dioxide?": "Carbon dioxide sublimates (goes from solid to gas) at −78.5 °C under normal pressure.",
    "what is the capital of spain?": "Madrid is the capital of Spain.",
    "what is the speed of light in miles per second?": "Approximately 186,282 miles per second.",
    "who is considered the father of psychology?": "Wilhelm Wundt is often called the father of psychology.",
    "what is the largest species of bird?": "The ostrich is the largest bird species.",
    "what is the most abundant element in the universe?": "Hydrogen is the most abundant element in the universe.",
    "what is the capital of new zealand?": "Wellington is the capital of New Zealand.",
    "what is the name of the famous wizard school in the Harry Potter series?": "Hogwarts School of Witchcraft and Wizardry.",
    "what is the chemical symbol for oxygen?": "O.",
    "what is the name of the first successful polio vaccine developer?": "Jonas Salk.",
    "what is the average lifespan of a human?": "Around 72 to 79 years globally, depending on various factors.",
    "what is the name of the famous spacecraft that carried humans to the moon?": "Apollo spacecraft.",
    "what is the chemical symbol for iron?": "Fe.",
    "what is the distance from the earth to the moon?": "About 384,400 kilometers (238,855 miles).",
    "what is the capital of france?": "Paris."
  }
}
EOF
  echo "Seeded $MEMORY_FILE with knowledge."
else
  echo "$MEMORY_FILE already exists."
fi

echo "Installation complete! You can now run 'mira' from anywhere."
