// Evento Step do obj_player

// Lógica de controle principal do jogo com base nos estados
switch (estado_jogo) {
    case estado.movendo:
        // NOVO: Mova a lógica de consumo para DENTRO do estado.movendo
        if (keyboard_check(ord("D")) || keyboard_check(ord("A"))) {
            if (tanque_combustivel > 0) {
                tanque_combustivel -= consumo_combustivel;
            }
        }
        
        // Lógica de controle do player
        if (tanque_combustivel > 0) {
            var direcao_input = 0;
            
            if (keyboard_check(ord("D"))) {
                direcao_input = 1;
            }
            if (keyboard_check(ord("A"))) {
                direcao_input = -1;
            }
            
            if (keyboard_check(ord("D")) || keyboard_check(ord("A"))) {
                if (!audio_is_playing(moto_sound)) {
                    audio_play_sound(moto_sound, 0, true);
                }
            } else {
                if (audio_is_playing(moto_sound)) {
                    audio_stop_sound(moto_sound);
                }
            }

            velocidade_atual = lerp(velocidade_atual, velocidade_maxima * direcao_input, aceleracao);
        }
        else {
            // Reduz a velocidade para zero quando não há input
            velocidade_atual = lerp(velocidade_atual, 0, aceleracao);
        }
        
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
        pneu_angle -= velocidade_rotacao_atual;

        velocidade_atual = clamp(velocidade_atual, velocidade_minima, velocidade_maxima);
        global.velocidade_fundo = velocidade_atual;
        
        // NOVO: Mova a lógica de detecção de clientes e locais para DENTRO do estado.movendo
        var cliente_proximo = instance_exists(obj_comprador) && (distance_to_object(obj_comprador) < raio_colisao);
        if (cliente_proximo) {
            velocidade_atual = 0;
            global.velocidade_fundo = 0;
            estado_jogo = estado.negociando;
            break; // Adicione um break para evitar que o código continue sendo executado
        }
        
        // NOVO: Encontre a instância do posto e do depósito para verificação
        var posto_fundo = noone;
        var deposito_fundo = noone;
        var num_fundos = instance_number(obj_fundo);

        for (var i = 0; i < num_fundos; i++) {
            var fundo_atual = instance_find(obj_fundo, i);
            if (fundo_atual.is_posto == true) {
                posto_fundo = fundo_atual;
            }
            if (fundo_atual.is_deposito == true) {
                deposito_fundo = fundo_atual;
            }
        }

        // Lógica para detectar se o posto está próximo
        if (instance_exists(posto_fundo) && distance_to_object(posto_fundo) < raio_colisao && keyboard_check_pressed(vk_space)) {
            velocidade_atual = 0;
            global.velocidade_fundo = 0;
            estado_jogo = estado.abastecendo;
            break;
        }

        // Lógica para detectar se o deposito está próximo
        if (instance_exists(deposito_fundo) && distance_to_object(deposito_fundo) < raio_colisao && keyboard_check_pressed(vk_space)) {
            velocidade_atual = 0;
            global.velocidade_fundo = 0;
            estado_jogo = estado.comprando_butijao;
            break;
        }

        break; // Termina o caso 'movendo'
    
    // Se não houver mais gasolina, o jogo acaba
    case estado.game_over:
        if (tanque_combustivel <= 0) {
            velocidade_atual = 0;
            pneu_angle = 0;
            global.velocidade_fundo = 0;
            audio_stop_all();
            room_goto(rm_game_over);
        }
        break;

    case estado.negociando:
        if (!tem_butijao && keyboard_check_pressed(vk_escape)) {
            estado_jogo = estado.movendo;
            break;
        }

        if (!tem_butijao) {
            break;
        }

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
                sprite_index = spr_sem_butijao;
                tem_butijao = false;
            } else {
                texto_resultado = "O cliente nao aceitou. Voce nao ganhou nada.";
            }
            
            estado_jogo = estado.resultado_negociacao;
            timer_resultado = 120;
        }
        break;

    case estado.resultado_negociacao:
        timer_resultado--;
        
        if (timer_resultado <= 0) {
            instance_destroy(obj_comprador);
            estado_jogo = estado.movendo;
        }
        break;
    
    case estado.abastecendo:
        if (keyboard_check_pressed(ord("D"))) {
            var falta_gasolina = 100 - tanque_combustivel;
            var custo_total = falta_gasolina * preco_por_litro;

            if (carteira >= custo_total) {
                tanque_combustivel = 100;
                carteira -= custo_total;
                show_message("Tanque cheio! Voce pagou R$" + string(custo_total) + ". Pressione ESC para sair.");
            } else {
                show_message("Voce nao tem dinheiro suficiente para encher o tanque! Custo: R$" + string(custo_total));
            }
        }
        if (keyboard_check_pressed(vk_escape)) {
            estado_jogo = estado.movendo;
        }
        break;

    case estado.comprando_butijao:
    if (keyboard_check_pressed(ord("A"))) {
        if (!tem_butijao) {
            if (carteira >= custo_butijao) {
                carteira -= custo_butijao;
                sprite_index = spr_butijao_1;
                tem_butijao = true;
                show_message("Voce comprou um novo butijao! Pressione ESC para sair.");
                
                // NOVO: Resetar o timer de aparição do comprador
                if (instance_exists(obj_controlador_compradores)) {
                    var controlador = instance_find(obj_controlador_compradores, 0);
                    if (controlador != noone) {
                        controlador.timer_comprador = irandom_range(controlador.tempo_min_passos, controlador.tempo_max_passos);
                    }
                }
            } else {
                show_message("Voce nao tem dinheiro para comprar o butijao!");
            }
        } else {
            show_message("Voce ja tem um butijao!");
        }
    }
    if (keyboard_check_pressed(vk_escape)) {
        estado_jogo = estado.movendo;
    }
    break;
}

// Se não houver mais gasolina, o jogo acaba
if (tanque_combustivel <= 0) {
    velocidade_atual = 0;
    pneu_angle = 0;
    global.velocidade_fundo = 0;
    audio_stop_all();
    room_goto(rm_game_over);
}