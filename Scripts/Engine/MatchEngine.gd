extends CanvasLayer

@export var wrestler_a: WrestlerResource
@export var wrestler_b: WrestlerResource

@onready var promotion_label: Label = $Root/RootVBox/TopBanner/TopBannerMargin/TopBannerHBox/PromotionLabel
@onready var match_title: Label = $Root/RootVBox/TopBanner/TopBannerMargin/TopBannerHBox/MatchTitle
@onready var match_status: Label = $Root/RootVBox/TopBanner/TopBannerMargin/TopBannerHBox/MatchStatus
@onready var match_log: RichTextLabel = $Root/RootVBox/MainHBox/CenterPanel/CenterMargin/CenterVBox/MatchLog

@onready var left_name: Label = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftName
@onready var left_sub: Label = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftSub
@onready var left_stats: RichTextLabel = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftStatsPanel/LeftStatsMargin/LeftStats
@onready var left_condition: RichTextLabel = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftCondition

@onready var left_head_bar: ProgressBar = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftHeadRow/LeftHeadBar
@onready var left_head_value: Label = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftHeadRow/LeftHeadValue
@onready var left_body_bar: ProgressBar = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftBodyRow/LeftBodyBar
@onready var left_body_value: Label = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftBodyRow/LeftBodyValue
@onready var left_arm_l_bar: ProgressBar = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftArmLRow/LeftArmLBar
@onready var left_arm_l_value: Label = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftArmLRow/LeftArmLValue
@onready var left_arm_r_bar: ProgressBar = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftArmRRow/LeftArmRBar
@onready var left_arm_r_value: Label = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftArmRRow/LeftArmRValue
@onready var left_leg_l_bar: ProgressBar = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftLegLRow/LeftLegLBar
@onready var left_leg_l_value: Label = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftLegLRow/LeftLegLValue
@onready var left_leg_r_bar: ProgressBar = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftLegRRow/LeftLegRBar
@onready var left_leg_r_value: Label = $Root/RootVBox/MainHBox/LeftPanel/LeftMargin/LeftVBox/LeftHealthPanel/LeftHealthMargin/LeftHealthVBox/LeftLegRRow/LeftLegRValue

@onready var right_name: Label = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightName
@onready var right_sub: Label = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightSub
@onready var right_stats: RichTextLabel = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightStatsPanel/RightStatsMargin/RightStats
@onready var right_condition: RichTextLabel = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightCondition

@onready var right_head_bar: ProgressBar = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightHeadRow/RightHeadBar
@onready var right_head_value: Label = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightHeadRow/RightHeadValue
@onready var right_body_bar: ProgressBar = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightBodyRow/RightBodyBar
@onready var right_body_value: Label = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightBodyRow/RightBodyValue
@onready var right_arm_l_bar: ProgressBar = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightArmLRow/RightArmLBar
@onready var right_arm_l_value: Label = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightArmLRow/RightArmLValue
@onready var right_arm_r_bar: ProgressBar = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightArmRRow/RightArmRBar
@onready var right_arm_r_value: Label = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightArmRRow/RightArmRValue
@onready var right_leg_l_bar: ProgressBar = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightLegLRow/RightLegLBar
@onready var right_leg_l_value: Label = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightLegLRow/RightLegLValue
@onready var right_leg_r_bar: ProgressBar = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightLegRRow/RightLegRBar
@onready var right_leg_r_value: Label = $Root/RootVBox/MainHBox/RightPanel/RightMargin/RightVBox/RightHealthPanel/RightHealthMargin/RightHealthVBox/RightLegRRow/RightLegRValue


func _ready() -> void:
    promotion_label.text = "ROLL THE ROPES"
    match_title.text = "MATCH"
    refresh_ui()

    if wrestler_a and wrestler_b:
        match_status.text = "READY TO START"
        add_log("[b]%s[/b] vs [b]%s[/b]" % [wrestler_a.CharacterName, wrestler_b.CharacterName])
        add_log("The crowd is ready.")
    else:
        match_status.text = "MISSING WRESTLERS"
        add_log("Assign two WrestlerResource files in the inspector.")


func refresh_ui() -> void:
    if wrestler_a:
        _fill_wrestler_panel(
            wrestler_a,
            left_name,
            left_sub,
            left_stats,
            left_condition,
            left_head_bar, left_head_value,
            left_body_bar, left_body_value,
            left_arm_l_bar, left_arm_l_value,
            left_arm_r_bar, left_arm_r_value,
            left_leg_l_bar, left_leg_l_value,
            left_leg_r_bar, left_leg_r_value
        )

    if wrestler_b:
        _fill_wrestler_panel(
            wrestler_b,
            right_name,
            right_sub,
            right_stats,
            right_condition,
            right_head_bar, right_head_value,
            right_body_bar, right_body_value,
            right_arm_l_bar, right_arm_l_value,
            right_arm_r_bar, right_arm_r_value,
            right_leg_l_bar, right_leg_l_value,
            right_leg_r_bar, right_leg_r_value
        )


func add_log(message: String) -> void:
    match_log.append_text(message + "\n")


func _fill_wrestler_panel(
    w: WrestlerResource,
    name_label: Label,
    sub_label: Label,
    stats_label: RichTextLabel,
    condition_label: RichTextLabel,
    head_bar: ProgressBar, head_value: Label,
    body_bar: ProgressBar, body_value: Label,
    arm_l_bar: ProgressBar, arm_l_value: Label,
    arm_r_bar: ProgressBar, arm_r_value: Label,
    leg_l_bar: ProgressBar, leg_l_value: Label,
    leg_r_bar: ProgressBar, leg_r_value: Label
) -> void:
    name_label.text = w.CharacterName
    sub_label.text = "%s • %s • %s" % [
        _enum_name(WrestlerResource.CharacterClass.keys(), w.ClassType),
        _enum_name(WrestlerResource.CharacterDivision.keys(), w.Division),
        _enum_name(WrestlerResource.CharacterDisposition.keys(), w.Disposition)
    ]

    stats_label.text = _build_stats_text(w)
    condition_label.text = _build_condition_text(w)

    _set_health_row(head_bar, head_value, w.head_hp)
    _set_health_row(body_bar, body_value, w.body_hp)
    _set_health_row(arm_l_bar, arm_l_value, w.left_arm_hp)
    _set_health_row(arm_r_bar, arm_r_value, w.right_arm_hp)
    _set_health_row(leg_l_bar, leg_l_value, w.left_leg_hp)
    _set_health_row(leg_r_bar, leg_r_value, w.right_leg_hp)


func _build_stats_text(w: WrestlerResource) -> String:
    var text := ""

    text += "[b]PROFILE[/b]\n"
    text += "Age: %d\n" % w.Age
    text += "Height: %s\n" % w.Height
    text += "Weight: %d lbs\n" % w.Weight
    text += "Country: %s\n" % w.get_country_name()

    text += "\n[b]ATTRIBUTES[/b]\n"
    text += "STR  %d    SPD  %d    STA  %d\n" % [w.strength, w.speed, w.stamina]
    text += "SKL  %d    STK  %d    CHA  %d\n" % [w.skill, w.striking, w.charisma]

    if w.finisher_name != "":
        text += "\n[b]FINISHER[/b]\n%s\n" % w.finisher_name

    if w.style != "":
        text += "\n[b]STYLE[/b]\n%s\n" % w.style

    if w.traits.size() > 0:
        text += "\n[b]TRAITS[/b]\n%s\n" % ", ".join(w.traits)

    text += "\n[b]MOVESET[/b]\n%d moves\n" % w.move_set.size()

    return text


func _build_condition_text(w: WrestlerResource) -> String:
    var text := ""
    text += "[b]MATCH CONDITION[/b]\n"
    text += "Fatigue: %.1f\n" % w.fatigue
    text += "Momentum: %.1f\n" % w.Momentum
    return text


func _set_health_row(bar: ProgressBar, value_label: Label, value: int) -> void:
    var hp: int = clamp(value, 0, 50)
    bar.max_value = 50
    bar.value = hp
    bar.show_percentage = false
    value_label.text = "%d/50" % hp
    bar.modulate = _health_color(hp)


func _health_color(value: int) -> Color:
    if value >= 35:
        return Color(0.25, 0.85, 0.45)
    elif value >= 20:
        return Color(0.95, 0.75, 0.20)
    return Color(0.90, 0.25, 0.25)


func _enum_name(keys: Array, value: int) -> String:
    if value >= 0 and value < keys.size():
        return str(keys[value]).capitalize().replace("_", " ")
    return "Unknown"
