// Evento Step do obj_controlador_fundo
// Diminui o timer
timer_posto--;

// Se o timer chegar a zero, cria um novo posto de fundo
if (timer_posto <= 0) {
    // A posição X é na borda direita da sala, e a Y é a altura da estrada
    var pos_x = room_width;
    var pos_y = 375; // Ajuste para a altura da sua calçada/estrada
    
    // Cria o novo fundo do posto e o posto de gasolina
    
    instance_create_layer(pos_x + 50, pos_y - 20, "Instances", obj_posto);

    // Reinicia o timer para a próxima aparição
    timer_posto = irandom_range(30 * 60, 60 * 60);
}