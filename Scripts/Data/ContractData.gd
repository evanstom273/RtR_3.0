@tool
extends Resource
class_name ContractResource

@export_file("*.tres") var promotion_path: String
@export_file("*.tres") var wrestler_path: String
@export_range(0, 1000000) var annual_salary: float = 50000
@export var start_week: int = 0
@export var contract_length_weeks: int = 52  # 1 year default
@export var weeks_remaining: int = 52

@export_group("Clauses")
@export var has_creative_control: bool = false
@export var guaranteed_title_shot: bool = false
@export var can_work_indies: bool = false
@export var loss_clause: bool = false

func get_promotion() -> Resource:
    if promotion_path and ResourceLoader.exists(promotion_path):
        return load(promotion_path)
    return null

func get_wrestler() -> Resource:
    if wrestler_path and ResourceLoader.exists(wrestler_path):
        return load(wrestler_path)
    return null
