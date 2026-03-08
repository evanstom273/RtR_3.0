@tool
extends Resource
class_name PromotionResource

enum Region { NORTH_AMERICA, LATIN_AMERICA, EUROPE, ASIA, AFRICA, OCEANIA }
enum CountryNorthAmerica { USA, CANADA, MEXICO }
enum CountryLatinAmerica { BRAZIL, ARGENTINA, CHILE }
enum CountryEurope { ENGLAND, SCOTLAND, FRANCE, GERMANY, IRELAND, ITALY, SPAIN, WALES }
enum CountryAsia { JAPAN, CHINA, INDIA, SOUTH_KOREA }
enum CountryAfrica { NIGERIA, SOUTH_AFRICA, GHANA }
enum CountryOceania { NEW_ZEALAND, AUSTRALIA, SAMOA }
enum PromotionSize { SMALL, MEDIUM, LARGE, GIANT }

@export_group("Promotion Info")
@export var company_name: String = "Global Wrestling Federation":
    set(val):
        company_name = val
        emit_changed()
@export var initials: String = "GWF":
    set(val):
        initials = val.to_upper().left(5)
        emit_changed()
@export var company_size: PromotionSize = PromotionSize.SMALL
@export var birthplace: Region = Region.NORTH_AMERICA:
    set(value):
        birthplace = value
        notify_property_list_changed()

@export var country_north_america: CountryNorthAmerica = CountryNorthAmerica.USA
@export var country_latin_america: CountryLatinAmerica = CountryLatinAmerica.BRAZIL
@export var country_europe: CountryEurope = CountryEurope.ENGLAND
@export var country_asia: CountryAsia = CountryAsia.JAPAN
@export var country_africa: CountryAfrica = CountryAfrica.NIGERIA
@export var country_oceania: CountryOceania = CountryOceania.NEW_ZEALAND

@export_group("Roster")
@export var main_event_roster: Array[WrestlerResource] = []  # 14 wrestlers (7 heel/7 face)
@export var singles_roster: Array[WrestlerResource] = []     # 14 wrestlers (7 heel/7 face)
@export var womens_roster: Array[WrestlerResource] = []      # 8 wrestlers (4 heel/4 face)

@export_group("Championships")
@export var world_championship: TitleResource
@export var midcard_championship: TitleResource
@export var womens_championship: TitleResource

func _validate_property(property: Dictionary):
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
