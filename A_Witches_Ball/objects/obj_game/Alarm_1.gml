///@description ROUND OVER

var current_room_name_string = room_get_name(room);
var current_room_level = string_digits(current_room_name_string);
var next_room_name_str = "room_level_" + string(real(current_room_level) + 1);


var debug_test = true;

//string

round_over = false;
stroke_counter = 0;

if(room == room_level_1)
{
	room_goto_next();
}
else
{
	room_goto(room_level_1);
}