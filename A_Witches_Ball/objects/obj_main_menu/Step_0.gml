
var button_up = keyboard_check_pressed(vk_up);
var button_down = keyboard_check_pressed(vk_down);
var button_enter = keyboard_check_pressed(vk_enter);

if(button_enter)
{
	clicked_a_button = true;	
}




if(clicked_a_button)
{
	switch(current_selected_button)
	{
		case 0:
			room_goto(room_level_1);
		break
		
		case 1:
			//scr_toggle_settings_menu();
		break
		
		case 2:
			game_end();
		break
	}	
}



if (button_up == true)
{
	current_selected_button -= 1;
	
	if (current_selected_button < 0)
	{
		current_selected_button = total_buttons - 1;
	}
}



if (button_down == true)
{
	current_selected_button += 1;
	
	if (current_selected_button > total_buttons - 1)
	{
		current_selected_button = 0;
	}
}


