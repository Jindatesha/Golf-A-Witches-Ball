
//changes resolution of the game (resizes: window, application surface, gui_surface, view(this only gets changed first time its ran))

function scr_change_screen_resolution(window_resolution_w,window_resolution_h)
{	
	
	//compares against window to see if we scaled at all
	old_window_w = window_resolution_w;
	old_window_h = window_resolution_h;
		
	//if minimized or player shrinks window too small, wont allow it and potentially crash 
	if (window_resolution_w <= 0 or window_resolution_h <= 0) exit;
	
	//lets also make sure the new resolution cant be larger than the display
	window_resolution_w = min(window_resolution_w, display_get_width());
	window_resolution_h = min(window_resolution_h, display_get_height());
	
	
	with(obj_camera)
	{
		//base view size of what camera sees (designing game around)	
		var ideal_w = base_game_window_resolution_w;
		var ideal_h = base_game_window_resolution_h;
		
		//only change the aspect ratio of the game if thats the type of scaling we want
		if (current_pixel_scaling_type == PIXEL_SCALING_TYPE.NEW_MAINTAIN or current_pixel_scaling_type == PIXEL_SCALING_TYPE.NEW_STRETCH)
		{
			var my_aspect_ratio = display_get_width()/display_get_height();
		
			//we will keep the height locked and the same on every monitor changing the width of the view to match their aspect ratio (switch this to height if you have a portrait/mobile game)
			ideal_w = round(ideal_h * my_aspect_ratio);
		
			//make sure no odd number of pixels
			if (ideal_w mod 2)
			{
				ideal_w += 1;
			}
		}
		
		
		//now scale their resolution to try and get as close to the baseview sizes that can match their apsect ratio
		
		//views = how much camera SEES
		//NOTE: you either lock this and change the application surface for higher res but youll maintain aspect ratio giving black bars
		//or you change the view to prevent black bars but you will see more/less
		
		//view_w = ideal_w;
		//view_h = ideal_h;		
		
		
		var final_surface_w = window_resolution_w;
		var final_surface_h = window_resolution_h;
		
		
		//if nothing changed base scale = 1		
		var new_view_scale_w = (window_resolution_w/ideal_w);
		var new_view_scale_h = (window_resolution_h/ideal_h);
		
		//this retains the aspect ratio 
		if(current_pixel_scaling_type == PIXEL_SCALING_TYPE.BASE_MAINTAIN or current_pixel_scaling_type == PIXEL_SCALING_TYPE.NEW_MAINTAIN)
		{

			//if (force_scaling_to_whole_numbers)
			
			new_view_scale_w = round(new_view_scale_w);
			new_view_scale_h = round(new_view_scale_h);
						
			
			//what changed more the width of the window or the height?					
			if (new_view_scale_w > new_view_scale_h)
			{	
				//if ive scaled the height down more than the width, the limiting factor would be the height
				//or if ive scaled the width UP more than the height, same thing -> limiting factor is the height to maintain aspect ratio
				new_view_scale_w = new_view_scale_h;
			}
			else
			{		
				//if ive scaled the width down more than the height, the limiting factor would be the width
				new_view_scale_h = new_view_scale_w;
			}
		}
				
					
		//NOTE: having a max* will essentially a minimum amount it can scale to / smallest resolution supported
		view_scale_w = max(1,new_view_scale_w);
		view_scale_h = max(1,new_view_scale_h);
		final_surface_w = round(ideal_w * view_scale_w);
		final_surface_h = round(ideal_h * view_scale_h);
				
				
	
		//how large the game window is...not stretched but potential black bars
		window_set_size(window_resolution_w,window_resolution_h);
		
		
		
		//resize our application surface, giving us proper screen scaling + added performance
		
		//your camera/view is going to be stretched across the window
		//by having the highest whole scaling multiplier from original camera/view you are gaining pixel density (smoother movement) AND without losing any detail
		surface_resize(application_surface,final_surface_w,final_surface_h);

		

		
		//NOTE: sprites on GUI layer CAN spill over into the black bars...
		display_set_gui_size(window_resolution_w,window_resolution_h);
		

		
		//set size of view in camera (what it sees)
		camera_set_view_size(view, ideal_w, ideal_h);
		

		

		
		//this updates black bar width/heights	
		var size_diff_w = (window_resolution_w - final_surface_w);
		var size_diff_h = (window_resolution_h - final_surface_h);
		
		left_right_black_bar_w = (size_diff_w/2);
		left_right_black_bar_h = window_resolution_h;
		top_bot_black_bar_w = window_resolution_w;
		top_bot_black_bar_h = (size_diff_h/2);
		
		var deviation_multiplier_w = (window_resolution_w/base_game_window_resolution_w);
		var deviation_multiplier_h = (window_resolution_h/base_game_window_resolution_h);
		
		if (deviation_multiplier_w > deviation_multiplier_h)
		{
			//larger width = limiting factor is the height = height is stretched as far is it can go to maintain AR = black bars on width
			//dont show any black bars on our top/bot 
			top_bot_black_bar_h = 0;
		}
		else
		{
			left_right_black_bar_w = 0;
		}
		
		//resize our gui surface, giving us proper gui scaling + added performance	
		//var pos = application_get_position();
		var gui_starting_x = max(0,left_right_black_bar_w);
		var gui_starting_y = max(0,top_bot_black_bar_h);
		
		
		display_set_gui_maximise(1,1,gui_starting_x,gui_starting_y);
		
		//set the final gui's width and height		
		var new_gui_w = window_resolution_w - (gui_starting_x * 2);
		var new_gui_h = window_resolution_h - (gui_starting_y * 2);
		
		display_set_gui_size(new_gui_w,new_gui_h);
		
		//gui is separated out just in case you want a different scale	
		gui_scale = new_gui_w/base_game_window_resolution_w;
		gui_scale = new_gui_h/base_game_window_resolution_h;
	}
}