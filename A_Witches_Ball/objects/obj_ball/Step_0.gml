//NOTE: inputs are in OBJ_GAME



if(button_left_mouse_pressed and can_hit_ball)
{
	show_aim_assist_arrow = true;
}
  


if(show_aim_assist_arrow)
{
	var mouse_dir = point_direction(x,y,cursor_x,cursor_y);
	var mouse_dist_to_ball = point_distance(x,y,cursor_x,cursor_y);
	var striking_power_ratio = min(mouse_dist_to_ball/max_dist_to_ball,1);
	var striking_power = striking_power_ratio * base_move_speed;
	debug_striking_power_ratio = striking_power_ratio;
	
	//draw aim assist arrow	
	aim_assist_arrow_dir = mouse_dir - 180;
	
	if(button_left_mouse_released)
	{
		show_aim_assist_arrow = false;
		move_speed = striking_power;
		can_hit_ball = false;
		move_dir = aim_assist_arrow_dir;
		stroke_counter += 1;
	}	
}








#region when hitting a solid object, bounce off it
	
	var h_speed = lengthdir_x(move_speed,move_dir);
	var v_speed = lengthdir_y(move_speed,move_dir);
	
	var hor_dir = sign(h_speed);
	var ver_dir = sign(v_speed);
	
	var col_id = instance_place(x + h_speed,y + v_speed,obj_solid)
	

	//horizontal movement + collisions
	if(hor_dir != 0)
	{
		if(place_meeting(x + h_speed,y,obj_solid))
		{
			while(!place_meeting(x + hor_dir,y,obj_solid))
			{
				x += hor_dir;
				//adjust remaining amount for bounce off
			}			
		}
		else
		{
			x += h_speed;
		}		
	}
	
	//x = round(x);
	


	//vertical movement + collisions
	if(ver_dir != 0)
	{
		if(place_meeting(x,y + v_speed,obj_solid))
		{
			while(!place_meeting(x,y + ver_dir,obj_solid))
			{
				y += ver_dir;
			}
		}
		else
		{
			y += v_speed;
		}
		
		
	}
	
	
	//y = round(y);
	
	//reflect 
	if(col_id != noone)
	{
		var collided_normal_vector_array = scr_get_collided_normal(x,y,move_dir,col_id);
		
		var projected_vector_array;
		var projected_scalar = (h_speed * collided_normal_vector_array[0]) + (v_speed * collided_normal_vector_array[1]);
		projected_vector_array[0] = projected_scalar * collided_normal_vector_array[0];
		projected_vector_array[1] = projected_scalar * collided_normal_vector_array[1];
		
		var remaining_w_vector_array
		remaining_w_vector_array[0] = h_speed - projected_vector_array[0];
		remaining_w_vector_array[1] = v_speed - projected_vector_array[1];
		
		var reflected_vector_array;
		var bounce_friction = 0.9;
		reflected_vector_array[0] = -bounce_friction * (projected_vector_array[0] - remaining_w_vector_array[0]);
		reflected_vector_array[1] = -bounce_friction * (projected_vector_array[1] - remaining_w_vector_array[1]);
		
		var debug_test_init_length = move_speed;
		var remaining_reflected_vector_length = sqrt(sqr(reflected_vector_array[0]) + sqr(reflected_vector_array[1]));
		
		move_speed = remaining_reflected_vector_length;
		move_dir = point_direction(x,y,x + reflected_vector_array[0],y + reflected_vector_array[1]);
	}


	//friction
	move_speed *= 0.98;
	
	
	if(move_speed <= 0.01)
	{
		move_speed = 0;
		can_hit_ball = true;
	}
	
#endregion


