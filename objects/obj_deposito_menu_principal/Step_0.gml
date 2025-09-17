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
}

// Opção para voltar
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_game);
    
}