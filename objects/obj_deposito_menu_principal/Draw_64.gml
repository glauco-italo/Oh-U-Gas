// Evento Draw GUI do obj_deposito_menu_principal

var box_x = room_width / 2;
var box_y = room_height / 2;
var box_width = 500;
var box_height = 200;

// Desenha a caixa de fundo
draw_set_color(c_black);
draw_roundrect_ext(box_x - box_width / 2, box_y - box_height / 2, box_x + box_width / 2, box_y + box_height / 2, 20, 20, false);
draw_set_color(c_white);
draw_roundrect_ext(box_x - box_width / 2, box_y - box_height / 2, box_x + box_width / 2, box_y + box_height / 2, 20, 20, true);

draw_set_font(fnt_carteira);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(box_x, box_y - 60, "DEPOSITO");

// Desenha o botão "Cofres"
draw_set_color(c_lime);
draw_roundrect_ext(cofre_x - cofre_width / 2, cofre_y - cofre_height / 2, cofre_x + cofre_width / 2, cofre_y + cofre_height / 2, 10, 10, false);
draw_set_color(c_black);
draw_roundrect_ext(cofre_x - cofre_width / 2, cofre_y - cofre_height / 2, cofre_x + cofre_width / 2, cofre_y + cofre_height / 2, 10, 10, true);
draw_set_color(c_white);
draw_text(cofre_x, cofre_y, "COFRE");

// Desenha o botão "Upgrades"
draw_set_color(c_lime);
draw_roundrect_ext(upgrades_x - upgrades_width / 2, upgrades_y - upgrades_height / 2, upgrades_x + upgrades_width / 2, upgrades_y + upgrades_height / 2, 10, 10, false);
draw_set_color(c_black);
draw_roundrect_ext(upgrades_x - upgrades_width / 2, upgrades_y - upgrades_height / 2, upgrades_x + upgrades_width / 2, upgrades_y + upgrades_height / 2, 10, 10, true);
draw_set_color(c_white);
draw_text(upgrades_x, upgrades_y, "UPGRADES");

// Instruções para sair
draw_set_halign(fa_right);
draw_text(room_width - 20, room_height - 20, "Pressione ESC para voltar");