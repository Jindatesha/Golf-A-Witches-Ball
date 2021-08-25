
var button_up = keyboard_check_pressed(vk_up);
var button_down = keyboard_check_pressed(vk_down);
var button_enter = keyboard_check_pressed(vk_enter);

if (button_enter)
{
	clicked_a_button = true;	
}




if (clicked_a_button)
{
	switch(current_set_of_buttons)
	{
		case 1:
			switch(current_selected_button)
			{
				case 0:
					//now have the buttons; HOST & JOIN
					button_text_array[0] = "HOST";
					button_text_array[1] = "JOIN";
					clicked_a_button = false;
					total_buttons = 2;
					current_set_of_buttons = 2;
				break
		
				case 1:
					//scr_toggle_settings_menu();
				break
		
				case 2:
					game_end();
				break
			}
		break;
		
		case 2:
			//heres where matchmaking would come in...where youd queue people up on a server even if using p2p
			game_status = GAME_STATUS.ACTIVE;
			
			switch(current_selected_button)
				{
					case 0:						
						this_player_runs_server = true;
						room_goto(room_level_1);
					break;
					
					case 1:
						this_player_runs_server = false;
						room_goto(room_level_1);
					break;
				}				
		break;
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


