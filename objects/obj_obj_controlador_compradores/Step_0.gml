// Evento Step do obj_controlador_compradores

// Verifica se o tanque de combustível do player não está vazio
if (obj_player.tanque_combustivel > 0) {
    // Diminui o timer
    timer_comprador--;

    // Se o timer chegar a zero, cria um novo comprador
    if (timer_comprador <= 0) {
        // Posição fixa onde o comprador vai aparecer
        var pos_x_fixa = 430; // Ajuste este valor
        var pos_y_fixa = 530; // Ajuste este valor

        // Cria o comprador na posição fixa
        instance_create_layer(pos_x_fixa, pos_y_fixa, "Instances", obj_comprador);

        // Reinicia o timer para a próxima aparição
        timer_comprador = irandom_range(tempo_min_passos, tempo_max_passos);
    }
}