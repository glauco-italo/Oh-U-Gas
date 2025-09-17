// Evento Step do obj_upgrade_manager

// Atualiza o upgrade disponível com base no que já foi comprado
if (global.economia_melhorada == false) {
    upgrade_disponivel = "economia";
} else if (global.capacidade_aumentada == false) {
    upgrade_disponivel = "capacidade";
} else if (global.economia_melhorada_lv2 == false) {
    upgrade_disponivel = "economia_lv2";
} else if (global.capacidade_aumentada_lv2 == false) {
    // NOVO: Libera o upgrade de capacidade LV2
    upgrade_disponivel = "capacidade_lv2";
} else {
    upgrade_disponivel = "nenhum"; // Não há mais upgrades para comprar
}

// Lógica de clique do mouse
if (mouse_check_button_pressed(mb_left)) {
    // Coordenadas do botão de upgrade (centralizado)
    var button_x = room_width / 2;
    var button_y = room_height / 2;
    var button_width = 350;
    var button_height = 80;

    // A lógica de compra agora depende do upgrade_disponivel
    switch (upgrade_disponivel) {
        case "economia":
            if (point_in_rectangle(mouse_x, mouse_y, button_x - button_width / 2, button_y - button_height / 2, button_x + button_width / 2, button_y + button_height / 2)) {
                if (global.dinheiro_no_cofre >= custo_upgrade_economia) {
                    global.dinheiro_no_cofre -= custo_upgrade_economia;
                    global.economia_melhorada = true;
                    estado_upgrade = upgrade_state.bought;
                    feedback_message = "Upgrade de economia comprado!";
                } else {
                    estado_upgrade = upgrade_state.no_money;
                    feedback_message = "Dinheiro insuficiente no cofre.";
                }
            }
            break;

        case "capacidade":
            if (point_in_rectangle(mouse_x, mouse_y, button_x - button_width / 2, button_y - button_height / 2, button_x + button_width / 2, button_y + button_height / 2)) {
                if (global.dinheiro_no_cofre >= custo_upgrade_capacidade) {
                    global.dinheiro_no_cofre -= custo_upgrade_capacidade;
                    global.capacidade_aumentada = true;
                    estado_upgrade = upgrade_state.bought;
                    feedback_message = "Upgrade de capacidade comprado!";
                } else {
                    estado_upgrade = upgrade_state.no_money;
                    feedback_message = "Dinheiro insuficiente no cofre.";
                }
            }
            break;
            
        case "economia_lv2":
            // NOVO: Lógica para o segundo nivel de economia
            if (point_in_rectangle(mouse_x, mouse_y, button_x - button_width / 2, button_y - button_height / 2, button_x + button_width / 2, button_y + button_height / 2)) {
                if (global.dinheiro_no_cofre >= custo_upgrade_economia_lv2) {
                    global.dinheiro_no_cofre -= custo_upgrade_economia_lv2;
                    global.economia_melhorada_lv2 = true;
                    estado_upgrade = upgrade_state.bought;
                    feedback_message = "Melhoria de Gasolina LV2 comprada!";
                } else {
                    estado_upgrade = upgrade_state.no_money;
                    feedback_message = "Dinheiro insuficiente no cofre.";
                }
            }
            break;
        
        case "capacidade_lv2":
            // NOVO: Lógica para o segundo nivel de capacidade
            if (point_in_rectangle(mouse_x, mouse_y, button_x - button_width / 2, button_y - button_height / 2, button_x + button_width / 2, button_y + button_height / 2)) {
                if (global.dinheiro_no_cofre >= custo_upgrade_capacidade_lv2) {
                    global.dinheiro_no_cofre -= custo_upgrade_capacidade_lv2;
                    global.capacidade_aumentada_lv2 = true;
                    estado_upgrade = upgrade_state.bought;
                    feedback_message = "Capacidade LV2 comprada!\nVoce pode carregar 3 butijoes!";
                } else {
                    estado_upgrade = upgrade_state.no_money;
                    feedback_message = "Dinheiro insuficiente no cofre.";
                }
            }
            break;
    }
}