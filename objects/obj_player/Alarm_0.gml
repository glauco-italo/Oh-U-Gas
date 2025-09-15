// Evento Alarm 0 do obj_player

// Reativa a instância do player para que ele possa processar as teclas
instance_deactivate_object(id);

// Verifica a resposta do jogador
if (keyboard_check_pressed(ord("S"))) {
    // O jogador disse SIM: transfere o dinheiro
    global.dinheiro_no_cofre += global.carteira;
    global.carteira = global.carteira;
    show_debug_message("Dinheiro guardado no cofre!");
    instance_destroy(obj_caixa_dialogo_cofre); // Destrói a caixa de diálogo
    instance_activate_all(); // Ativa todos os objetos novamente
} else if (keyboard_check_pressed(ord("N"))) {
    // O jogador disse NAO: não faz nada
    show_debug_message("Dinheiro não foi guardado.");
    instance_destroy(obj_caixa_dialogo_cofre);
    instance_activate_all();
} else {
    // Nenhuma tecla foi pressionada. Tenta novamente no próximo frame.
    alarm[0] = 1;
}