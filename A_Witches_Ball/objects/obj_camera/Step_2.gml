
//check if the window size has changed at all
var window_w = window_get_width();
var window_h = window_get_height();

if ( window_w != old_window_w or window_h != old_window_h)
{
	scr_change_screen_resolution(window_w,window_h);
}



//set position of view
if(instance_exists(obj_ball))
{
	with(obj_ball)
	{		
		var center_of_player_x = x - view_w/2;
		var center_of_player_y = y - view_h/2;
		
		var to_mouse_dir = point_direction(x,y,cursor_x,cursor_y);
		var distance_to_mouse = distance_to_point(cursor_x,cursor_y);
		var radius_around_player = 15;
		var offset_cursor_x = lengthdir_x(min(radius_around_player,distance_to_mouse),to_mouse_dir);
		var offset_cursor_y = lengthdir_y(min(radius_around_player,distance_to_mouse),to_mouse_dir);
			
		var new_x = round(center_of_player_x + offset_cursor_x);
		var new_y = round(center_of_player_y + offset_cursor_y);
	
		var old_x = view_x; 
		var old_y = view_y;
	
		var lerp_speed = 0.1;
	
		camera_set_view_pos(view,lerp(old_x,new_x,lerp_speed),lerp(old_y,new_y,lerp_speed));	
	}
}







