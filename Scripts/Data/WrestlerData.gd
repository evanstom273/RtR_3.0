@tool
extends Resource
class_name WrestlerResource

enum Region { NORTH_AMERICA, LATIN_AMERICA, EUROPE, ASIA, AFRICA, OCEANIA }
enum CountryNorthAmerica { USA, CANADA, MEXICO }
enum CountryLatinAmerica { BRAZIL, ARGENTINA, CHILE }
enum CountryEurope { ENGLAND, SCOTLAND, FRANCE, GERMANY, IRELAND, ITALY, SPAIN, WALES }
enum CountryAsia { JAPAN, CHINA, INDIA, SOUTH_KOREA }
enum CountryAfrica { NIGERIA, SOUTH_AFRICA, GHANA }
enum CountryOceania { NEW_ZEALAND, AUSTRALIA, SAMOA }

enum CharacterClass { POWERHOUSE, HIGH_FLYER, TECHNICIAN, BRAWLER, STRIKER }
enum CharacterGender { MALE, FEMALE }
enum CharacterDivision { MAIN_EVENT, SINGLES, WOMENS }
enum CharacterDisposition {FACE, HEEL }
enum CharacterStats { STRENGTH, SPEED, STRIKING, SKILL }

# --- Personal Info ---
@export_group("Personal Info")
@export var CharacterName = str ("")
@export var ClassType = CharacterClass.POWERHOUSE
@export var Gender = CharacterGender.MALE
@export var Division = CharacterDivision.MAIN_EVENT
@export var Disposition = CharacterDisposition.FACE
@export_range(16, 75) var Age: int = 25
@export var Height: String = "6'0\""
@export var Weight: int = 220
@export var traits: Array[String] = []
@export var style: String = ""
@export var finisher_name: String = ""
@export var birthplace: Region = Region.NORTH_AMERICA:
    set(value):
        birthplace = value
        notify_property_list_changed()

# Then keep your _validate_property the same

@export var country_north_america: CountryNorthAmerica = CountryNorthAmerica.USA
@export var country_latin_america: CountryLatinAmerica = CountryLatinAmerica.BRAZIL
@export var country_europe: CountryEurope = CountryEurope.ENGLAND
@export var country_asia: CountryAsia = CountryAsia.JAPAN
@export var country_africa: CountryAfrica = CountryAfrica.NIGERIA
@export var country_oceania: CountryOceania = CountryOceania.NEW_ZEALAND

# --- Contract ---
@export_group("Contract")
@export_file("*.tres") var current_promotion_path: String
@export var current_contract: ContractResource
@export var contract_history: Array[ContractResource] = []
@export var PreviousPromotions: Array[PromotionResource]
@export_file("*.tres") var current_championship_path: String

func get_current_promotion() -> Resource:
    if current_promotion_path and ResourceLoader.exists(current_promotion_path):
        return load(current_promotion_path)
    return null

func get_current_championship() -> Resource:
    if current_championship_path and ResourceLoader.exists(current_championship_path):
        return load(current_championship_path)
    return null
# WrestlerResource.gd - add this to Career History group
@export var championship_history: Array[Dictionary] = []
# Each entry: {"title": TitleResource, "reign_days": int}

func add_title_reign(title: TitleResource, days: int):
    championship_history.append({
        "title": title,
        "reign_days": days
    })
    

func get_total_days_as_champion() -> int:
    var total = 0
    for reign in championship_history:
        total += reign["reign_days"]
    return total

# --- Stats ---
@export_group("Physical Attributes")
@export_range(1, 50) var strength: int = 10
@export_range(1, 50) var speed: int = 10
@export_range(1, 50) var stamina: int = 10

@export_group("Wrestling Attributes")
@export_range(1, 50) var skill: int = 10
@export_range(1, 50) var striking: int = 10
@export_range(1, 50) var charisma: int = 10

# --- Popularity by Region ---
@export_group("Popularity")
@export_range(0, 100) var pop_north_america: int = 0
@export_range(0, 100) var pop_latin_america: int = 0
@export_range(0, 100) var pop_europe: int = 0
@export_range(0, 100) var pop_asia: int = 0
@export_range(0, 100) var pop_africa: int = 0
@export_range(0, 100) var pop_oceania: int = 0

# --- Match-Specific Stats ---
@export_group("Health & Fatigue")
@export_range(0, 50) var fatigue: float = 0.0
@export_range(0, 50) var head_hp: int = 50
@export_range(0, 50) var body_hp: int = 50
@export_range(0, 50) var left_arm_hp: int = 50
@export_range(0, 50) var right_arm_hp: int = 50
@export_range(0, 50) var left_leg_hp: int = 50
@export_range(0, 50) var right_leg_hp: int = 50
@export var Momentum: float = 0.0

# --- Moveset ---
@export_group("Moveset")
@export var move_set: Array[MoveResource]

func _validate_property(property: Dictionary):
    # Hide country enums that don't match the current birthplace
    if property.name == "country_north_america" and birthplace != Region.NORTH_AMERICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_latin_america" and birthplace != Region.LATIN_AMERICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_europe" and birthplace != Region.EUROPE:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_asia" and birthplace != Region.ASIA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_africa" and birthplace != Region.AFRICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_oceania" and birthplace != Region.OCEANIA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
        
func get_country_name() -> String:
    match birthplace:
        Region.NORTH_AMERICA:
            return CountryNorthAmerica.keys()[country_north_america].capitalize().replace("_", " ")
        Region.LATIN_AMERICA:
            return CountryLatinAmerica.keys()[country_latin_america].capitalize().replace("_", " ")
        Region.EUROPE:
            return CountryEurope.keys()[country_europe].capitalize().replace("_", " ")
        Region.ASIA:
            return CountryAsia.keys()[country_asia].capitalize().replace("_", " ")
        Region.AFRICA:
            return CountryAfrica.keys()[country_africa].capitalize().replace("_", " ")
        Region.OCEANIA:
            return CountryOceania.keys()[country_oceania].capitalize().replace("_", " ")
    return "Unknown"
