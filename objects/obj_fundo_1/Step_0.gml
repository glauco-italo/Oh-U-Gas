// Evento Step do obj_fundo

// Movimento
x -= global.velocidade_fundo;

// Reposicionamento e sorteio da próxima sprite
if (x <= -sprite_width) {
    x += sprite_width * 2;
    
    // Faz o sorteio para a nova sprite
    var sorteio = random(1);
    
    if (sorteio < chance_posto) {
        // Aconteceu a chance: sprite do posto
        sprite_index = spr_posto;
        is_posto = true; // ATIVA a flag
    } else {
        // Nao aconteceu: sorteia entre os fundos normais
        if (random(1) < 0.5) {
            sprite_index = spr_fundo_normal;
        } else {
            sprite_index = spr_fundo_invertido;
        }
        is_posto = false; // DESATIVA a flag
    }
} else if (x >= room_width) {
    x -= sprite_width * 2;
    
    // Faz o sorteio para a nova sprite
    var sorteio = random(1);
    
    if (sorteio < chance_posto) {
        // Aconteceu a chance: sprite do posto
        sprite_index = spr_posto;
        is_posto = true; // ATIVA a flag
    } else {
        // Nao aconteceu: sorteia entre os fundos normais
        if (random(1) < 0.5) {
            sprite_index = spr_fundo_normal;
        } else {
            sprite_index = spr_fundo_invertido;
        }
        is_posto = false; // DESATIVA a flag
    }
}