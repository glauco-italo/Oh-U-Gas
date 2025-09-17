// Evento Step do obj_player

// Lógica de controle principal do jogo com base nos estados
switch (estado_jogo) {
    case estado.movendo:
        // === Lógica de Movimento e Consumo de Gasolina ===
        if (keyboard_check(ord("D")) || keyboard_check(ord("A"))) {
            if (tanque_combustivel > 0) {
                tanque_combustivel -= consumo_combustivel;
            }
        }
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

            if (velocidade_atual == 0) {
                velocidade_atual = velocidade_maxima * direcao_input;
            } else {
                velocidade_atual = lerp(velocidade_atual, velocidade_maxima * direcao_input, aceleracao);
            }
        } else {
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
    
        // === Lógica de Interação com Comprador ===
        var comprador_aguardando = instance_nearest(x, y, obj_comprador);
        if (comprador_aguardando != noone && comprador_aguardando.estado_comprador == "pronto_para_sair") {
            comprador_aguardando.estado_comprador = "saindo";
            var direcao_input = sign(velocidade_atual); // Pega a direção da moto
            if (direcao_input > 0) {
                comprador_aguardando.direcao_saida = -1;
            } else if (direcao_input < 0) {
                comprador_aguardando.direcao_saida = 1;
            } else {
                comprador_aguardando.direcao_saida = 0;
            }
        }
     
        // Lógica para entrar no estado de negociação
        var cliente_proximo = instance_nearest(x, y, obj_comprador);
        if (cliente_proximo != noone && cliente_proximo.estado_comprador == "esperando" && distance_to_object(cliente_proximo) < raio_colisao) {
            if (tem_butijao) {
                velocidade_atual = 0;
                global.velocidade_fundo = 0;
                estado_jogo = estado.negociando;
            } else {
                velocidade_atual = 0;
                global.velocidade_fundo = 0;
            }
        }

        // === Lógica de Interação com Posto ou Depósito (CORRIGIDO) ===
        // Primeiro, encontra o local mais próximo e verifica se ele existe
        var local_proximo = noone;
        var posto_proximo = instance_nearest(x, y, obj_posto_local);
        var deposito_proximo = instance_nearest(x, y, obj_deposito_local);

        if (instance_exists(posto_proximo) && distance_to_object(posto_proximo) < raio_colisao) {
            local_proximo = posto_proximo;
        }

        if (instance_exists(deposito_proximo) && distance_to_object(deposito_proximo) < raio_colisao) {
            local_proximo = deposito_proximo;
        }
        
        // Atualiza a variável que a GUI usa para desenhar
        pode_interagir_agora = local_proximo;

        // Efetiva a transição de estado se o jogador apertar ESPAÇO
        if (pode_interagir_agora != noone && keyboard_check_pressed(vk_space)) {
            velocidade_atual = 0;
            global.velocidade_fundo = 0;
            
            if (pode_interagir_agora.object_index == obj_posto_local) {
                estado_jogo = estado.abastecendo;
            } else if (pode_interagir_agora.object_index == obj_deposito_local) {
                estado_jogo = estado.comprando_butijao;
            }
        }

        // Lógica de entrada no Depósito com 'F'
        if (keyboard_check_pressed(ord("F"))) {
            if (pode_interagir_agora != noone && pode_interagir_agora.object_index == obj_deposito_local) {
                global.deve_perguntar_dinheiro = true;
                audio_stop_all();
                room_goto(rm_deposito_interior);
            }
        }
        break;

    // === Lógica de Negociação ===
    case estado.negociando:
        if (keyboard_check_pressed(vk_escape)) {
            texto_resultado = "Voce desistiu da venda!";
            estado_jogo = estado.resultado_negociacao;
            timer_resultado = 60;
            var comprador_proximo = instance_nearest(x, y, obj_comprador);
            if (comprador_proximo != noone) {
                comprador_proximo.estado_comprador = "pronto_para_sair";
            }
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
            var comprador_proximo = instance_nearest(x, y, obj_comprador);
            if (aceitou) {
                global.carteira += valor_venda;
                texto_resultado = "O cliente aceitou! \n Voce ganhou R$ " + string(valor_venda) + "!";
                sprite_index = spr_sem_butijao;
                tem_butijao = false;
                
                if (comprador_proximo != noone) {
                    comprador_proximo.sprite_index = spr_comprador_butijao_1;
                }
            } else {
                texto_resultado = "O cliente nao aceitou. \n Voce nao ganhou nada.";
            }
            
            if (comprador_proximo != noone) {
                comprador_proximo.estado_comprador = "pronto_para_sair"; 
            }
            
            estado_jogo = estado.resultado_negociacao;
            timer_resultado = 120;
        }
        break;

    // === Lógica de Resultado da Negociação ===
    case estado.resultado_negociacao:
        timer_resultado--;
        if (timer_resultado <= 0) {
            estado_jogo = estado.movendo;
        }
        break;
    
    // === Lógica de Abastecimento ===
    case estado.abastecendo:
        if (keyboard_check_pressed(ord("D"))) {
            var falta_gasolina = 100 - tanque_combustivel;
            var custo_total = falta_gasolina * preco_por_litro;

            if (global.carteira >= custo_total) {
                tanque_combustivel = 100;
                global.carteira -= custo_total;
                show_message("Tanque cheio! \nVoce pagou R$" + string(custo_total) + ". Pressione ESC para sair.");
            } else {
                show_message("Voce nao tem dinheiro suficiente \n para encher o tanque! Custo: R$" + string(custo_total));
            }
        }
        if (keyboard_check_pressed(vk_escape)) {
            estado_jogo = estado.movendo;
        }
        break;

    // === Lógica de Compra de Botijão ===
    case estado.comprando_butijao:
        if (keyboard_check_pressed(ord("A"))) {
            if (!tem_butijao) {
                if (global.carteira >= custo_butijao) {
                    global.carteira -= custo_butijao;
                    sprite_index = spr_butijao_1;
                    tem_butijao = true;
                    show_message("Voce comprou um novo butijao! \nPressione ESC para sair.");
                    if (instance_exists(obj_controlador_compradores)) {
                        var controlador = instance_find(obj_controlador_compradores, 0);
                        if (controlador != noone) {
                            controlador.timer_comprador = irandom_range(controlador.tempo_min_passos, controlador.tempo_max_passos);
                        }
                    }
                } else {
                    show_message("Voce nao tem dinheiro \npara comprar o butijao!");
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