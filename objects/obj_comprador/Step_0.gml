// Evento Step do obj_comprador

if (estado_comprador == "saindo") {
    x += hspeed;
    if (x < -100 || x > room_width + 100) {
        instance_destroy();
    }
} else if (estado_comprador == "esperando") {
    if (tempo_espera > 0) {
        tempo_espera--;
    } else {
        instance_destroy();
    }
}
// NÃO FAÇA NADA NO ESTADO "AGUARDANDO"