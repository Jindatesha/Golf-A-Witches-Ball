function scr_gui_to_coord(is_x,pos)
{	
	var camera_pos = view_y;	
	if(is_x) camera_pos = view_x;
	
	var final_pos = camera_pos + (pos / gui_scale);
	
	return (final_pos);
}