@tool
extends Resource
class_name MoveResource

enum MovePosition { STANDING, GROUNDED, CORNER, ROPE_REBOUND, SPRINGBOARD, DIVING, RUNNING }

enum MoveType { STRIKE, GRAPPLE, AERIAL, SUBMISSION }

enum KeyStat { STRENGTH, SPEED, STRIKING, SKILL }

enum CharacterBodyParts { HEAD, BODY, LEFT_ARM, RIGHT_ARM, LEFT_LEG, RIGHT_LEG }

enum TargetPos { STANDING, GROUNDED, IN_CORNER }

# --- Move Details ---
@export_group("Move Info")
@export var move_name: String = ""
@export var move_type: MoveType = MoveType.STRIKE
@export var key_stat: KeyStat = KeyStat.STRENGTH
@export var target_parts: Array[CharacterBodyParts] = []
@export var is_finisher: bool = false

@export_group("Positioning")
@export var required_opponent_position: Array[TargetPos]
@export var outcome_opponent_position: MovePosition = MovePosition.STANDING
@export var outcome_self_position: MovePosition = MovePosition.STANDING
