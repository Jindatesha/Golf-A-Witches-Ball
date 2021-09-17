function scr_get_collided_normal(_x,_y,starting_dir,_col_id)
{
	///@description this script is ran in player, player is a ball, and returns the normal vector to be used in reflection later	
	

	//because this is a ball...and prior to running this script we are butting up against the solid...start at the point right before the collider
	var line_x1 = _x + lengthdir_x((sprite_width/2) + 3,starting_dir);
	var line_y1 = _y + lengthdir_y((sprite_width/2) + 3,starting_dir);
	var entry_dir = starting_dir;	
	
	while(position_meeting(line_x1,line_y1,_col_id) == noone)
	{
		entry_dir += 1;
		line_x1 = ceil(_x + lengthdir_x((sprite_width/2) + 3,entry_dir));
		line_y1 = ceil(_y + lengthdir_y((sprite_width/2) + 3,entry_dir));
	}
	
	line_x1 = _x + lengthdir_x((sprite_width/2) - 1,entry_dir);
	line_y1 = _y + lengthdir_y((sprite_width/2) - 1,entry_dir);

	//so we open towards the object we the player are from the object we collided with
	starting_dir = entry_dir + 180;
	
	var entry_point_array = array_create(0);
	
	#region go around the point of contact and find the first two points u find (one on each side opening from the opposite of the starting dir) 
		entry_dir = starting_dir;
		var line_x2 = floor(line_x1 + lengthdir_x(10,entry_dir));
		var line_y2 = floor(line_y1 + lengthdir_y(10,entry_dir));
		var entry_angle = -1;

		for(var i = 0; i < 2; i += 1;)
		{
			
			while(collision_line(line_x1,line_y1,line_x2,line_y2,obj_solid,true,true) == noone)
			{
				
				if(abs(entry_dir) > 10000)
				{
					instance_create_depth(line_x1,line_y1,depth,obj_circle);
					var second = instance_create_depth(line_x2,line_y2,depth,obj_circle);
					second.my_color = c_purple;
					
					var final_normal_vector_array;
					final_normal_vector_array[0] = lengthdir_x(1,starting_dir - 180);
					final_normal_vector_array[1] = lengthdir_y(1,starting_dir - 180);
					return final_normal_vector_array;
				}
				
				entry_dir += entry_angle;
				line_x2 = line_x1 + floor(lengthdir_x(10,entry_dir));
				line_y2 = line_y1 + floor(lengthdir_y(10,entry_dir));
			}
			
			
			if(i == 0)
			{
				entry_point_array[0][0] = line_x2;
				entry_point_array[0][1] = line_y2;
					
				entry_angle *= -1;
				entry_dir = starting_dir;	
				
				line_x2 = line_x1 + floor(lengthdir_x(10,starting_dir));
				line_y2 = line_y1 + floor(lengthdir_y(10,starting_dir));
			}
			else
			{
				entry_point_array[1][0] = line_x2;
				entry_point_array[1][1] = line_y2;
			}
			
		}
	#endregion 
	
	//use the 2 entry points to get the direction of our contact area and our final "n" dir
	var norm_dir = point_direction(entry_point_array[0][0],entry_point_array[0][1],entry_point_array[1][0],entry_point_array[1][1]) - 90;
	
	var final_normal_vector_array;
	final_normal_vector_array[0] = lengthdir_x(1,norm_dir);
	final_normal_vector_array[1] = lengthdir_y(1,norm_dir);
	
	with(instance_create_depth(line_x1,line_y1,depth, obj_arrow))
	{
		image_angle = norm_dir;
	}
	
	return final_normal_vector_array;
}