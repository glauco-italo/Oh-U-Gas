// Evento Create do obj_upgrade_manager

// Defina o custo do upgrade
custo_upgrade_economia = 1;
custo_upgrade_capacidade = 1; // NOVO CUSTO
// Estado da compra (para dar feedback)
enum upgrade_state {
    display,
    bought,
    no_money
}
estado_upgrade = upgrade_state.display;
feedback_message = "";