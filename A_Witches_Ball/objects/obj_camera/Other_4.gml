view_enabled = true;
view_visible[0] = true;

//anti aliasing level...0 = off (meant for pixel art)
draw_set_swf_aa_level(0);


//retain resolution from last room or initialize resolution if first time running this
scr_change_screen_resolution(old_window_w,old_window_h);

