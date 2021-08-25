// Inherit the parent event
event_inherited();




if(display_was_hit_effects)
{

	shader_set(shader_got_hit);
}


if(state == ENEMY_STATE.ATTACKING)
{
	var wat_dis = (180 * abs(sign(image_xscale - 1))); 
	draw_sprite_ext(weapon_attack_sprite,image_index,x,y,image_xscale,image_yscale,attack_dir - wat_dis,c_white,image_alpha);
}


shader_reset();





