//draw shadow
if(just_finished_level == false)
{
	
	draw_sprite(spr_ball_shadow,0,x,y + sprite_yoffset);
}


//draw ball itself
shader_set(shader_gradient_transparent);
	var uv = sprite_get_uvs(sprite_index, image_index);
	shader_set_uniform_f(_uniUV, uv[1], uv[3]);
	if(in_hole_time_animation_ratio == 0)
	{
		shader_set_uniform_f(_uni_fade_start,0.0);
	}
	else
	{
		shader_set_uniform_f(_uni_fade_start,0.35);
	}
	shader_set_uniform_f(_uni_fade_end,in_hole_time_animation_ratio);
	draw_self();
shader_reset();


if(just_finished_level == false)
{
	#region pull back indicator + aim indicator
		if(pulling_ball_back == true)
		{
			//tongue
			var dir_to_mouse = point_direction(x,y,cursor_x,cursor_y);
			var pull_back_amount = clamp(point_distance(x,y,cursor_x,cursor_y) - starting_dist_to_ball,0,max_dist_to_ball);	
			var striking_power_ratio = min(pull_back_amount/max_dist_to_ball,1);
			var total_frames = sprite_get_number(spr_pull_back_indicator_tongue);
			var frame_to_segment_length = max_dist_to_ball/total_frames;
			var current_frame = min(pull_back_amount div frame_to_segment_length,total_frames - 1);
			last_pull_back_frame = current_frame;
			//tongue
			draw_sprite_ext(spr_pull_back_indicator_tongue,current_frame,x + lengthdir_x(25,dir_to_mouse),y + lengthdir_y(25,dir_to_mouse),1,1,dir_to_mouse - 180,c_white,1);

	
			//ring (where your finger will be)
			draw_sprite(spr_pull_back_indicator_ring,current_frame,x + lengthdir_x(min(pull_back_amount + starting_dist_to_ball,max_dist_to_ball + starting_dist_to_ball),dir_to_mouse),y + lengthdir_y(min(pull_back_amount + starting_dist_to_ball,max_dist_to_ball + starting_dist_to_ball),dir_to_mouse));
	
	
	
			#region draw aim assist arrow
		
				var aim_indicator_arrow_w = sprite_get_width(spr_fx_ball_dir_indicator);
				var aim_indicator_arrow_h = sprite_get_height(spr_fx_ball_dir_indicator);
				var arrow_separation_amount = aim_indicator_arrow_w + 4;
				var total_arrows = 4;
			
				//project line and tell me length
				//var has_collided = scr_check_collision(false,x,
				//y ,(total_arrows * arrow_separation_amount) + starting_dist_to_ball,aim_indicator_arrow_h/sprite_get_height(spr_util_collision),dir_to_mouse - 180,spr_util_collision,obj_solid);
		
				//var total_retracted_amount = arrow_separation_amount * 0;
				//if(has_collided == true)
				//{
				//	with(obj_utility_collision)
				//	{
				//		mask_index = spr_util_collision;
						
				//		while(place_meeting(x,y,obj_solid))
				//		{
				//			image_xscale -= 1;
				//			//image_yscale -= 1;
				//			total_retracted_amount += 1;
				//		}
				//	}
				//}
				var total_retracted_amount = 0;
				
				for(var i = 0; i < 144; i += 1;)
				{
					
					//var has_collided = scr_check_collision(false,x,
					//y ,(total_retracted_amount) + starting_dist_to_ball,aim_indicator_arrow_h/sprite_get_height(spr_util_collision),dir_to_mouse - 180,spr_util_collision,obj_solid);
	
					//if(has_collided == false)
					
					if(!position_meeting(x + lengthdir_x(total_retracted_amount + starting_dist_to_ball,dir_to_mouse - 180),y + lengthdir_y(total_retracted_amount + starting_dist_to_ball,dir_to_mouse - 180),obj_solid))
					{
						total_retracted_amount += 1;
					}
					else
					{
						break;
					}
				}
				
				total_retracted_amount = 144 - total_retracted_amount;
			
		
				var surf_w = max(0,(total_arrows * arrow_separation_amount) - total_retracted_amount);
				if(surf_w > 0)
				{
					surface_resize(surf,surf_w,aim_indicator_arrow_h);		
					surface_set_target(surf);		
					draw_clear_alpha(c_black, 0);
					var starting_arrow_x = -arrow_separation_amount + aim_assist_arrow_anim_pos;
					var this_arrow_y = aim_indicator_arrow_h/2;
			
					for(var i = 0; i < total_arrows + 1; i += 1;)
					{
						var this_arrow_x = starting_arrow_x + (i * arrow_separation_amount);
						draw_sprite(spr_fx_ball_dir_indicator,current_frame,this_arrow_x,this_arrow_y);
					}
			
					aim_assist_arrow_anim_pos += 1;
					//reset anim so it can loop
					if(aim_assist_arrow_anim_pos == arrow_separation_amount)
					{
						aim_assist_arrow_anim_pos = 0;
					}
			
					surface_reset_target();
					draw_surface_ext(surf,x + lengthdir_x(starting_dist_to_ball,dir_to_mouse - 180) + lengthdir_x(aim_indicator_arrow_h/2,dir_to_mouse - 90),y + lengthdir_y(starting_dist_to_ball,dir_to_mouse - 180) + lengthdir_y(aim_indicator_arrow_h/2,dir_to_mouse - 90),1,1,dir_to_mouse - 180,c_white,1);
				}
			#endregion
	
		}
	#endregion



	if(play_fire_ball_animation == true)
	{		
		if(last_pull_back_frame <= 0)
		{
			//apply the balls force	
			move_dir = launch_stroke_dir;
			move_speed = launch_striking_power;
			can_hit_ball = false;
			stroke_counter += 1;
			play_fire_ball_animation = false;
			play_band_slap_hit_effect = true;
			band_slap_pos_x = x;
			band_slap_pos_y = y;
		}
	
		//tongue
		draw_sprite_ext(spr_pull_back_indicator_tongue,last_pull_back_frame,x + lengthdir_x(25,launch_stroke_dir - 180),y + lengthdir_y(25,launch_stroke_dir - 180),1,1,launch_stroke_dir,c_white,1);
		last_pull_back_frame -= launch_ball_animation_speed;	
	}



	//hit effect after band slaps ball
	if(play_band_slap_hit_effect == true)
	{	
		if(current_band_slap_fx_anim_frame < 0)
		{
			//reset
			play_band_slap_hit_effect = false;
			current_band_slap_fx_anim_frame = sprite_get_number(spr_fx_init_hit_ball_base);
		}
	
	
		draw_sprite_ext(spr_fx_init_hit_ball_base,current_band_slap_fx_anim_frame,band_slap_pos_x + lengthdir_x(25,launch_stroke_dir - 180),band_slap_pos_y + lengthdir_y(25,launch_stroke_dir - 180),1,1,launch_stroke_dir,c_white,1);
		current_band_slap_fx_anim_frame -= band_slap_animation_speed;
	}




	//ball grab parameter indicator
	if(can_hit_ball == true and pulling_ball_back == false and play_band_slap_hit_effect == false and play_fire_ball_animation == false)
	{
		ball_grab_indicator_dir += 0.8;
		draw_sprite_ext(spr_fx_ball_grab_indicator,0,x,y,1,1,ball_grab_indicator_dir,c_white,1);
	}
}






