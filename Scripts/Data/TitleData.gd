@tool
extends Resource
class_name TitleResource

enum TitleDivision {WORLD, SINGLES, WOMENS }

# --- Title Info ---
@export_group("Title Info")
@export_file("*.tres") var promotion_path: String
@export var title_division: TitleDivision = TitleDivision.WORLD:
    set(value):
        title_division = value
        _update_title_name()
@export var title_name: String = "Championship"
# TitleResource.gd
@export_file("*.tres") var current_holder_path: String
@export var current_reign_length: int = 0
@export var previous_champions: Array[Dictionary] = []  # All reigns ever

func change_champion(new_champion: WrestlerResource):
    # If there was a previous champion (path string), record reign
    if current_holder_path != "":
        # NOTE: This creates a Dictionary with a string path, not a Resource object
        # to maintain safety. Or we can load it if we need the object for history display.
        # For now, let's store the path to be consistent.
        previous_champions.append({
            "champion_path": current_holder_path,
            "reign_days": current_reign_length
        })
    
    current_holder_path = new_champion.resource_path
    current_reign_length = 0

func get_current_holder() -> Resource:
    if current_holder_path and ResourceLoader.exists(current_holder_path):
        return load(current_holder_path)
    return null

func get_wrestler_total_days(wrestler: WrestlerResource) -> int:
    var total = 0
    var w_path = wrestler.resource_path
    for reign in previous_champions:
        if reign.has("champion_path") and reign["champion_path"] == w_path:
            total += reign["reign_days"]
        # Backward compatibility if it was storing objects before
        elif reign.has("champion") and reign["champion"] == wrestler:
            total += reign["reign_days"]
            
    if current_holder_path == w_path:
        total += current_reign_length
    return total

func _get_matching_division() -> WrestlerResource.CharacterDivision:
    match title_division:
        TitleDivision.WORLD:
            return WrestlerResource.CharacterDivision.MAIN_EVENT
        TitleDivision.SINGLES:
            return WrestlerResource.CharacterDivision.SINGLES
        TitleDivision.WOMENS:
            return WrestlerResource.CharacterDivision.WOMENS
    return WrestlerResource.CharacterDivision.MAIN_EVENT

func _update_title_name():
    if promotion_path != "":
        # Since we don't load the promotion resource here to avoid cycles,
        # we can't get initials dynamically if we just set path.
        # However, generate_promotions sets title_name manually anyway.
        # If needed, one could load(promotion_path) but that risks the cycle again if not careful.
        pass

func get_promotion() -> Resource:
    if promotion_path and ResourceLoader.exists(promotion_path):
        return load(promotion_path)
    return null
