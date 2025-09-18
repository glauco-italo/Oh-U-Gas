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

// === Lógica de desenho para o upgrade disponível ===
var button_x = box_x;
var button_y = box_y;
var button_width = 350;
var button_height = 80;
var texto_botao = "";

switch (upgrade_disponivel) {
    case "economia":
        texto_botao = "Melhorar Economia \nde Gasolina\nCusto: R$" + string(custo_upgrade_economia);
        break;
    case "capacidade":
        texto_botao = "Capacidade +1 Butijao\nCusto: R$" + string(custo_upgrade_capacidade);
        break;
     case "economia_lv2":
        // NOVO: Texto e custo para o novo upgrade
        texto_botao = "Melhoria de Gasolina LV2\nCusto: R$" + string(custo_upgrade_economia_lv2);
        break;
     case "capacidade_lv2":
        // NOVO: Texto e custo para o novo upgrade
        texto_botao = "Capacidade +1 Butijao LV2\nCusto: R$" + string(custo_upgrade_capacidade_lv2);
        break;
    case "nenhum":
        texto_botao = "Todos os upgrades \nja foram comprados!";
        break;
}

// Desenha o botão de upgrade
if (upgrade_disponivel != "nenhum") {
    draw_set_color(c_green);
    draw_roundrect(button_x - button_width / 2, button_y - button_height / 2, button_x + button_width / 2, button_y + button_height / 2, false);
    draw_set_color(c_black);
    draw_roundrect(button_x - button_width / 2, button_y - button_height / 2, button_x + button_width / 2, button_y + button_height / 2, true);

    draw_set_font(fnt_carteira);
    draw_set_color(c_white);
    draw_text(button_x, 350, texto_botao);
} else {
    // Desenha uma mensagem se não houver mais upgrades
    draw_set_font(fnt_carteira);
    draw_set_color(c_white);
    draw_text(button_x, 350, texto_botao);
}

// === Desenha a mensagem de feedback ===
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