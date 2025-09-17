// Evento Draw GUI do obj_upgrade_manager

var box_x = room_width / 2;
var box_y = room_height / 2;
var box_width = 600;
var box_height = 400;

// Desenha a caixa de fundo
draw_set_color(c_black);
draw_roundrect_ext(box_x - box_width / 2, box_y - box_height / 2, box_x + box_width / 2, box_y + box_height / 2, 20, 20, false);
draw_set_color(c_white);
draw_roundrect_ext(box_x - box_width / 2, box_y - box_height / 2, box_x + box_width / 2, box_y + box_height / 2, 20, 20, true);

// Desenha o título
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(fnt_carteira);
draw_set_color(c_yellow);
draw_text(box_x, box_y - 180, "UPGRADES DO DEPOSITO");

// Desenha o botão de upgrade
var button_x = box_x;
var button_y = box_y;
var button_width = 350;
var button_height = 80;

draw_set_color(c_lime);
draw_roundrect(button_x - button_width / 2, button_y - button_height / 2, button_x + button_width / 2, button_y + button_height / 2, false);
draw_set_color(c_black);
draw_roundrect(button_x - button_width / 2, button_y - button_height / 2, button_x + button_width / 2, button_y + button_height / 2, true);

draw_set_font(fnt_carteira);
draw_set_color(c_white);

// Texto do botão
var texto_botao = "Melhorar Economia \nde Gasolina\nCusto: R$" + string(custo_upgrade_economia);
if (global.economia_melhorada) {
    texto_botao = "Upgrade ja comprado!";
}
draw_text(button_x, 350, texto_botao);

// === Desenha o botão de Upgrade de Capacidade ===
var button2_x = room_width / 2;
var button2_y = room_height / 2 + 100;
var button2_width = 300;
var button2_height = 80;

draw_set_color(c_lime);
draw_roundrect(button2_x - button2_width / 2, button2_y - button2_height / 2, button2_x + button2_width / 2, button2_y + button2_height / 2, false);
draw_set_color(c_black);
draw_roundrect(button2_x - button2_width / 2, button2_y - button2_height / 2, button2_x + button2_width / 2, button2_y + button2_height / 2, true);

draw_set_font(fnt_carteira);
draw_set_color(c_white);

var texto_botao2 = "Capacidade + \nCusto: R$" + string(custo_upgrade_capacidade);
if (global.capacidade_aumentada) {
    texto_botao2 = "Upgrade ja comprado!";
}
draw_text(button2_x, button2_y, texto_botao2);

// Desenha a mensagem de feedback
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(box_x, box_y + 100, feedback_message);

// Desenha o valor no cofre
draw_set_halign(fa_left);
draw_text(box_x - box_width / 2 + 20, box_y + 150, "Cofre: R$" + string(global.dinheiro_no_cofre));

// Instruções para sair
draw_set_halign(fa_right);
draw_text(box_x + box_width / 2 - 20, box_y + 150, "Pressione ESC para voltar");

// Lógica de saída
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_game);
}