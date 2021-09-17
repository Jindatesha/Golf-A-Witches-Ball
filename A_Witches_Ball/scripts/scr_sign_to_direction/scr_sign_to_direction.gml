function scr_sign_to_direction(_current_dir,_target_dir)
{
	var dir_sign = 1;
	var opposite_of_target_dir = (_target_dir - 180);
	if(sign(opposite_of_target_dir) == -1)
	{
		opposite_of_target_dir = 360 + sign(opposite_of_target_dir);
	}
			
	if(_current_dir < opposite_of_target_dir)
	{
		dir_sign = -1;
	}
	
	return dir_sign;
}