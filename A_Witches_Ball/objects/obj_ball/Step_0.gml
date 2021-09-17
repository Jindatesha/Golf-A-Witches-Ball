//NOTE: inputs are in OBJ_GAME
if(just_finished_level == false)
{
	if(has_finished_level_intro == false)
	{
		can_hit_ball = false;	
	}




	var distance_from_mouse = point_distance(x,y,cursor_x,cursor_y);

	if(button_left_mouse_pressed and can_hit_ball == true and distance_from_mouse < init_grab_ball_radius)
	{
		pulling_ball_back = true;
		ball_is_on_field = false;
	}



	if(pulling_ball_back == true and can_hit_ball == true)
	{
		//if let go early then use the stroke we got
		if(button_left_mouse_released)
		{			
			pulling_ball_back = false;
		
		
			launch_ball_animation_speed = ((last_pull_back_frame + 1)/(room_speed * 0.118));
		
			//calculate force for later
			var pull_back_amount = clamp(point_distance(x,y,cursor_x,cursor_y) - starting_dist_to_ball,20,max_dist_to_ball);
			
			launch_stroke_dir = point_direction(cursor_x,cursor_y,x,y);
			var striking_power_ratio = min(pull_back_amount/max_dist_to_ball,1);
			launch_striking_power = striking_power_ratio * max_move_speed;
			//debug
			debug_striking_power_ratio = striking_power_ratio;	
		
			if(launch_striking_power > 0.2)
			{
				play_fire_ball_animation = true;
			}
				
			band_slap_animation_speed = (sprite_get_number(spr_fx_init_hit_ball_base)/(room_speed * 0.15));
			
		}
	}

}



#region when hitting a solid object, bounce off it
	var h_speed = lengthdir_x(move_speed,move_dir);
	var v_speed = lengthdir_y(move_speed,move_dir);
	
	if(just_finished_level == true)
	{		
		if(obj_hole.has_created_hole_collider == false)
		{
			move_dir = point_direction(x,y,obj_hole.x,obj_hole.y);
			move_speed += 0.1;
			move_speed = min(move_speed,to_be_in_hole_speed_entry_threshold);
		}	
		else
		{
			//move_dir = 270;
			//move_speed = min(move_speed,to_be_in_hole_speed_entry_threshold);
			current_time_in_hole += 1;
			
			//nudge it downwards
			var dir_sign = scr_sign_to_direction(move_dir,270);
			move_dir += 10 * dir_sign;
			//mask_index = spr_blank;
		}
		
		in_hole_time_animation_ratio = (current_time_in_hole/total_time_in_hole_animation);
		
		var in_hole_ratio = 1.0 - in_hole_time_animation_ratio;
		in_hole_ratio = max(in_hole_ratio,0.65);
		
		
		
		image_xscale = in_hole_ratio;
		image_yscale = in_hole_ratio;
	
	}
	
	var hor_dir = sign(h_speed);
	var ver_dir = sign(v_speed);
	
	var has_collided_with_solid = false;
	

	//horizontal movement + collisions
	if(hor_dir != 0)
	{
		if(place_meeting(x + h_speed,y,obj_solid))
		{
			has_collided_with_solid = true;
			
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
			has_collided_with_solid = true;
			
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
	
	#region reflection math 
		if(has_collided_with_solid == true)
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
			var bounce_friction = 0.93;
			reflected_vector_array[0] = -bounce_friction * (projected_vector_array[0] - remaining_w_vector_array[0]);
			reflected_vector_array[1] = -bounce_friction * (projected_vector_array[1] - remaining_w_vector_array[1]);
		
			var debug_test_init_length = move_speed;
			var remaining_reflected_vector_length = sqrt(sqr(reflected_vector_array[0]) + sqr(reflected_vector_array[1]));
		
			move_speed = remaining_reflected_vector_length;
			move_dir = point_direction(x,y,x + reflected_vector_array[0],y + reflected_vector_array[1]);
		}
	#endregion

	//friction 
	move_speed *= 0.982;
	
	
	if(can_hit_ball == false and move_speed <= (max_move_speed * 0.01))
	{
		pulling_ball_back = false;
		move_speed = 0;
		can_hit_ball = true;
	}	
#endregion
