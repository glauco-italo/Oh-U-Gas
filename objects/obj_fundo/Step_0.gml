// Move o fundo
x -= global.velocidade_fundo;

// --- Verifique se o fundo saiu da tela para reciclar ---
if (x <= -sprite_width || x >= room_width) {
    
    // Destrói as instâncias de interação que saíram da tela
    instance_destroy(obj_posto_local);
    instance_destroy(obj_deposito_local);
    
    // Recicla o fundo
    if (x <= -sprite_width) {
        x += sprite_width * 2;
    } else {
        x -= sprite_width * 2;
    }
    
    // Reseta as flags
    is_posto = false;
    is_deposito = false;
    
    // --- Lógica de SORTEIO de elementos ---
    var chance_posto = 17;
    var chance_deposito = 5;
    var chance_cliente = 20;
    
    if (instance_exists(obj_player) && !global.numero_butijoes > 0) {
        chance_deposito = 40;
        chance_posto = 10;
    }
    
    var sorteio = irandom_range(1, 100);
    
    // ORDEM DE PRIORIDADE
    if (sorteio <= chance_deposito) {
        // DEPÓSITO
        sprite_index = spr_deposito;
        is_deposito = true;
        instance_create_layer(173, 120, "Instances", obj_deposito_local);
        show_debug_message("Deposito criado");
    }
    else if (sorteio <= chance_deposito + chance_posto) {
        // POSTO
        sprite_index = spr_posto;
        is_posto = true;
        instance_create_layer(173, 120, "Instances", obj_posto_local);
        show_debug_message("Posto Criado");
    }
    else if (sorteio <= chance_deposito + chance_posto + chance_cliente) {
        // CLIENTE
        sprite_index = (random(1) < 0.5) ? spr_fundo_normal : spr_fundo_invertido;
        is_cliente = true;
        // O comprador será criado por outra lógica (obj_controlador_compradores)
    }
    else {
        // FUNDO NORMAL
        sprite_index = (random(1) < 0.5) ? spr_fundo_normal : spr_fundo_invertido;
    }
}