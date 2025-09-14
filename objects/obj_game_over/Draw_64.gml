// Evento Draw GUI do obj_game_over

draw_set_color(c_white);
draw_set_font(fnt_game_over);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);


// Adiciona o texto para reiniciar o jogo
draw_text(room_width / 2, room_height / 2 + 50, "Aperte espaco para jogar de novo!");