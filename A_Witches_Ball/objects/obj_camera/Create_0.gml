//this obj controls our camera, how much we see in room, resolution, pan speed


//for (enum)PIXEL_SCALING_TYPE...we can:

//popular choices   
//BASE_MAINTAIN: keep base aspect ratio -> scale to any size but maintain aspect ratio = have potential black bars , full screen has no black bars unless monitor aspect ratio != base aspect ratio
//NEW_MAINTAIN: change aspect ratio to match monitor -> scale to any size but maintain aspect ratio = have potential black bars , full screen has no black bars

//BASE_STRETCH: keep base aspect ratio -> scale to any size WITHOUT needing to maintain apsect ratio = NO black bars, full screen will have no black bars, will be STRETCHED to fit which could look ugly, doesnt look stretched in full screen unless monitor isnt the same as same resolution or perfectly scaled as base game
//NEW_STRETCH: change aspect ratio to match monitor -> scale to any size WITHOUT needing to maintain apsect ratio = NO black bars, full screen will have no black bars, will be STRETCHED to fit which could look ugly, doesnt look stretched in full screen


//NOTE: main benefit for keeping base aspect ratio is so there is no pro/con to having a different size monitor (see more on larger monitors)
//NOTE: keeping the aspect ratio may result in black bars but this does NOT ensure scaling is correct...the higher final surface resolution will make broken pixel grid harder to notice 


//this effects the resolution settings and how the game is to be scaled/look on game window 
current_pixel_scaling_type = PIXEL_SCALING_TYPE.BASE_MAINTAIN;//global

//as an additional option you can force to maintain the aspect ratio base/new when scaling to maintain w or h for less black bars till limits
//currently doesnt work for window resizing as its being dragged from window (resizing window event doesnt work...might need a dll or further looking into)
force_aspect_ratio = false;//global

//unpopular: mainly for low res/pixel art/perfect scaling*  (essentially forcing pixel grid which has higher priority than STRETCH)
force_scaling_to_whole_numbers = false;//global

//base view size of what camera sees (designing game around)	
base_game_window_resolution_w = 1080;
base_game_window_resolution_h = 1920;

//cached values for checking window scaling changes per frame if !in_fullscreen
old_window_w = base_game_window_resolution_w * 0.5;//display_get_width();
old_window_h = base_game_window_resolution_h * 0.5;//display_get_height();

//these are for an overlay of a black bar because GUI layer can bleed* into the black bars...for a cool effect but if unintended this will fix
left_right_black_bar_w = 0;
left_right_black_bar_h = 0;
top_bot_black_bar_w = 0;
top_bot_black_bar_h = 0;

//centering window doesnt work in the same frame you are resizing ^
//center it the first time...unless we are going full screen then its also in the script
alarm[0] = 1;

//this is the windowed top bar text (typically title of game)
window_set_caption("A Witch's Ball");



/* make this into global vars in your obj_game controller object

	globalvar view_w;
	globalvar view_h;
	globalvar gui_w;
	globalvar gui_h;
	globalvar force_scaling_to_whole_numbers;
	globalvar force_aspect_ratio;
	globalvar current_pixel_scaling_type;	
	globalvar view_scale_w,view_scale_h,gui_scale,gui_scale;



	//an enum
	enum PIXEL_SCALING_TYPE
	{
		BASE_MAINTAIN,
		BASE_STRETCH,
		NEW_MAINTAIN,
		NEW_STRETCH
	}
	
	
	//macros 
	#macro view view_camera[0]
	#macro view_x camera_get_view_x(view)
	#macro view_y camera_get_view_y(view)

	
	//also need the script:
	scr_change_screen_resolution
*/