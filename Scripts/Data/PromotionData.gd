@tool
extends Resource
class_name PromotionResource

enum Region { NORTH_AMERICA, LATIN_AMERICA, EUROPE, ASIA, AFRICA, OCEANIA }
enum CountryNorthAmerica { USA, CANADA, MEXICO }
enum CountryLatinAmerica { BRAZIL, ARGENTINA, CHILE }
enum CountryEurope { ENGLAND, SCOTLAND, FRANCE, GERMANY, IRELAND, ITALY, SPAIN, WALES }
enum CountryAsia { JAPAN, CHINA, INDIA, SOUTH_KOREA, THAILAND }
enum CountryAfrica { NIGERIA, SOUTH_AFRICA, GHANA }
enum CountryOceania { NEW_ZEALAND, AUSTRALIA, SAMOA }

@export_group("Promotion Info")
@export var company_name: String = "Global Wrestling Federation":
    set(val):
        company_name = val
        emit_changed() # Triggers an update when the name changes

@export var initials: String = "GWF":
    set(val):
        initials = val.to_upper().left(5)
        # Removed warning print - no longer needed
        emit_changed() # Triggers an update when initials change
@export var home_region: WrestlerResource.Region = WrestlerResource.Region.NORTH_AMERICA:
    set(value):
        home_region = value
        notify_property_list_changed()

# Country enums - displayed based on home_region
@export var country_north_america: WrestlerResource.CountryNorthAmerica = WrestlerResource.CountryNorthAmerica.USA
@export var country_latin_america: WrestlerResource.CountryLatinAmerica = WrestlerResource.CountryLatinAmerica.BRAZIL
@export var country_europe: WrestlerResource.CountryEurope = WrestlerResource.CountryEurope.ENGLAND
@export var country_asia: WrestlerResource.CountryAsia = WrestlerResource.CountryAsia.JAPAN
@export var country_africa: WrestlerResource.CountryAfrica = WrestlerResource.CountryAfrica.NIGERIA
@export var country_oceania: WrestlerResource.CountryOceania = WrestlerResource.CountryOceania.NEW_ZEALAND



var _north_america_pop: int = 0
var _latin_america_pop: int = 0
var _europe_pop: int = 0
var _asia_pop: int = 0
var _africa_pop: int = 0
var _oceania_pop: int = 0

@export_group("Promotion Pop")
@export_range(0, 100) var North_America_Pop: int:
    get:
        return _north_america_pop
    set(value):
        _north_america_pop = value
        _refresh_global_pop()
@export_range(0, 100) var Latin_America_Pop: int:
    get:
        return _latin_america_pop
    set(value):
        _latin_america_pop = value
        _refresh_global_pop()
@export_range(0, 100) var Europe_Pop: int:
    get:
        return _europe_pop
    set(value):
        _europe_pop = value
        _refresh_global_pop()
@export_range(0, 100) var Asia_Pop: int:
    get:
        return _asia_pop
    set(value):
        _asia_pop = value
        _refresh_global_pop()
@export_range(0, 100) var Africa_Pop: int:
    get:
        return _africa_pop
    set(value):
        _africa_pop = value
        _refresh_global_pop()
@export_range(0, 100) var Oceania_Pop: int:
    get:
        return _oceania_pop
    set(value):
        _oceania_pop = value
        _refresh_global_pop()
@export_custom(PROPERTY_HINT_RANGE, "0,100,1", PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_READ_ONLY) var Global_Pop: int = 0

@export_group("Roster")
@export var main_event_roster: Array[WrestlerResource] = []  # 14 wrestlers (7 heel/7 face)
@export var singles_roster: Array[WrestlerResource] = []     # 14 wrestlers (7 heel/7 face)
@export var womens_roster: Array[WrestlerResource] = []      # 8 wrestlers (4 heel/4 face)

@export_group("Championships")
@export var world_championship: TitleResource
@export var midcard_championship: TitleResource
@export var womens_championship: TitleResource

func get_global_popularity() -> int:
    return roundi(float(
        North_America_Pop +
        Latin_America_Pop +
        Europe_Pop +
        Asia_Pop +
        Africa_Pop +
        Oceania_Pop
    ) / 6.0)

func _refresh_global_pop() -> void:
    Global_Pop = get_global_popularity()
    notify_property_list_changed()
    emit_changed()

func _validate_property(property: Dictionary):
    # Hide country enums that don't match the current home_region
    if property.name == "country_north_america" and home_region != Region.NORTH_AMERICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_latin_america" and home_region != Region.LATIN_AMERICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_europe" and home_region != Region.EUROPE:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_asia" and home_region != Region.ASIA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_africa" and home_region != Region.AFRICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_oceania" and home_region != Region.OCEANIA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
        
func get_country_name() -> String:
    match home_region:
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
