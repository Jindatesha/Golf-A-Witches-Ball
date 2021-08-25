
///@description BLACK BARS
//to retain black bars as a cutoff* similar to a surface...we will draw them =P
//stretching a sprite is supposedly more efficient than creating a primative rectangle


//left
draw_sprite_stretched(spr_black,0,-left_right_black_bar_w,0,left_right_black_bar_w,left_right_black_bar_h);

//right
draw_sprite_stretched(spr_black,0,gui_w,0,left_right_black_bar_w,left_right_black_bar_h);


//top
draw_sprite_stretched(spr_black,0,0,-top_bot_black_bar_h,top_bot_black_bar_w,top_bot_black_bar_h);

//bot
draw_sprite_stretched(spr_black,0,0,gui_h,top_bot_black_bar_w,top_bot_black_bar_h);


