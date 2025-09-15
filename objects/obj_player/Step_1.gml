// Evento Begin Step do obj_player

if (room == rm_deposito_interior && global.deve_perguntar_dinheiro) {
    // O jogador acabou de entrar.
    // Pausa o jogo para mostrar a pergunta
    instance_deactivate_all(true);
    
    // Cria o objeto da caixa de diálogo
    var caixa = instance_create_layer(x, y, "Instances", obj_caixa_dialogo_cofre);
    
    // Desativa a flag para que a pergunta não se repita
    global.deve_perguntar_dinheiro = false;
    
    // Agora, esperamos pela resposta do jogador
    // Vamos usar um Alarme para controlar a espera
    alarm[0] = 1; // Chama o alarme no próximo frame
}