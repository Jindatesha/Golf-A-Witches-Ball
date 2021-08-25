// Inherit the parent event
event_inherited();

//these dont change
initiated_attack = false;
state = ENEMY_STATE.IDLE;
old_state = state;
target_id = obj_teleporter_guy;


//these do depending on enemy type
max_health = 3;
base_move_speed = 0.8;
move_speed = base_move_speed;

my_attack_collision_mask = spr_weapon_axe_collision;
my_attack_range = sprite_get_width(my_attack_collision_mask) * 0.8; //gives us just a bit of leeway room


sprite_array[ENEMY_STATE.IDLE] = spr_enemy_goblin_idle_base;
sprite_array[ENEMY_STATE.RUNNING] = spr_enemy_goblin_run_base;
sprite_array[ENEMY_STATE.ATTACKING] = spr_enemy_goblin_attack_base;


max_attack_cooldown_time = room_speed * 1;
attack_cooldown_time = 0;


my_damage = 1;

max_reevaluate_target_timer = room_speed * 0.25;
reevaluate_target_timer = max_reevaluate_target_timer;


mask_height = sprite_get_height(mask_index);
mask_yoffset = 4;

weapon_attack_sprite = spr_enemy_weapon_goblin_attack_base;

attack_dir = 0;

lock_path = false;


my_looking_dir = 0;
my_boid_vision_distance = 50;

