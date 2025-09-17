// === JORNADA DE TRABALHO ===
if (global.turno_ativo == true) {
    timer_turno_trabalho--;
    
    // Se o turno acabar, desative a restrição
    if (timer_turno_trabalho <= 0) {
        global.turno_ativo = false;
        // Opcional: Você pode adicionar uma mensagem aqui para avisar o jogador
        // show_message("Seu turno acabou! O deposito agora esta aberto.");
    }
}