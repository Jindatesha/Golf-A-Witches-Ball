if(dead == false)
{
	if(display_was_hit_effects)
	{
		current_hit_shader_time += 1;
	
		if(current_hit_shader_time >= max_hit_shader_time)
		{
			display_was_hit_effects = false;
			current_hit_shader_time = 0;
		}
	
		shader_set(shader_got_hit);
	}

	draw_self();

	shader_reset();



	if(current_health != max_health)
	{
		scr_draw_health();
	}
}
else
{
	draw_self();
}




//mask index
//draw_sprite_ext(mask_index,image_index,x,y,image_xscale,image_yscale,0,c_white,0.6);

