
show_debug_overlay(true);


//all macros
#macro view view_camera[0]
#macro view_x camera_get_view_x(view)
#macro view_y camera_get_view_y(view)
#macro view_w camera_get_view_width(view)
#macro view_h camera_get_view_height(view)

#macro gui_w display_get_gui_width()
#macro gui_h display_get_gui_height()

#macro TILE_SIZE 16



//enums 
enum SETTINGS_CATEGORY
{
	GENERAL,
	MOUSE_AND_KEYBOARD,
	CONTROLLER
}

enum PIXEL_SCALING_TYPE
{
	BASE_MAINTAIN,
	BASE_STRETCH,
	NEW_MAINTAIN,
	NEW_STRETCH
}

enum GAME_STATUS
{
	ACTIVE,
	INACTIVE,
	LOST
}

//globals

//camera
globalvar gui_scale;
gui_scale = 1; 


globalvar current_pixel_scaling_type;
globalvar force_aspect_ratio,force_scaling_to_whole_numbers;



//settings menu
globalvar settings_menu_on;
settings_menu_on = false;



globalvar music_vol;
globalvar sound_vol;
music_vol = 0.5;
sound_vol = 1;



//this is made by "codeman38"
//draw_set_font(font_dp_comic);
draw_set_valign(fa_middle);

globalvar font_pad_ver;
font_pad_ver = 7;


globalvar collision_list;

//cached list for collisions...more performant than re-creating one every time
collision_list = ds_list_create();


globalvar all_structures_grid;
all_structures_grid = ds_grid_create(0,0);



globalvar game_status;
game_status = GAME_STATUS.ACTIVE;


#region buttons
	//get button inputs
	globalvar button_move_left;
	globalvar button_move_right;
	globalvar button_move_up;
	globalvar button_move_down;
	
	globalvar button_left_mouse_pressed;
	globalvar button_right_mouse_pressed;
	globalvar button_left_mouse_released;
	globalvar button_right_mouse_released;
	
	globalvar button_building_menu; //tab
#endregion

globalvar cursor_x, cursor_y,cursor_gui_x,cursor_gui_y;
cursor_x = mouse_x;
cursor_y = mouse_y;


globalvar hovered_over_button;
hovered_over_button = false;


globalvar surf;
surf = surface_create(1,1);






//all structures
//scr_add_structure_to_database_grid(STRUCTURE.WOOD_FENCE,spr_building_fence_mini,spr_building_fence,spr_building_fence_blueprint,STRUCTURE_TYPE.WALL,3);


//create all controllers
instance_create_depth(x,y,depth,obj_camera);
instance_create_depth(x,y,depth,obj_cursor);
instance_create_depth(x,y,depth,obj_utility_collision);

room_goto(room_main_menu);


globalvar round_over;
round_over = false;
globalvar stroke_counter;
stroke_counter = 0;

