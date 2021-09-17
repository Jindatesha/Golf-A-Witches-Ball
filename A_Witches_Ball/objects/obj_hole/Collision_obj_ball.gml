
if(just_finished_level == false and other.move_speed <= to_be_in_hole_speed_entry_threshold)
{
	just_finished_level = true;
	obj_game.alarm[1] = room_speed * 2;
}


