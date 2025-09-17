for (var i = 0; i < array_length(camadas); i++) {
    var spr = camadas[i][0];
    var vel = camadas[i][1];
    var posY = camadas[i][2];
    
    // Calcula posição X com base na velocidade
    var posX = - (global.camera_x * vel) mod sprite_get_width(spr);
    
    // Desenha duas vezes para repetir
    draw_sprite(spr, 0, posX, posY);
    draw_sprite(spr, 0, posX + sprite_get_width(spr), posY);
}
