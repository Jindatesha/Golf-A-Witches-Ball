draw_self();




//draw aim assist arrow
if(show_aim_assist_arrow)
{
	var arrow_length = 20;
	var arrow_size = 4;
	draw_arrow(x,y,x + lengthdir_x(arrow_length,aim_assist_arrow_dir),y + lengthdir_y(arrow_length,aim_assist_arrow_dir),arrow_size);

	draw_text(x + 20,y - 10,"POWER: " + string(debug_striking_power_ratio));
}


