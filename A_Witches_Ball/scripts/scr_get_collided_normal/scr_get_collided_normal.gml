function scr_get_collided_normal(_x,_y,_move_dir,_col_id)
{

	var swing_dir = 1;
	var adjust_dir = 0;
	var starting_dir = _move_dir - 180;
	var point_array;
	var pos_x = _x;
	var pos_y = _y;
	
	for(var i = 0; i < 2; i += 1;)
	{
		
		while(!position_meeting(pos_x,pos_y,_col_id))
		{
			adjust_dir += 1 * swing_dir;
			pos_x = _x + lengthdir_x(10,starting_dir + adjust_dir);
			pos_y = _y + lengthdir_y(10,starting_dir + adjust_dir);			
		}
		
		point_array[i][0] = pos_x;
		point_array[i][1] = pos_y;
		
		adjust_dir = 0;
		pos_x = _x;
		pos_y = _y;
		swing_dir *= -1;
		
	}
	
	var norm_dir = point_direction(point_array[0][0],point_array[0][1],point_array[1][0],point_array[1][1]) - 90;
	
	var final_normal_vector_array;
	final_normal_vector_array[0] = lengthdir_x(1,norm_dir);
	final_normal_vector_array[1] = lengthdir_y(1,norm_dir);
	
	//debug
	with(_col_id)
	{
			normal_vector_pos_x = _x;
			normal_vector_pos_y = _y;
			normal_vector_dir = norm_dir + 180;
		
	}
	
	return final_normal_vector_array;
}