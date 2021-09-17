
//check if the window size has changed at all
var window_w = window_get_width();
var window_h = window_get_height();

if ( window_w != old_window_w or window_h != old_window_h)
{
	scr_change_screen_resolution(window_w,window_h);
}



if(has_finished_level_intro == true)
{
	//follow ball/player
	if(instance_exists(obj_ball))
	{

		with(obj_ball)
		{		
			var center_of_player_x = x - view_w/2;
			var center_of_player_y = y - (view_h * 0.7);
		
			var offset_cursor_x = 0;
			var offset_cursor_y = 0;
		
			var added_screenshake_x = 0;
			var added_screenshake_y = 0;
		
			if(pulling_ball_back == true)
			{
			
			
				var to_mouse_dir = point_direction(x,y,cursor_x,cursor_y);
				var distance_to_mouse = point_distance(x,y,cursor_x,cursor_y);
			
				if(last_pull_back_frame == sprite_get_number(spr_pull_back_indicator_tongue) - 1)
				{
					var screen_shake_amount = 0.85;
					added_screenshake_x = 0;//random_range(-screen_shake_amount,screen_shake_amount);
					added_screenshake_y = 0;//random_range(-screen_shake_amount,screen_shake_amount);
				}
			
			
			//	var radius_around_player = 15;
			//	offset_cursor_x = lengthdir_x(min(radius_around_player,distance_to_mouse),to_mouse_dir);
			//	offset_cursor_y = lengthdir_y(min(radius_around_player,distance_to_mouse),to_mouse_dir);
			}
		
			var new_x = center_of_player_x + offset_cursor_x;
			var new_y = center_of_player_y + offset_cursor_y;
	
			var old_x = view_x; 
			var old_y = view_y;
	
			var lerp_speed = 0.1;
			var final_camera_pos_x = round(lerp(old_x,new_x,lerp_speed) + added_screenshake_x);
			var final_camera_pos_y = round(lerp(old_y,new_y,lerp_speed) + added_screenshake_y);
			
			camera_set_view_pos(view,final_camera_pos_x,final_camera_pos_y);	
		}
	
	}
}
else
{
	if(instance_exists(obj_ball))
	{
	
		camera_set_view_pos(view,round(x - (view_w/2)),round(y - (view_h * 0.7)));	
		
		if(path_position == 1)
		{
			has_finished_level_intro = true;
		}
	}
}





