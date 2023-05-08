strTo = "To: "+ string(x_to) + " " + string(y_to)
strPos = "Position: " + string(x_pos) + " " + string(y_pos)
strFrom = "From: " + string(x_from) + " " + string(y_from)
strState = "State: " + string(state)
strInBattle = "In Battle = " + string(inBattle)

draw_text(room_width - 10, room_height - 40, strTo)
draw_text(room_width - 20, room_height - 30, strPos)
draw_text(room_width - 10, room_height - 50, strFrom)
draw_text(room_width - 10, room_height - 60, strState)
draw_text(room_width - 10, room_height - 70, strInBattle)

