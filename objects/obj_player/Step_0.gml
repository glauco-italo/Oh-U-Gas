// Evento Step do obj_player

// Lógica de consumo de gasolina (só consome se A ou D estiverem pressionados)
if (keyboard_check(ord("D")) || keyboard_check(ord("A"))) {
    if (tanque_combustivel > 0) {
        tanque_combustivel -= consumo_combustivel;
    }
}

// Lógica para detectar se um cliente está próximo e preparar a negociação
var cliente_proximo = instance_exists(obj_comprador) && (distance_to_object(obj_comprador) < raio_colisao);

if (cliente_proximo && !pronto_para_negociar) {
    pronto_para_negociar = true;
    
    // Para o som, a velocidade da moto e do fundo
    audio_stop_all();
    velocidade_atual = 0;
    global.velocidade_fundo = 0;
}

// Lógica para detectar se o posto está próximo
var posto_proximo = instance_exists(obj_posto) && (distance_to_object(obj_posto) < raio_colisao);

if (cliente_proximo && !pronto_para_negociar) {
    pronto_para_negociar = true;
    audio_stop_all();
    velocidade_atual = 0;
    global.velocidade_fundo = 0;
}

// NOVO: Prepara o abastecimento
if (posto_proximo && keyboard_check_pressed(vk_space) && estado_jogo == estado.movendo) {
    if (carteira >= custo_abastecimento) {
        estado_jogo = estado.abastecendo;
        audio_stop_all();
    } else {
        show_message("Voce nao tem dinheiro suficiente para abastecer!");
    }
}

// Se não houver mais gasolina, o jogo acaba
if (tanque_combustivel <= 0) {
    velocidade_atual = 0;
    pneu_angle = 0; 
    global.velocidade_fundo = 0;
    audio_stop_all();
    
    room_goto(rm_game_over);
}

// AQUI ESTÁ A CORREÇÃO: se estiver pronto para negociar, muda de estado ao apertar ESPAÇO
if (pronto_para_negociar && keyboard_check_pressed(vk_space)) {
    estado_jogo = estado.negociando;
}

// Lógica de controle principal do jogo com base nos estados
switch (estado_jogo) {
    case estado.movendo:
        // Lógica de movimento e som apenas se houver combustível
        if (tanque_combustivel > 0) {
            var direcao_input = 0;
            
            if (keyboard_check(ord("D"))) {
                direcao_input = 1;
            }
            if (keyboard_check(ord("A"))) {
                direcao_input = -1;
            }
            
            // Inicia e para o som da moto
            if (keyboard_check(ord("D")) || keyboard_check(ord("A"))) {
                if (!audio_is_playing(moto_sound)) {
                    audio_play_sound(moto_sound, 0, true);
                }
            } else {
                if (audio_is_playing(moto_sound)) {
                    audio_stop_sound(moto_sound);
                }
            }

            // Aceleração/desaceleração
            velocidade_atual = lerp(velocidade_atual, velocidade_maxima * direcao_input, aceleracao);
        }

        // Lógica da sprite e rotação dos pneus
        var velocidade_rotacao_atual = 0;

        if (keyboard_check(ord("D"))) {
            image_xscale = 1 * escala; 
            image_yscale = escala;
            velocidade_rotacao_atual = velocidade_rotacao_pneu;
        }
        else if (keyboard_check(ord("A"))) {
            image_xscale = -1 * escala; 
            image_yscale = escala;
            velocidade_rotacao_atual = velocidade_rotacao_pneu * -1;
        }
        
        // Rotação dos pneus
        pneu_angle -= velocidade_rotacao_atual;

        // Limita a velocidade e passa para o fundo
        velocidade_atual = clamp(velocidade_atual, velocidade_minima, velocidade_maxima);
        global.velocidade_fundo = velocidade_atual;
        break;

    case estado.negociando:
        // Lógica para a negociação
        var valor_venda = 0;
        var chance_aceite = 0;
        var aceitou = false;

        if (keyboard_check_pressed(ord("D"))) {
            valor_venda = 50;
            chance_aceite = 0.3;
            if (random_range(0, 1) < chance_aceite) {
                aceitou = true;
            }
        }
        
        if (keyboard_check_pressed(ord("A"))) {
            valor_venda = 20;
            chance_aceite = 0.8;
            if (random_range(0, 1) < chance_aceite) {
                aceitou = true;
            }
        }
        
        if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(ord("A"))) {
            if (aceitou) {
                carteira += valor_venda;
                texto_resultado = "O cliente aceitou! Voce ganhou R$ " + string(valor_venda) + "!";
            } else {
                texto_resultado = "O cliente nao aceitou. Voce nao ganhou nada.";
            }
            
            // NÃO DESTRÓI MAIS O CLIENTE AQUI. Apenas muda o estado e inicia o timer.
            estado_jogo = estado.resultado_negociacao;
            timer_resultado = 120; // Mostra o resultado por 2 segundos (120 frames)
        }
        break;

    case estado.resultado_negociacao:
        // NOVO ESTADO: mostra o resultado da negociação
        timer_resultado--;
        
        if (timer_resultado <= 0) {
            instance_destroy(obj_comprador);
            estado_jogo = estado.movendo;
            pronto_para_negociar = false;
        }
        break;
    
     case estado.abastecendo:
        // NOVO ESTADO: Abastecendo o tanque
        if (tanque_combustivel < 100 && carteira >= custo_abastecimento) {
            tanque_combustivel += taxa_abastecimento;
            carteira -= custo_abastecimento;
        } else {
            // Se o tanque está cheio ou o dinheiro acabou, volta ao estado de movimento
            estado_jogo = estado.movendo;
            show_message("Tanque cheio! Ou o dinheiro acabou.");
        }
        break;
}
