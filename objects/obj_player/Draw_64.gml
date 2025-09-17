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

// Novas coordenadas para a resolução de 330x180
var msg_x = 675 // Metade de 330
var msg_y = 250; // Metade de 180
var msg_largura = 400;
var msg_altura = 180;

// Desenha a caixa de mensagem
if (estado_jogo == estado.negociando || estado_jogo == estado.resultado_negociacao ||
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
            draw_text(msg_x, msg_y - 25, "Cliente! \nOfereca um preco:");
            draw_text(msg_x - 70, msg_y + 25, "[A] R$20");
            draw_text(msg_x + 70, msg_y + 25, "[D] R$50");
        } else {
            draw_text(msg_x, msg_y, "Voce precisa de um butijao para vender!");
        }
        break;
    
    case estado.resultado_negociacao:
        draw_text(msg_x, msg_y, texto_resultado);
        break;
    
    case estado.abastecendo:
        draw_text(msg_x, msg_y - 25, "Bem vindo ao posto!");
        draw_text(msg_x, msg_y + 5, "[D] Abastecer (R$" + string(custo_abastecimento) + ")");
        draw_text(msg_x, msg_y + 35, "Pressione ESC para sair.");
        break;
    
    case estado.comprando_butijao:
        draw_text(msg_x, msg_y - 25, "Bem vindo ao deposito de gas!");
        if (!tem_butijao) {
            draw_text(msg_x, msg_y + 5, "[A] Comprar butijao (R$" + string(custo_butijao) + ")");
        } else {
            draw_text(msg_x, msg_y + 5, "Voce ja tem um butijao!");
        }
        draw_text(msg_x, msg_y + 35, "Pressione ESC para sair.");
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

if (instance_exists(posto_encontrado) && distance_to_object(posto_encontrado) < raio_colisao && estado_jogo == estado.movendo) {
    var msg_x = 675;
    var msg_y = 150;
    var msg_largura = 350;
    var msg_altura = 100;

    draw_set_color(c_black);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, false);
    draw_set_color(c_white);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_estabelecimento);
    draw_set_color(c_white);

    draw_text(msg_x, msg_y, "Aperte ESPACO para \nentrar no posto!");
    
} else if (instance_exists(deposito_encontrado) && distance_to_object(deposito_encontrado) < raio_colisao && estado_jogo == estado.movendo) {
    var msg_x = 675;
    var msg_y = 150;
    var msg_largura = 350;
    var msg_altura = 100;

    draw_set_color(c_black);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, false);
    draw_set_color(c_white);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_estabelecimento);
    draw_set_color(c_white);
    
    draw_text(msg_x, msg_y - 15, "Aperte ESPACO para comprar Gas");
    draw_text(msg_x, msg_y + 15, "ou F para entrar no deposito!");
}

// === Adicionando a lógica de desenho do Comprador ===
var comprador_proximo = instance_nearest(x, y, obj_comprador);
if (comprador_proximo != noone && distance_to_object(comprador_proximo) < raio_colisao && estado_jogo == estado.movendo) {
    // Definindo as coordenadas para a nova caixa de mensagem de negociação
    var neg_msg_x = 120
    var neg_msg_y = 120
    var neg_msg_largura = 280;
    var neg_msg_altura = 100;

    // Desenha a caixa de fundo da mensagem
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_roundrect_ext(neg_msg_x - neg_msg_largura/2, neg_msg_y - neg_msg_altura/2, neg_msg_x + neg_msg_largura/2, neg_msg_y + neg_msg_altura/2, 10, 10, false);
    
    // Volta para a opacidade total e cor branca para o texto
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_carteira);
    
    draw_text(neg_msg_x, neg_msg_y - 20, "Cliente encontrado!");
    draw_text(neg_msg_x, neg_msg_y + 10, "Aperte ESPACO para negociar.");
}