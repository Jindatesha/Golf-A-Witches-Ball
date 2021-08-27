if(other.move_speed <= other.max_move_speed * 0.07)
{
	obj_game.round_over = true;
	obj_game.alarm[1] = 1;
}