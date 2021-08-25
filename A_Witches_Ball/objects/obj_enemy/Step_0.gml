
//gimme all the goodies our smackable parent would do too
event_inherited();

//make sure our target still exists...if not find new target
if(!instance_exists(target_id))
{
	reevaluate_target_timer = 0;
	
	//have that fresh target
	target_id = instance_find(obj_teleporter_guy,0);
}


var target_x_difference = target_id.x - x;
var distance_to_target = point_distance(x,y,target_id.x,target_id.y);

//make sure this guy is facing the correct direction
if(state != ENEMY_STATE.ATTACKING)
{
	image_xscale = sign(target_x_difference);
	if (image_xscale == 0) image_xscale = 1;
}


//if the target is within our range; attack him
if(distance_to_target <= my_attack_range and lock_path == false)
{
	if(initiated_attack and attack_cooldown_time > 0)
	{
		state = ENEMY_STATE.IDLE;	
	}
	else
	{
		state = ENEMY_STATE.ATTACKING;	
	}	
}
else
{
	if(state != ENEMY_STATE.ATTACKING)
	{
		state = ENEMY_STATE.RUNNING;	
	}
}


//whether we are running or idle...
if(initiated_attack and state != ENEMY_STATE.ATTACKING)
{
	attack_cooldown_time -= 1;
		
	if(attack_cooldown_time <= 0)
	{
		//we can attack again
		initiated_attack = false;
	}
}

//state machine
switch(state)
{
	case ENEMY_STATE.RUNNING:
		//handles movement + collision checking with solids
		scr_ai_move();
	break;
	
	
	case ENEMY_STATE.IDLE:

	break;
	
	case ENEMY_STATE.ATTACKING:
		if(initiated_attack == false)
		{
			initiated_attack = true;			
		
			attack_dir = point_direction(x,y,target_id.x,target_id.y);
			var hit_something = scr_check_collision(false,x,y,1,1,attack_dir,my_attack_collision_mask,obj_balls_and_structures);
			
			if(hit_something)
			{
				//hit everything 
				scr_register_damage_from_list(all);
			}
		}
		else
		{
			//are we finished with our attack animation
			if(image_index >= image_number - 1)
			{			
				//set it to anything other than ATTACKING and it will get sorted next step
				state = ENEMY_STATE.IDLE;
				
				//set attack CD time...here because if time = 0 then u would attack again AFTER the attack animation anyway
				attack_cooldown_time = max_attack_cooldown_time;
			}
		}
	break;
}




//changes out our sprite index
if(state != old_state)
{
	old_state = state;
	sprite_index = sprite_array[state];
	image_index = 0;
}


