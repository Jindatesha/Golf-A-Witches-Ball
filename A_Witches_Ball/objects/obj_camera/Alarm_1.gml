	
//resize our gui surface, giving us proper gui scaling + added performance	
var pos = application_get_position();
	
//set the final gui's width and height
//gui_w = pos[2];
//gui_h = pos[3];
		
//gui is separated out just in case you want a different scale	
gui_scale = pos[2]/base_game_window_resolution_w;
gui_scale = pos[3]/base_game_window_resolution_h;
	

	
//NOTE: sprites on GUI layer CAN spill over into the black bars...
display_set_gui_size(pos[2],pos[3]);