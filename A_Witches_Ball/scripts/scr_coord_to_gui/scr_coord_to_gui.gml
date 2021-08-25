function scr_coord_to_gui(is_x,pos)
{
	var ratio = gui_scale;
	var view_pos = view_y;
	
	if(is_x) view_pos = view_x;

	
	var final_pos = (pos - view_pos) * ratio;
	
	return (final_pos);
}