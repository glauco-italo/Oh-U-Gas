// Evento Create do obj_upgrade_manager

// Defina o custo do upgrade
custo_upgrade_economia = 1;
custo_upgrade_capacidade = 1;
custo_upgrade_economia_lv2 = 1;
custo_upgrade_capacidade_lv2 = 1;

// Estado da compra (para dar feedback)
enum upgrade_state {
    display,
    bought,
    no_money
}
estado_upgrade = upgrade_state.display;
feedback_message = "";

// NOVO: Variável para controlar qual upgrade está disponível no momento
// Começa com o upgrade de economia, pois é o primeiro na fila
upgrade_disponivel = "economia";