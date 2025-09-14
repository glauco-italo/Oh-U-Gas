// Evento Step do obj_fundo

// Move o fundo com base na velocidade global
x -= global.velocidade_fundo;

// Lógica de repetição do fundo
if (global.velocidade_fundo > 0) { // Fundo se movendo para a esquerda (normal)
    if (x <= -sprite_width) {
        x += sprite_width * 2;
        // Alterna o sprite
        sprite_alternado = !sprite_alternado; 
        if (sprite_alternado) {
            sprite_index = spr_fundo_invertido;
        } else {
            sprite_index = spr_fundo_normal;
        }
    }
} else if (global.velocidade_fundo < 0) { // Fundo se movendo para a direita (reverso)
    if (x >= sprite_width) {
        x -= sprite_width * 2;
        // Alterna o sprite
        sprite_alternado = !sprite_alternado; 
        if (sprite_alternado) {
            sprite_index = spr_fundo_invertido;
        } else {
            sprite_index = spr_fundo_normal;
        }
    }
}