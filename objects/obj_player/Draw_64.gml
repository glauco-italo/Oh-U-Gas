// Evento Draw GUI do obj_player

// === Código da barra de gasolina ===
// Posição e tamanho da barra
var x1 = 50;
var y1 = 50;
var x2 = 80;
var y2 = 250;
var largura = x2 - x1;

// Calcule a altura da barra com base na porcentagem de combustível
var altura_combustivel = (tanque_combustivel / 100) * (y2 - y1);
var y_combustivel = y2 - altura_combustivel;

// Desenhe o contorno da barra de combustível
draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2, true);

// Desenhe o preenchimento da barra de combustível
draw_set_color(c_green);
if (tanque_combustivel < 30) {
    draw_set_color(c_red);
}
draw_rectangle(x1, y_combustivel, x2, y2, false);

// Desenhe o texto "GASOLINA"
draw_set_color(c_white);
draw_set_font(fnt_tanque);
draw_set_halign(fa_center);
draw_text(x1 + largura/2, y1 - 25, "GASOLINA");

// === Desenhando a Carteira ===
// Posição para a carteira (canto superior esquerdo)
var carteira_x = 50;
var carteira_y = 300;

// Desenha o texto da carteira
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
    draw_text(room_width / 2, room_height / 2, "Cliente! Ofereça um preço:");
    draw_text(room_width / 2 - 100, room_height / 2 + 50, "[A] R$20");
    draw_text(room_width / 2 + 100, room_height / 2 + 50, "[D] R$50");
}

// === Desenhando o resultado da negociação ===
if (estado_jogo == estado.resultado_negociacao) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_preco);
    draw_text(room_width / 2, room_height / 2, texto_resultado);
}

// NOVO CÓDIGO: Desenha a mensagem do posto de gasolina

// Encontre a instância de obj_fundo que é o posto de gasolina
var posto_encontrado = noone;
var num_fundos = instance_number(obj_fundo);

for (var i = 0; i < num_fundos; i++) {
    var fundo_atual = instance_find(obj_fundo, i);
    if (fundo_atual.is_posto == true) {
        posto_encontrado = fundo_atual;
        break; // Saia do loop assim que encontrar o posto
    }
}

// Verifique a proximidade com essa instância específica
if (instance_exists(posto_encontrado) && distance_to_object(posto_encontrado) < raio_colisao && estado_jogo == estado.movendo) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_preco);
    draw_text(room_width / 2, room_height / 2, "Aperte ESPACO para abastecer!");
}