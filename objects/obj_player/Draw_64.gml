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

// === NOVO CÓDIGO: Desenhando a Carteira ===
// Posição para a carteira (canto superior esquerdo)
var carteira_x = 50;
var carteira_y = 300;

// Desenha o texto da carteira
draw_set_font(fnt_carteira);
draw_set_color(c_yellow);
draw_set_halign(fa_left);
draw_text(carteira_x, carteira_y, "Carteira: R$ " + string(carteira));

// Retorna a cor e alinhamento para o padrão
draw_set_color(c_white);
draw_set_halign(fa_left);

// NOVO: Mensagem do posto de gasolina
if (instance_exists(obj_posto) && (distance_to_object(obj_posto) < raio_colisao) && estado_jogo == estado.movendo) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_preco);
    draw_text(room_width/2, room_height/2, "Posto de gasolina. Aperte ESPACO para abastecer!");
}