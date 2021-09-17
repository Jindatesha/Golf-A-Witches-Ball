

if(just_finished_level == true and has_created_hole_collider == false)
{
	var collided_with_ball = scr_check_collision(false,x,y,1,1,0,spr_ball_inside_hole_collider,obj_ball);
	if(collided_with_ball == false)
	{
		has_created_hole_collider = true;
		with(obj_ball)
		{
			var dir_sign = scr_sign_to_direction(move_dir,270);
			move_dir += 40 * dir_sign;
		} 
		instance_create_depth(x,y,depth - 1,obj_ball_in_hole_collider);
	}
}




