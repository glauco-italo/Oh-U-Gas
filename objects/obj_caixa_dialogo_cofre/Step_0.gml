// Evento Step do obj_caixa_dialogo_cofre

// Posiciona os botões (deve ser o mesmo que o Draw Event)
var box_x = room_width / 2;
var box_y = room_height / 2;
var sim_x = box_x - 50;
var sim_y = box_y + 20;
var sim_width = 40;
var sim_height = 20;
var nao_x = box_x + 50;
var nao_y = box_y + 20;
var nao_width = 40;
var nao_height = 20;

// Se o botão do mouse esquerdo for pressionado...
if (mouse_check_button_pressed(mb_left)) {
    // ... e o mouse estiver sobre o botão 'Sim'
    if (point_in_rectangle(mouse_x, mouse_y, sim_x - sim_width / 2, sim_y - sim_height / 2, sim_x + sim_width / 2, sim_y + sim_height / 2)) {
        // O jogador clicou em SIM: transfere o dinheiro
        global.dinheiro_no_cofre += global.carteira;
        global.carteira = 0;
        instance_destroy(); // Destrói a caixa de diálogo
    }
    // ... ou se o mouse estiver sobre o botão 'Nao'
    else if (point_in_rectangle(mouse_x, mouse_y, nao_x - nao_width / 2, nao_y - nao_height / 2, nao_x + nao_width / 2, nao_y + nao_height / 2)) {
        // O jogador clicou em NAO: não faz nada
        instance_destroy(); // Apenas destrói a caixa de diálogo
    }
}