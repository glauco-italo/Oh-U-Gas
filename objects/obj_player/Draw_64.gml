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
draw_roundrect(x1, y1, x2, y2, false); // Borda arredondada
draw_set_color(c_black);
draw_roundrect(x1, y1, x2, y2, true); // Fundo preto

draw_set_color(c_green);
if (tanque_combustivel < 30) {
    draw_set_color(c_red);
}
draw_roundrect_ext(x1, y_combustivel, x2, y2, 8, 8, false); // Borda arredondada preenchida

draw_set_color(c_white);
draw_set_font(fnt_tanque);
draw_set_halign(fa_center);
draw_text(x1 + largura/2, y1 - 25, "GASOLINA");

// === Desenhando a Carteira ===
var carteira_x = 50;
var carteira_y = 300;
var carteira_largura = 200;
var carteira_altura = 30;

// Desenha a caixa de fundo da carteira
draw_set_color(c_black);
draw_roundrect_ext(carteira_x, carteira_y, carteira_x + carteira_largura, carteira_y + carteira_altura, 10, 10, false);
draw_set_color(c_white);
draw_roundrect_ext(carteira_x, carteira_y, carteira_x + carteira_largura, carteira_y + carteira_altura, 10, 10, true);

// Desenha o texto da carteira
draw_set_font(fnt_carteira);
draw_set_color(c_yellow);
draw_set_halign(fa_left);
draw_text(carteira_x + 10, carteira_y + 15, "Carteira: R$ " + string(global.carteira));

// === Lógica de mensagens centralizadas com caixas arredondadas ===
var msg_x = room_width / 2;
var msg_y = room_height / 2;
var msg_largura = 500;
var msg_altura = 150;
var posto_encontrado = noone;
var deposito_encontrado = noone;
var num_fundos = instance_number(obj_fundo);

// Desenha a caixa de mensagem
if (estado_jogo == estado.negociando || estado_jogo == estado.resultado_negociacao ||
    (instance_exists(posto_encontrado) && distance_to_object(posto_encontrado) < raio_colisao) ||
    (instance_exists(deposito_encontrado) && distance_to_object(deposito_encontrado) < raio_colisao) ||
    estado_jogo == estado.abastecendo || estado_jogo == estado.comprando_butijao)
{
    draw_set_color(c_black);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, false);
    draw_set_color(c_white);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, true);
}

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_carteira);
draw_set_color(c_white);

// Mensagens por estado
switch (estado_jogo) {
    case estado.negociando:
        if (tem_butijao) {
            draw_text(msg_x, msg_y - 30, "Cliente! Ofereca um preco:");
            draw_text(msg_x - 100, msg_y + 30, "[A] R$20");
            draw_text(msg_x + 100, msg_y + 30, "[D] R$50");
        } else {
            draw_text(msg_x, msg_y, "Voce precisa de um butijao para vender!");
        }
        break;
    
    case estado.resultado_negociacao:
        draw_text(msg_x, msg_y, texto_resultado);
        break;
    
    case estado.abastecendo:
        draw_text(msg_x, msg_y - 30, "Bem vindo ao posto!");
        draw_text(msg_x, msg_y + 10, "[D] Abastecer (R$" + string(custo_abastecimento) + ")");
        draw_text(msg_x, msg_y + 40, "Pressione ESC para sair.");
        break;
    
    case estado.comprando_butijao:
        draw_text(msg_x, msg_y - 30, "Bem vindo ao deposito de gas!");
        if (!tem_butijao) {
            draw_text(msg_x, msg_y + 10, "[A] Comprar butijao (R$" + string(custo_butijao) + ")");
        } else {
            draw_text(msg_x, msg_y + 10, "Voce ja tem um butijao!");
        }
        draw_text(msg_x, msg_y + 40, "Pressione ESC para sair.");
        break;
}

// Lógica de Detecção de Proximidade

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

// Caixa de Diálogo de Interação (NOVA)

// Verifica se o jogador está perto de um posto ou depósito E no estado 'movendo'
if (instance_exists(posto_encontrado) && distance_to_object(posto_encontrado) < raio_colisao && estado_jogo == estado.movendo) {
    var msg_x = room_width / 2;
    var msg_y = room_height - 500;
    var msg_largura = 600;
    var msg_altura = 80;

    draw_set_color(c_black);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, false);
    draw_set_color(c_white);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_estabelecimento);
    draw_set_color(c_white);

    draw_text(msg_x, msg_y, "Aperte ESPACO para entrar no posto!");
    
} else if (instance_exists(deposito_encontrado) && distance_to_object(deposito_encontrado) < raio_colisao && estado_jogo == estado.movendo) {
    var msg_x = room_width / 2;
    var msg_y = room_height - 500;
    var msg_largura = 600;
    var msg_altura = 80;

    draw_set_color(c_black);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, false);
    draw_set_color(c_white);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_estabelecimento);
    draw_set_color(c_white);
    
    draw_text(msg_x, msg_y - 20, "Aperte ESPACO para comprar Gas");
    draw_text(msg_x, msg_y + 20, "ou F para entrar no deposito!");
}
