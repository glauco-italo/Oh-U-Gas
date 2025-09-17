// Evento Step do obj_upgrade_manager

// Lógica de clique do mouse (coordenadas baseadas no Draw GUI)
var button_x = room_width / 2;
var button_y = room_height / 2;
var button_width = 300;
var button_height = 80;

// Se o upgrade de capacidade ainda não foi comprado, permita a interação
if (global.capacidade_aumentada == false) {
    // Coordenadas para o novo botão
    var button2_x = room_width / 2;
    var button2_y = room_height / 2 + 100;
    var button2_width = 300;
    var button2_height = 80;

    if (mouse_check_button_pressed(mb_left)) {
        if (point_in_rectangle(mouse_x, mouse_y, button2_x - button2_width / 2, button2_y - button2_height / 2, button2_x + button2_width / 2, button2_y + button2_height / 2)) {
            if (global.dinheiro_no_cofre >= custo_upgrade_capacidade) {
                global.dinheiro_no_cofre -= custo_upgrade_capacidade;
                global.capacidade_aumentada = true;
                estado_upgrade = upgrade_state.bought;
                feedback_message = "Upgrade comprado!\nVoce pode carregar 2 butijoes.";
            } else {
                estado_upgrade = upgrade_state.no_money;
                feedback_message = "Dinheiro insuficiente no cofre.";
            }
        }
    }
} else {
    // Se o upgrade já foi comprado, mostre a mensagem de "já comprado"
    estado_upgrade = upgrade_state.bought; // CORREÇÃO AQUI
    feedback_message = "Voce ja tem este upgrade.";
}