// Evento Create do obj_controlador_fundo

// Tempo mínimo e máximo para uma nova secao de fundo aparecer (em segundos)
var tempo_min_seg = 30; // 30 segundos
var tempo_max_seg = 60; // 1 minuto

// Converte os segundos para passos (assumindo 60 FPS)
timer_fundo = irandom_range(tempo_min_seg * 60, tempo_max_seg * 60);

// Uma flag para garantir que o timer so seja iniciado uma vez, se for necessario.
// É uma boa prática para evitar erros futuros.
is_initialized = true;
chance_posto= 0.2;