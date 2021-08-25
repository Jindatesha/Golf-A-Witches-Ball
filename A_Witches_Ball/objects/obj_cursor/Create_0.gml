//debug


//remove the normal cursor 
window_set_cursor(cr_none);
cursor_size = 2;

mask_index = spr_white;

//makes this a lower depth than anything potentially in the game room
if(instance_exists(obj_camera))
{
	depth = obj_camera.depth - 1;
}
else
{
	depth = -10000;
}

#region build mode stuff
	base_cursor_sprite = sprite_index;
	placing_structure = false;
	place_id = -1;
	place_x = 0;
	place_y = 0;
	can_place = false;
	
	was_hovered_over_button_last_frame = false;
	old_cursor_sprite = sprite_index;
	old_place_id = place_id;
	use_default_cursor = true;
#endregion

