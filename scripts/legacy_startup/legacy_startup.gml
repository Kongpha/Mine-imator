/// legacy_startup()
/// @desc Load various lookup tables from the legacy.midata file for loading old formats.

log("Loading legacy file")

globalvar legacy_model_id_05_map, legacy_model_id_06_map, legacy_model_id_100_demo_map;
globalvar legacy_model_part_map, legacy_model_name_map;
globalvar legacy_block_set, legacy_block_id, legacy_block_obj, legacy_block_state_vars, legacy_block_state_id;
globalvar legacy_block_texture_name_map, legacy_block_05_texture_list, legacy_block_07_demo_texture_list, legacy_block_100_texture_list;
globalvar legacy_item_texture_name_map;
globalvar legacy_biomes_map;

var map = json_load(legacy_file);
if (!ds_map_valid(map))
	return 0

// Models
legacy_model_id_05_map = map[?"legacy_model_id_05"]
legacy_model_id_06_map = map[?"legacy_model_id_06"]
legacy_model_id_100_demo_map = map[?"legacy_model_id_100_demo"]
	
ds_map_merge(legacy_model_id_05_map, map[?"legacy_model_id"])
ds_map_merge(legacy_model_id_06_map, map[?"legacy_model_id"])
ds_map_merge(legacy_model_id_100_demo_map, map[?"legacy_model_id"])
	
legacy_model_part_map = map[?"legacy_model_part"]
legacy_model_name_map = map[?"legacy_model_name"]

// Blocks
legacy_block_set[255] = false
legacy_block_id = map[?"legacy_block_id"]
legacy_block_texture_name_map = map[?"legacy_block_texture_name"]
legacy_block_05_texture_list = map[?"legacy_block_05_textures"]
legacy_block_07_demo_texture_list = map[?"legacy_block_07_demo_textures"]
legacy_block_100_texture_list = map[?"legacy_block_100_textures"]

// Items
legacy_item_texture_name_map = map[?"legacy_item_texture_name"]

// Biomes
legacy_biomes_map = map[?"legacy_biomes"]