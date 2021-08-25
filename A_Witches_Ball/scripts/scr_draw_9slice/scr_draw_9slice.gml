function scr_draw_9slice(spr_index,img_index,x1,y1,x2,y2)
{
	
	x1 = round(x1);
	x2 = round(x2);
	y1 = round(y1);
	y2 = round(y2);
	
	//i might mess with this later idk
	var scale_w = 1;
	var scale_h = 1;
	
	
	//sprite should be divisible by 3
	var section_width = (sprite_get_width(spr_index)/3);
	var section_height = (sprite_get_height(spr_index)/3);
	var section_width_scaled = section_width * scale_w;
	var section_height_scaled = section_height * scale_h;
	var length_to_be_bridged_w = abs((x2 - x1) - (section_width_scaled * 2));
	var length_to_be_bridged_h = abs((y2 - y1) - (section_height_scaled * 2));
	var bridged_length_scale_w = length_to_be_bridged_w/section_width;
	var bridged_length_scale_h = length_to_be_bridged_h/section_height;
	
	//var whole_segments_requiredw = length_to_be_bridged_w div section_width_scaled;
	//var whole_segments_requiredh = length_to_be_bridged_h div section_height_scaled;
	//var portion_segments_requiredw = (length_to_be_bridged_w / section_width) - (whole_segments_requiredw * scale_w);
	//var portion_segments_requiredh = (length_to_be_bridged_h / section_height) - (whole_segments_requiredh * scale_h);
	
	#region draw the corners
		//topleft
		draw_sprite_part_ext(spr_index,img_index,0,0,section_width,section_height,x1,y1,scale_w,scale_h,c_white,1);
		//topright
		draw_sprite_part_ext(spr_index,img_index,section_width * 2,0,section_width,section_height,x2 - section_width_scaled,y1,scale_w,scale_h,c_white,1);
		//botleft
		draw_sprite_part_ext(spr_index,img_index,0,section_height * 2,section_width,section_height,x1,y2 - section_height_scaled,scale_w,scale_h,c_white,1);
		//botright
		draw_sprite_part_ext(spr_index,img_index,section_width * 2,section_height * 2,section_width,section_height,x2 - section_width_scaled,y2 - section_height_scaled,scale_w,scale_h,c_white,1);
	#endregion
	
	
	
	#region draw the sides
	
		//top
		draw_sprite_part_ext(spr_index,img_index,section_width,0,section_width,section_height,x1 + section_width_scaled,y1,bridged_length_scale_w,1,c_white,1);
		//bot
		draw_sprite_part_ext(spr_index,img_index,section_width,section_height * 2,section_width,section_height,x1 + section_width_scaled,y2 - section_height,bridged_length_scale_w,1,c_white,1);
		//left
		draw_sprite_part_ext(spr_index,img_index,0,section_height,section_width,section_height,x1,y1 + section_height,1,bridged_length_scale_h,c_white,1);
		//right
		draw_sprite_part_ext(spr_index,img_index,section_width * 2,section_height,section_width,section_height,x2 - section_width,y1 + section_height,1,bridged_length_scale_h,c_white,1);

	#endregion
	
	
	#region fill the center
	
		draw_sprite_part_ext(spr_index,img_index,section_width,section_height,section_width,section_height,x1 + section_width_scaled,y1 + section_height_scaled,bridged_length_scale_w,bridged_length_scale_h,c_white,1);
	
	#endregion
	
	
	#region old 
	/*
	
	#region draw the parameter side lines
		
		//i sperated them to account for the sprite not being a square
		
		for(var i = 0; i < whole_segments_requiredw; i += 1)
		{
			//top
			draw_sprite_part_ext(spr_index,img_index,section_width,0,section_width,section_height,x1 + section_width_scaled + (section_width_scaled * i),y1,scale_w,scale_h,c_white,1);
			//bot
			draw_sprite_part_ext(spr_index,img_index,section_width,section_height * 2,section_width,section_height,x1 + section_width_scaled + (section_width_scaled * i),y2 - section_height_scaled,scale_w,scale_h,c_white,1);
		}
		
		//now draw the last portion if there is one
		if portion_segments_requiredw != 0
		{
			var whole_parts_scaled_1 = portion_segments_requiredw div 1;
			var portion_parts_scaled_1 = portion_segments_requiredw mod 1;
			
			for (var s = 0; s < whole_parts_scaled_1; s += 1;)
			{
				//top
				draw_sprite_part_ext(spr_index,img_index,section_width,0,section_width,section_height,x1 + section_width_scaled + (section_width_scaled * i) + (section_width * s),y1,1,scale_h,c_white,1);
				//bot
				draw_sprite_part_ext(spr_index,img_index,section_width,section_height * 2,section_width,section_height,x1 + section_width_scaled + (section_width_scaled * i) + (section_width * s),y2 - section_height_scaled,1,scale_h,c_white,1);
			}
			
				//top
				draw_sprite_part_ext(spr_index,img_index,section_width,0,section_width * portion_parts_scaled_1,section_height,x1 + section_width_scaled + (section_width_scaled * i) + (section_width * s),y1,1,scale_h,c_white,1);
				//bot
				draw_sprite_part_ext(spr_index,img_index,section_width,section_height * 2,section_width * portion_parts_scaled_1,section_height,x1 + section_width_scaled + (section_width_scaled * i) + (section_width * s),y2 - section_height_scaled,1,scale_h,c_white,1);

			
		}
		

		
		
		for(var i = 0; i < whole_segments_requiredh; i += 1)
		{
			//left
			draw_sprite_part_ext(spr_index,img_index,0,section_height,section_width,section_height,x1,y1 + section_height_scaled + (section_height_scaled * i),scale_w,scale_h,c_white,1);
		
			//right
			draw_sprite_part_ext(spr_index,img_index,section_width * 2,section_height,section_width,section_height,x2 - section_width_scaled,y1 + section_height_scaled + (section_height_scaled * i),scale_w,scale_h,c_white,1);
		}
		
		//now draw the last portion if there is one
		if portion_segments_requiredh != 0
		{
			
			var whole_parts_scaled_1 = portion_segments_requiredh div 1;
			var portion_parts_scaled_1 = portion_segments_requiredh mod 1;
			
			//fraction of the scaled amount but still a whole compared to the sprite we are drawing
			for (var s = 0; s < whole_parts_scaled_1; s += 1;)
			{			
				//left
				draw_sprite_part_ext(spr_index,img_index,0,section_height,section_width,section_height,x1,y1 + section_height_scaled + (section_height_scaled * i) + (section_height * s),scale_w,scale_h,c_white,1);
		
				//right
				draw_sprite_part_ext(spr_index,img_index,section_width * 2,section_height,section_width,section_height,x2 - section_width_scaled,y1 + section_height_scaled + (section_height_scaled * i) + (section_height * s),scale_w,scale_h,c_white,1);
			}
			
			
			//actual fraction
			//left
			draw_sprite_part_ext(spr_index,img_index,0,section_height,section_width,section_height * portion_parts_scaled_1,x1,y1 + section_height_scaled + (section_height_scaled * i) + (section_height * s),scale_w,scale_h,c_white,1);
		
			//right
			draw_sprite_part_ext(spr_index,img_index,section_width * 2,section_height,section_width,section_height * portion_parts_scaled_1,x2 - section_width_scaled,y1 + section_height_scaled + (section_height_scaled * i) + (section_height * s),scale_w,scale_h,c_white,1);

		
		}
		
		
	#endregion
	
	#region draw the center of the image
	
		for(var w = 0; w < whole_segments_requiredw; w += 1;)
		{
			for(var h = 0; h < whole_segments_requiredh; h += 1;)
			{
				//center
				draw_sprite_part_ext(spr_index,img_index,section_width,section_height,section_width,section_height,x1 + section_width_scaled + (section_width_scaled * w),y1 + section_height_scaled + (section_height_scaled * h),scale_w,scale_h,c_white,1);
			}
		}
		
		
		
		//now draw the last portion if there is one
		if portion_segments_requiredw != 0
		{
			/*	-
				-
				-
				-
			*/
			/*
			var whole_parts_scaled_1 = portion_segments_requiredw div 1;
			var portion_parts_scaled_1 = portion_segments_requiredw mod 1;
			
			for (var s = 0; s < whole_parts_scaled_1; s += 1;)
			{
				for(var r = 0; r < whole_segments_requiredh + (ceil(portion_segments_requiredh)); r += 1;)
				{
					//hor filling
					draw_sprite_part_ext(spr_index,img_index,section_width,section_height,section_width,section_height,x1 + section_width_scaled + (section_width_scaled * w) + (section_width * s),y1 + section_height_scaled + (section_height_scaled * r),1,scale_h,c_white,1);					
				}
			}
			
			
			
			for(var r = 0; r < whole_segments_requiredh + (ceil(portion_segments_requiredh)); r += 1;)
			{
				//hor filling
				draw_sprite_part_ext(spr_index,img_index,section_width,section_height,section_width * portion_parts_scaled_1,section_height,x1 + section_width_scaled + (section_width_scaled * w) + (section_width * s),y1 + section_height_scaled + (section_height_scaled * r),1,scale_h,c_white,1);
			}
			

		}
		
		
		
		
		//now draw the last portion if there is one
		if portion_segments_requiredh != 0
		{
			/* 
			
				-----
				
			*/
			/*
			var whole_parts_scaled_1 = whole_segments_requiredw div 1;
			var portion_parts_scaled_1 = whole_segments_requiredw mod 1;
			
			for (var s = 0; s < whole_parts_scaled_1; s += 1;)
			{
				for(var c = 0; c < whole_segments_requiredw + (ceil(portion_segments_requiredw)); c += 1;)
				{
					//ver filling
					//draw_sprite_part_ext(spr_index,img_index,section_width,section_height,section_width,section_height,x1 + section_width_scaled + (section_width_scaled * c),y1 + section_height_scaled + (section_height_scaled * h) + (section_height * s),1,scale,c_white,1);
				}	
			}
			
			for(var c = 0; c < whole_segments_requiredw + (ceil(portion_segments_requiredw)); c += 1;)
			{
				//ver filling
				//draw_sprite_part_ext(spr_index,img_index,section_width,section_height,section_width,section_height * portion_parts_scaled_1,x1 + section_width_scaled + (section_width_scaled * c),y1 + section_height_scaled + (section_height_scaled * h) + (section_height * s),1,scale,c_white,1);
			}
		}
		
		
	
	#endregion
	*/
	#endregion
}