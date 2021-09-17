
depth = -1000;

max_move_speed = players_max_move_speed;
move_speed = 0;

mask_height = sprite_get_height(mask_index);

move_dir = 0;
aim_assist_arrow_dir = 0;
show_aim_assist_arrow = false;
can_hit_ball = true;
max_dist_to_ball = 325;
starting_dist_to_ball = sprite_get_width(spr_ball_base)/2;
debug_striking_power_ratio = 0;



pulling_ball_back = false;



last_pull_back_frame = 0;
play_fire_ball_animation = false;
launch_stroke_dir = 0;
launch_striking_power = 0;
launch_ball_animation_speed = 0;

//band slap fx
play_band_slap_hit_effect = false;
band_slap_pos_x = x;
band_slap_pos_y = y;
band_slap_animation_speed = 0;
current_band_slap_fx_anim_frame = sprite_get_number(spr_fx_init_hit_ball_base);

//aim assist arrow
aim_assist_arrow_anim_pos = 0;

//ball grab parimeter indicator
ball_grab_indicator_dir = 0;
init_grab_ball_radius = 210;


//in hole animation
current_time_in_hole = 0;
total_time_in_hole_animation = room_speed * 0.3;
in_hole_time_animation_ratio = current_time_in_hole/total_time_in_hole_animation;
_uniUV = shader_get_uniform(shader_gradient_transparent, "u_uv");
_uni_fade_end = shader_get_uniform(shader_gradient_transparent, "fade_end");
_uni_fade_start = shader_get_uniform(shader_gradient_transparent, "fade_start");

