function scr_check_collision(is_gui,col_x,col_y,col_x_scale,col_y_scale,col_image_angle,col_mask_index,col_obj)
{		
	//NOTE: this doesnt take into account different image scales of the object within gui...so if ur checking mouse collision it will be checking the originals size/ its image_x/yscale
	ds_list_clear(collision_list);
	
	with(obj_utility_collision)
	{
		mask_index = col_mask_index;
		sprite_index = col_mask_index;//-1;
		image_angle = col_image_angle;
		image_xscale = col_x_scale;
		image_yscale = col_y_scale;
		x = col_x;
		y = col_y;
				
				
		if(is_gui)
		{
			x = scr_gui_to_coord(true,col_x); 
			y = scr_gui_to_coord(false,col_y);
			image_xscale = col_x_scale / gui_scale;
			image_yscale = col_y_scale / gui_scale;
		}

		//in case u have more than 1 object u are looking to check in this rectangle
		var col_obj_arg_num = 7;
		for(var i = 0; i < argument_count - col_obj_arg_num; i += 1;)
		{
			var this_col_obj = argument[col_obj_arg_num + i];
			instance_place_list(x,y,this_col_obj,collision_list,true);
				
			//take me out of the list if I, the guy trying to hit stuff, out of the list
			var pos = ds_list_find_index(collision_list,id);
			ds_list_delete(collision_list,pos);
		}

		//disable mask so no unintended collisions take place after this
		mask_index = spr_blank;
		
		//if u want to just check if there IS a collision u can check to see if true/false otherwise use the ds_list for more options
		if (ds_list_size(collision_list) > 0)
		{
			return(true);
		}
		else
		{
			return(false);
		}
	}
}