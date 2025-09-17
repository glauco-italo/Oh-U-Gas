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
draw_roundrect(x1, y1, x2, y2, false); 
draw_set_color(c_black);
draw_roundrect(x1, y1, x2, y2, true);

draw_set_color(c_green);
if (tanque_combustivel < 30) {
    draw_set_color(c_red);
}
draw_roundrect_ext(x1, y_combustivel, x2, y2, 8, 8, false);

draw_set_color(c_white);
draw_set_font(fnt_tanque);
draw_set_halign(fa_center);
draw_text(x1 + largura/2, y1 - 25, "GASOLINA");

// === Desenhando a Carteira ===
var carteira_x = 50;
var carteira_y = 300;
var carteira_largura = 200;
var carteira_altura = 30;

draw_set_color(c_black);
draw_roundrect_ext(carteira_x, carteira_y, carteira_x + carteira_largura, carteira_y + carteira_altura, 10, 10, false);
draw_set_color(c_white);
draw_roundrect_ext(carteira_x, carteira_y, carteira_x + carteira_largura, carteira_y + carteira_altura, 10, 10, true);

draw_set_font(fnt_carteira);
draw_set_color(c_yellow);
draw_set_halign(fa_left);
draw_text(carteira_x + 10, carteira_y + 15, "Carteira: R$ " + string(global.carteira));

// === Lógica de mensagens centralizadas ===

var msg_x = 675;
var msg_y = 250;
var msg_largura = 400;
var msg_altura = 180;

if (estado_jogo != estado.movendo) {
    draw_set_color(c_black);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, false);
    draw_set_color(c_white);
    draw_roundrect_ext(msg_x - msg_largura / 2, msg_y - msg_altura / 2, msg_x + msg_largura / 2, msg_y + msg_altura / 2, 20, 20, true);
}

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_carteira);
draw_set_color(c_white);

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

// === Mensagem de Interação (CORRIGIDA) ===
// AQUI ESTÁ A SOLUÇÃO: Verificamos se a instância ainda existe ANTES de acessá-la.
if (pode_interagir_agora != noone && instance_exists(pode_interagir_agora) && estado_jogo == estado.movendo) {
    var msg_y_interacao = 150;
    var msg_largura_interacao = 350;
    var msg_altura_interacao = 100;
    var texto_interacao = "";
    var msg_x_interacao = 675;

    draw_set_color(c_black);
    draw_roundrect_ext(msg_x_interacao - msg_largura_interacao / 2, msg_y_interacao - msg_altura_interacao / 2, msg_x_interacao + msg_largura_interacao / 2, msg_y_interacao + msg_altura_interacao / 2, 20, 20, false);
    draw_set_color(c_white);
    draw_roundrect_ext(msg_x_interacao - msg_largura_interacao / 2, msg_y_interacao - msg_altura_interacao / 2, msg_x_interacao + msg_largura_interacao / 2, msg_y_interacao + msg_altura_interacao / 2, 20, 20, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_estabelecimento);
    draw_set_color(c_white);

    // O erro ocorria aqui. Agora, é seguro usar `pode_interagir_agora`
    if (pode_interagir_agora.object_index == obj_posto_local) {
        texto_interacao = "Aperte ESPACO para\nabastecer!";
    } else if (pode_interagir_agora.object_index == obj_deposito_local) {
        texto_interacao = "Aperte ESPACO para comprar Gas\nou F para entrar no deposito!";
    }
    draw_text(msg_x_interacao, msg_y_interacao, texto_interacao);
}