// Evento Draw do obj_caixa_dialogo_cofre

// Define as coordenadas da caixa de diálogo no centro da tela
var box_x = room_width / 2;
var box_y = room_height / 2;
var box_width = 400;
var box_height = 120;

// Desenha a caixa de fundo
draw_set_color(c_black);
draw_rectangle(box_x - box_width / 2, box_y - box_height / 2, box_x + box_width / 2, box_y + box_height / 2, false);
draw_set_color(c_white);
draw_rectangle(box_x - box_width / 2, box_y - box_height / 2, box_x + box_width / 2, box_y + box_height / 2, true);

// Define a fonte e o alinhamento
draw_set_font(fnt_carteira);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Desenha a pergunta e o valor da carteira (usando a variável global correta)
draw_text(box_x, box_y - 35, "Voce quer guardar os R$" + string(global.carteira));
draw_text(box_x, box_y - 10, " da corrida?");
// Desenha os botões
// 'Sim'
var sim_x = box_x - 50;
var sim_y = box_y + 20;
var sim_width = 40;
var sim_height = 20;
draw_text(sim_x, sim_y, "Sim");

// 'Nao'
var nao_x = box_x + 50;
var nao_y = box_y + 20;
var nao_width = 40;
var nao_height = 20;
draw_text(nao_x, nao_y, "Não");