// Step Event - obj_comprador
switch (estado_comprador) {

    case "esperando":
        // sempre acompanha o fundo (assim parece parado)
        x -= global.velocidade_fundo;

        if (tempo_espera > 0) tempo_espera--;
        else instance_destroy();
        break;

    case "pronto_para_sair":
        // segue o fundo, mas NÃO anda por conta própria
        x -= global.velocidade_fundo;
        break;

    case "saindo":
        // Acompanha o fundo
        x -= global.velocidade_fundo;

        // E adiciona a caminhada "local" para fora da tela
        // A velocidade dele AGORA depende do seu movimento
        x += direcao_saida * abs(global.velocidade_fundo);

        // destrói quando sair da tela
        if (x < -100 || x > room_width + 100) instance_destroy();
        break;
}