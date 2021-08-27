
//backing
var button_w = 300 * gui_scale;
var button_h = 150 * gui_scale;
var button_gap_h = button_h * 0.4;
var total_button_ver_length = (button_h * total_buttons) + (button_gap_h * (total_buttons - 1));
var button_starting_x = round((gui_w/2) - (button_w/2));
var button_starting_y = (gui_h/2) - (total_button_ver_length/2);


draw_set_halign(fa_center);
draw_set_valign(fa_middle);


for(var i = 0; i < total_buttons; i += 1;)
{
	var this_button_offset_y = (button_h + button_gap_h) * i;
	
	var cursor_inside = scr_check_collision(true,button_starting_x,button_starting_y + this_button_offset_y,button_w,button_h,0,spr_white,obj_cursor);
	
	if(cursor_inside)
	{
		current_selected_button = i;
		
		if(mouse_check_button_pressed(mb_left))
		{
			clicked_a_button = true;
		}
	}

	//backing
	scr_draw_9slice(spr_9slice_button,0, button_starting_x,button_starting_y + this_button_offset_y,button_starting_x + button_w,button_starting_y + button_h + this_button_offset_y);
										
	//text
	//font
	var text_scale = 2;
	draw_text_ext_transformed(button_starting_x + (button_w/2), button_starting_y + (button_h/2) + this_button_offset_y - (font_pad_ver * gui_scale * text_scale),string(button_text_array[i]),0,button_w,text_scale,text_scale,0);
	
}

