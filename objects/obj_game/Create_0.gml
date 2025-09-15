audio_play_sound(cidade_sound,1,true);
audio_play_sound(gas_music_sound,1,true);

// Evento Create (do obj_player ou obj_controlador_jogo)

global.carteira= 0; // Dinheiro que o jogador pode gastar na rua
global.dinheiro_no_cofre = 0; // Dinheiro guardado
global.deve_perguntar_dinheiro = false;