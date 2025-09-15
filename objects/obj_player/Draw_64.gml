// Evento Draw GUI do obj_player

// === Código da barra de gasolina ===
var x1 = 50;
var y1 = 50;
var x2 = 80;
var y2 = 250;
var largura = x2 - x1;
var altura_combustivel = (tanque_combustivel / 100) * (y2 - y1);
var y_combustivel = y2 - altura_combustivel;

draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2, true);

draw_set_color(c_green);
if (tanque_combustivel < 30) {
    draw_set_color(c_red);
}
draw_rectangle(x1, y_combustivel, x2, y2, false);

draw_set_color(c_white);
draw_set_font(fnt_tanque);
draw_set_halign(fa_center);
draw_text(x1 + largura/2, y1 - 25, "GASOLINA");

// === Desenhando a Carteira ===
var carteira_x = 50;
var carteira_y = 300;

draw_set_font(fnt_carteira);
draw_set_color(c_yellow);
draw_set_halign(fa_left);
draw_text(carteira_x, carteira_y, "Carteira: R$ " + string(carteira));

// === Desenhando a mensagem de negociação ===
if (estado_jogo == estado.negociando) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_preco);
    if (tem_butijao) {
        draw_text(room_width / 2, room_height / 2, "Cliente! Ofereça um preço:");
        draw_text(room_width / 2 - 100, room_height / 2 + 50, "[A] R$20");
        draw_text(room_width / 2 + 100, room_height / 2 + 50, "[D] R$50");
    } else {
        draw_text(room_width / 2, room_height / 2, "Voce precisa de um butijao para vender!");
    }
}

// === Desenhando o resultado da negociação ===
if (estado_jogo == estado.resultado_negociacao) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_preco);
    draw_text(room_width / 2, room_height / 2, texto_resultado);
}

// NOVO: Mensagens de interação para posto e depósito
var posto_encontrado = noone;
var deposito_encontrado = noone;
var num_fundos = instance_number(obj_fundo);

for (var i = 0; i < num_fundos; i++) {
    var fundo_atual = instance_find(obj_fundo, i);
    if (fundo_atual.is_posto == true) {
        posto_encontrado = fundo_atual;
    }
    if (fundo_atual.is_deposito == true) {
        deposito_encontrado = fundo_atual;
    }
}

// Mensagem de interação do POSTO
if (instance_exists(posto_encontrado) && distance_to_object(posto_encontrado) < raio_colisao && estado_jogo == estado.movendo) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_preco);
    draw_text(room_width / 2, room_height / 2, "Aperte ESPACO para entrar no posto!");
}

// Mensagem de interação do DEPÓSITO
if (instance_exists(deposito_encontrado) && distance_to_object(deposito_encontrado) < raio_colisao && estado_jogo == estado.movendo) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_preco);
    draw_text(room_width / 2, room_height / 2, "Aperte ESPACO para entrar no deposito de gas!");
}


// NOVO: Mensagem do posto no estado "abastecendo" (permanece o mesmo)
if (estado_jogo == estado.abastecendo) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_preco);
   
    draw_text(room_width / 2, room_height / 2, "Bem-vindo ao posto!");
    draw_text(room_width / 2, room_height / 2 + 50, "[D] Abastecer (R$" + string(custo_abastecimento) + ")");
    draw_text(room_width / 2, room_height / 2 + 100, "Pressione ESC para sair.");
}

// NOVO: Mensagem do deposito no estado "comprando_butijao" (permanece o mesmo)
if (estado_jogo == estado.comprando_butijao) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_preco);
   
    draw_text(room_width / 2, room_height / 2, "Bem-vindo ao deposito de gas!");
   
    if (!tem_butijao) {
        draw_text(room_width / 2, room_height / 2 + 50, "[A] Comprar butijao (R$" + string(custo_butijao) + ")");
    } else {
        draw_text(room_width / 2, room_height / 2 + 50, "Voce ja tem um butijao!");
    }
   
    draw_text(room_width / 2, room_height / 2 + 100, "Pressione ESC para sair.");
}