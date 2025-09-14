// Evento Clean Up do obj_player
if (instance_exists(pneu_dianteiro)) {
    instance_destroy(pneu_dianteiro);
}
if (instance_exists(pneu_traseiro)) {
    instance_destroy(pneu_traseiro);
}