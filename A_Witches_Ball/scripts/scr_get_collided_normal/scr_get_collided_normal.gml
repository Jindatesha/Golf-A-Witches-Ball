function scr_get_collided_normal(_x,_y,_col_id)
{
	//this script is ran in player, player is a ball, and returns the normal vector to be used in reflection later	
	var entry_point_array = array_create(0);
	var potential_entry_point_x = 0;
	var potential_entry_point_y = 0;
	
	
	#region get an empty point 
		var starting_dir = 0;
		var found_second_entry_point = false;
		do
		{
			starting_dir += 1;
			potential_entry_point_x = _x + lengthdir_x((sprite_width/2) + 1,starting_dir);
			potential_entry_point_y = _y + lengthdir_y((sprite_width/2) + 1,starting_dir);
		}	
		until(!place_meeting(potential_entry_point_x,potential_entry_point_y,_col_id));
	#endregion 
	
	
	#region get the entry and exit points of collision between player/ball and the wall it collided with
		var entry_dir = starting_dir;
		var entry_angle = -1;
		var found_first_entry_point = false;
		while(found_second_entry_point == false)
		{
			entry_dir += entry_angle;
			potential_entry_point_x = _x + lengthdir_x((sprite_width/2) + 1,entry_dir);
			potential_entry_point_y = _y + lengthdir_y((sprite_width/2) + 1,entry_dir);
		
			if(place_meeting(potential_entry_point_x,potential_entry_point_y,_col_id))
			{			
				if(found_first_entry_point)
				{
					entry_point_array[1][0] = potential_entry_point_x;
					entry_point_array[1][1] = potential_entry_point_y;
					found_second_entry_point = true;
				}
				else
				{
					entry_point_array[0][0] = potential_entry_point_x;
					entry_point_array[0][1] = potential_entry_point_y;
					found_first_entry_point = true;
					entry_angle *= -1;
					entry_dir = starting_dir;
				}
			}
		}
	#endregion 
	
	//use the 2 entry points to get the direction of our contact area and our final "n" dir
	var norm_dir = point_direction(entry_point_array[0][0],entry_point_array[0][1],entry_point_array[1][0],entry_point_array[1][1]) - 90;
	
	var final_normal_vector_array;
	final_normal_vector_array[0] = lengthdir_x(1,norm_dir);
	final_normal_vector_array[1] = lengthdir_y(1,norm_dir);
	
	return final_normal_vector_array;
}