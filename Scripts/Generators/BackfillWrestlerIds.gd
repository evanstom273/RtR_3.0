@tool
extends EditorScript

const WRESTLERS_ROOT = "res://Wrestlers"

func _run():
    var wrestler_paths = _get_wrestler_resource_paths()
    var assigned_count := 0

    for index in range(wrestler_paths.size()):
        var wrestler_path = wrestler_paths[index]
        var wrestler = load(wrestler_path)
        if wrestler == null:
            push_warning("Could not load wrestler resource: %s" % wrestler_path)
            continue

        wrestler.wrestler_id = str(index + 1)
        var save_error = ResourceSaver.save(wrestler, wrestler_path)
        if save_error != OK:
            push_warning("Could not save wrestler resource: %s (error %s)" % [wrestler_path, str(save_error)])
            continue

        assigned_count += 1

    print("Assigned sequential wrestler IDs to ", assigned_count, " wrestlers.")

func _get_wrestler_resource_paths() -> Array[String]:
    var wrestler_paths: Array[String] = []
    _collect_wrestler_paths(WRESTLERS_ROOT, wrestler_paths)
    wrestler_paths.sort()
    return wrestler_paths

func _collect_wrestler_paths(folder_path: String, wrestler_paths: Array[String]) -> void:
    var dir = DirAccess.open(folder_path)
    if dir == null:
        return

    dir.list_dir_begin()
    while true:
        var entry = dir.get_next()
        if entry == "":
            break
        if entry == "." or entry == "..":
            continue

        var entry_path = folder_path + "/" + entry
        if dir.current_is_dir():
            _collect_wrestler_paths(entry_path, wrestler_paths)
        elif entry.ends_with(".tres"):
            wrestler_paths.append(entry_path)
    dir.list_dir_end()
