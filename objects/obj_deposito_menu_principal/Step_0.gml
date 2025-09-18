// Evento Step do obj_deposito_menu_principal

// Se o botão esquerdo do mouse for pressionado
if (mouse_check_button_pressed(mb_left)) {
    // Verifica se o mouse está sobre o botão "Cofres"
    if (point_in_rectangle(mouse_x, mouse_y, cofre_x - cofre_width / 2, cofre_y - cofre_height / 2, cofre_x + cofre_width / 2, cofre_y + cofre_height / 2)) {
        // Clicou no Cofre: cria a tela do cofre e destrói esta tela de seleção
         instance_destroy();
       room_goto(rm_cofre);
       
    }
    
    // Verifica se o mouse está sobre o botão "Upgrades"
    else if (point_in_rectangle(mouse_x, mouse_y, upgrades_x - upgrades_width / 2, upgrades_y - upgrades_height / 2, upgrades_x + upgrades_width / 2, upgrades_y + upgrades_height / 2)) {
        // Clicou em Upgrades: cria a tela de upgrades e destrói esta tela de seleção
        instance_create_depth(0, 0, -9999, obj_upgrade_manager);
        instance_destroy();
    }

    // Verifica se o mouse está sobre o botão "Comprar Butijão"
    else if (point_in_rectangle(mouse_x, mouse_y, comprar_butijao_x - comprar_butijao_width / 2, comprar_butijao_y - comprar_butijao_height / 2, comprar_butijao_x + comprar_butijao_width / 2, comprar_butijao_y + comprar_butijao_height / 2)) {
        
        // Define a capacidade maxima com base nos upgrades
        var max_butijoes = 1;
        if (global.capacidade_aumentada) {
            max_butijoes = 2;
        }
        if (global.capacidade_aumentada_lv2) {
            max_butijoes = 3;
        }
    
// Verificação de compra e atualização da variável global (não precisa do "player")
        if (global.numero_butijoes < max_butijoes) {
            var butijoes_faltando = max_butijoes - global.numero_butijoes;
            var custo_total_compra = custo_butijao;

            if (global.dinheiro_no_cofre >= custo_total_compra) {
                global.dinheiro_no_cofre -= custo_total_compra;
                global.numero_butijoes = max_butijoes;
                
                // Tente encontrar o objeto do jogador SOMENTE para atualizar o sprite
                var player = instance_find(obj_player, 0);
                if (player != noone) {
                    if (global.capacidade_aumentada_lv2) {
                        player.sprite_index = spr_butijao_3_A;
                    } else if (global.capacidade_aumentada) {
                        player.sprite_index = spr_butijao_2;
                    } else {
                        player.sprite_index = spr_butijao_1;
                    }
                }

                show_message("Voce comprou " + string(butijoes_faltando) + " butijao(oes)! \nCusto total: R$" + string(custo_total_compra));
            } else {
                show_message("Dinheiro insuficiente no cofre!");
            }
        } else {
            show_message("Voce ja atingiu a capacidade maxima!");
        }
    }
}

// Opção para voltar
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_game);
}
        

