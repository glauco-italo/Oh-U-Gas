audio_play_sound(cidade_sound,1,true);
audio_play_sound(gas_music_sound,1,true);

// Evento Create (do obj_player ou obj_controlador_jogo)

global.carteira= 0; // Dinheiro que o jogador pode gastar na rua
global.dinheiro_no_cofre = 0; // Dinheiro guardado
global.deve_perguntar_dinheiro = false;

// === JORNADA DE TRABALHO ===
DURACAO_TURNO_TRABALHO = 60 * 120; // Duração do turno em frames (120 segundos)
global.turno_ativo = true;         // Começa com o turno ativo
timer_turno_trabalho = DURACAO_TURNO_TRABALHO; 