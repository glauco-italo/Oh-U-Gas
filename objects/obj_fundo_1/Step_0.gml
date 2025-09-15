// Evento Step do obj_fundo

// Move o fundo
x -= global.velocidade_fundo;

// --- Verifique se o fundo saiu da tela para reciclar ---
if (x <= -sprite_width) {
    // Recicla o fundo para o lado DIREITO (movendo para a direita)
    x += sprite_width * 2;
    var reciclar_esquerda = false;
}
else if (x >= room_width) {
    // Recicla o fundo para o lado ESQUERDO (movendo para a esquerda)
    x -= sprite_width * 2;
    var reciclar_esquerda = true;
} else {
    // Se não saiu da tela, nada a fazer
    exit;
}

// O código abaixo só roda quando o fundo é reciclado (quando o 'exit' não é ativado)

// Resetar todas as flags para evitar bugs de estados
is_posto = false;
is_deposito = false;
is_cliente = false;

// --- SORTEIO DE ELEMENTOS ---
var chance_posto = 17;
var chance_deposito = 5;
var chance_cliente = 20;

if (instance_exists(obj_player) && !obj_player.tem_butijao) {
    chance_deposito = 40;
    chance_posto = 10;
}

var sorteio = irandom_range(1, 100);

// ORDEM DE PRIORIDADE
if (sorteio <= chance_deposito) {
    // DEPÓSITO
    sprite_index = spr_deposito;
    is_deposito = true;
    instance_create_layer(613,549,"Instances",obj_deposito_local);
    instance_destroy(obj_posto_local);
    show_debug_message("Deposito criado")
    
}
else if (sorteio <= chance_deposito + chance_posto) {
    // POSTO
    sprite_index = spr_posto;
    is_posto = true;
    instance_create_layer(613,549,"Instances",obj_posto_local);
    instance_destroy(obj_deposito_local)
    show_debug_message("Posto Criado")
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