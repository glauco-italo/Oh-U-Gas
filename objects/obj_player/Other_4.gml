// obj_player - Evento Room Start

// O jogador acabou de entrar em uma nova sala.
// Verifique o numero_butijoes global e defina o sprite correto.

if (global.capacidade_aumentada_lv2) {
    if (global.numero_butijoes == 3) {
        sprite_index = spr_butijao_3_A;
    } else if (global.numero_butijoes == 2) {
        sprite_index = spr_butijao_3_B;
    } else if (global.numero_butijoes == 1) {
        sprite_index = spr_butijao_3_C;
    } else {
        sprite_index = spr_sem_butijao;
    }
} else if (global.capacidade_aumentada) {
    if (global.numero_butijoes == 2) {
        sprite_index = spr_butijao_2;
   
    } else {
        sprite_index = spr_sem_butijao;
    }
} else {
    if (global.numero_butijoes == 1) {
        sprite_index = spr_butijao_1;
    } else {
        sprite_index = spr_sem_butijao;
    }
}

// Se o seu obj_player for criado em outras rooms, essa logica vai
// se encarregar de definir o sprite inicial baseado no inventario global.