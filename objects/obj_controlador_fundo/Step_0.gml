// Evento Step do obj_controlador_fundo

// Diminui o timer para a proxima secao de fundo
timer_fundo--;

if (timer_fundo <= 0) {
    // A posicao Y é a mesma da calçada/estrada. Ajuste para o seu jogo.
    var pos_y = 375; 
    
    // Faz o sorteio para ver se o posto de gasolina aparece
    if (random(1) < chance_posto) {
        // Sorteio bem-sucedido: cria o fundo do posto e o posto de gasolina
        instance_create_layer(room_width, pos_y, "Instances", obj_fundo);
       
    } else {
        // Sorteio falhou: cria um pedaço de fundo normal
        var fundo_normal_a_criar;
        
        // Sorteia entre os dois tipos de fundo normal
        if (random(1) > 0.5) {
            fundo_normal_a_criar = obj_fundo; // Seu objeto de fundo normal
        } else {
            fundo_normal_a_criar = obj_fundo_1; // Seu objeto de fundo invertido
        }
        
        instance_create_layer(room_width, pos_y, "Instances", fundo_normal_a_criar);
    }
    
    // Reinicia o timer para a proxima aparição.
    // O valor do timer deve ser baseado na largura da sua sprite de fundo
    // para que a transicao seja perfeita.
    timer_fundo = sprite_get_width(obj_fundo.sprite_index) / global.velocidade_fundo;
}