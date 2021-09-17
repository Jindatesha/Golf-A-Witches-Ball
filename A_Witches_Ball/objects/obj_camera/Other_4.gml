view_enabled = true;
view_visible[0] = true;

//anti aliasing level...0 = off (meant for pixel art)
draw_set_swf_aa_level(0);


//retain resolution from last room or initialize resolution if first time running this
scr_change_screen_resolution(old_window_w,old_window_h);

has_finished_level_intro = false;

//follow the path from the hole to the ball/player
if(instance_exists(obj_ball))
{
	var this_path_id = asset_get_index("path_" + string_digits(room_get_name(room)));
	var max_path_length = 5500;
	var this_path_length = path_get_length(this_path_id);
	var this_path_length_ratio = min(1,this_path_length/max_path_length);
	path_start(this_path_id,this_path_length_ratio * max_path_speed,path_action_stop,true);
}




