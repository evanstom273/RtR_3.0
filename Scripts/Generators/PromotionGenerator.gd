@tool
extends EditorScript

const MODE = "GENERATE" # Options: "GENERATE", "RESET"

const PROMOTION_PATH = "res://Promotions/"
const WRESTLER_PATH = "res://Wrestlers/"
const TITLE_PATH = "res://Titles/"

# --- COUNTRY SPECIFIC NAME DATABASES ---

# North America
var names_na_usa = [
    "Global Wrestling Federation", "American Wrestling League", "New York Strong Style", 
    "Hollywood Championship Wrestling", "Texas Brawler Association", "Mid-South Combat", 
    "Chicago City Wrestling", "Las Vegas Pro", "Florida Championship Wrestling"
]
var names_na_canada = [
    "Canadian Stampede Wrestling", "Maple Leaf Pro", "Calgary Dungeon Wrestling",
    "Great North Wrestling", "Vancouver Island Pro"
]
var names_na_mexico = [
    "Lucha Libre Mexico", "Campeonato de Luchadores", "Guerra de Titanes", 
    "Sangre y Honor Lucha", "Tijuana Hardcore Wrestling", "Estrellas del Ring", "Aztec Pro"
]

# Latin America
var names_la_brazil = [
    "Brazilian Jiu Jitsu Pro", "Rio Rumble Wrestling", "Amazon Combat League"
]
var names_la_argentina = [
    "Buenos Aires Brawl", "Catch Argentino", "Pampas Pro Wrestling"
]
var names_la_chile = [
    "Santiago Strong Style", "Andes Championship Wrestling", "Chilean Lucha"
]

# Europe
var names_eu_england = [
    "British Wrestling Alliance", "Royal Kingdom Wrestling", "London Lucha League",
    "Manchester Pro", "Yorkshire Strong Style", "English Heavyweight League"
]
var names_eu_scotland = [
    "Highland Pro", "Glasgow Pro", "Scottish Championship Wrestling", 
    "Edinburgh Combat", "Braveheart Wrestling"
]
var names_eu_wales = [
    "Dragon Pro Wrestling", "Welsh Warrior Wrestling", "Cardiff Combat",
	"Valley Brawl Association"
]
var names_eu_ireland = [
    "Celtic Combat", "Dublin Fight Club", "Emerald Isle Wrestling",
    "Shamrock Style", "Belfast Brawl"
]
var names_eu_france = [
    "Catch Francais", "Paris Pro Wrestling", "Ligue Nationale de Catch"
]
var names_eu_germany = [
    "Catch Wrestling Germany", "Berlin Pro", "Hamburg Harbor Wrestling", "Oberhausen Combat"
]
var names_eu_italy = [
    "Italian Championship Wrestling", "Rome Gladiator Pro", "Milano Style Wrestling"
]
var names_eu_spain = [
    "Lucha Libre Barcelona", "Madrid Matadors", "Spanish Fly Wrestling"
]

# Asia
var names_asia_japan = [
    "Tokyo Pro", "Rising Sun Wrestling", "Dragon Gate Combat", 
    "Fighting Spirit Puroresu", "All Asia Championship", "King's Road Association", "Strong Style Japan"
]
var names_asia_china = [
    "Shanghai Pro", "Great Wall Wrestling", "Dragon Dynasty Combat"
]
var names_asia_india = [
    "Ring Ka King Style", "Mumbai Mat War", "Indian Heavyweight League"
]
var names_asia_korea = [
    "Seoul City Wrestling", "Korean Pro Wrestling", "DMZ Hardcore"
]

# Africa
var names_africa_nigeria = [
    "Lagos Lucha", "Nigerian Pro Wrestling", "African Powerhouse League", "Eagle Combat"
]
var names_africa_south_africa = [
    "Cape Town Pro", "Safari Championship Wrestling", "Johannesburg Combat", "Lion's Den Wrestling"
]
var names_africa_ghana = [
    "Gold Coast Wrestling", "Accra All-Stars", "Black Star Wrestling"
]

# Oceania
var names_oceania_australia = [
    "Outback Pro Wrestling", "Sydney Slam", "Southern Cross Combat", "Melbourne Mat War"
]
var names_oceania_new_zealand = [
    "Kiwi Strong Style", "Auckland All-Star", "Haka Wrestling", "Silver Fern Pro"
]
var names_oceania_samoa = [
    "Samoan Dynasty Wrestling", "Island Warfare", "Pacific Pro", "Apia Combat"
]

var used_names = []
