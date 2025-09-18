// Evento Step do obj_controlador_compradores

if (obj_player.tanque_combustivel > 0) {
    timer_comprador--;

    var local_especial_proximo = false;
    var is_deposito_proximo = false; // NOVO: Variável para verificar o depósito
    var num_fundos = instance_number(obj_fundo);

    for (var i = 0; i < num_fundos; i++) {
        var fundo_atual = instance_find(obj_fundo, i);
        if (distance_to_object(fundo_atual) < obj_player.raio_colisao) {
            if (fundo_atual.is_posto || fundo_atual.is_deposito) {
                local_especial_proximo = true;
            }
            if (fundo_atual.is_deposito) {
                is_deposito_proximo = true; // Define como verdadeiro se for um depósito
            }
        }
    }

    // Cria um comprador somente se...
    if (timer_comprador <= 0 
        // ...o jogador tiver butijões para vender (AGORA USA O NOVO CONTADOR)
        && global.numero_butijoes > 0
        // ...o jogador estiver em estado de movimento
        && obj_player.estado_jogo == estado.movendo
        // ...não houver um comprador já na tela
        && !instance_exists(obj_comprador)
        // ...e não estiver perto de um depósito ou posto
        && !local_especial_proximo)
    {
        var pos_x_fixa = 250;
        var pos_y_fixa = 111;

        instance_create_layer(pos_x_fixa, pos_y_fixa, "Instances", obj_comprador);
        
        // Reinicia o temporizador
        timer_comprador = irandom_range(tempo_min_passos, tempo_max_passos);
    }
}

if (instance_nearest(x,y,obj_posto_local)){
    timer_comprador--;
}

if (instance_nearest(x,y,obj_deposito_local)){
    timer_comprador--;
}