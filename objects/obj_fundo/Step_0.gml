// Move o fundo
x -= global.velocidade_fundo;

// Verifique se o fundo saiu da tela
if (x <= -sprite_width) {
    x += sprite_width * 2;
} else if (x >= room_width) {
    x -= sprite_width * 2;
} else {
    // Se não saiu da tela, nada a fazer
    exit;
}

// --- CHECAGEM DE POSTO E DEPÓSITO ---
var is_posto_visivel = false;
var is_deposito_visivel = false;

with (obj_fundo) {
    if (is_posto) is_posto_visivel = true;
    if (is_deposito) is_deposito_visivel = true;
}

// --- SORTEIO DE ELEMENTOS ---
// chances base
var chance_posto     = 10;
var chance_deposito  = 5;
var chance_fundo     = 85;

// Se o player não tem gás → aumenta chance de depósito
if (instance_exists(obj_player) && !obj_player.tem_butijao) {
    chance_deposito = 40; // antes era 5
    chance_posto    = 10; // mantém
    chance_fundo    = 50; // reduz pra equilibrar
}

// Faz o sorteio proporcional
var total = chance_posto + chance_deposito + chance_fundo;
var sorteio = irandom_range(1, total);

// --- DEFINIÇÃO DO FUNDO ---
if (!is_posto_visivel && !is_deposito_visivel) {
    if (sorteio <= chance_posto) {
        // POSTO
        sprite_index = spr_posto;
        is_posto = true;
        is_deposito = false;
        is_cliente = false;
    }
    else if (sorteio <= chance_posto + chance_deposito) {
        // DEPÓSITO
        sprite_index = spr_deposito;
        is_deposito = true;
        is_posto = false;
        is_cliente = false;
    }
    else {
        // FUNDO NORMAL
        sprite_index = (random(1) < 0.5) ? spr_fundo_normal : spr_fundo_invertido;
        is_cliente = false;
        is_posto = false;
        is_deposito = false;
    }
}
else {
    // Se já existe um posto ou depósito visível → só fundo normal
    sprite_index = (random(1) < 0.5) ? spr_fundo_normal : spr_fundo_invertido;
    is_cliente = false;
    is_posto = false;
    is_deposito = false;
}
