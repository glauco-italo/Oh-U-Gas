// Evento Create do obj_controlador_fundo
// Tempo mínimo e máximo para um novo posto aparecer (em segundos)
var tempo_min_seg = 30; // 30 segundos
var tempo_max_seg = 60; // 1 minuto

// Converte os segundos para passos (assumindo 60 FPS)
timer_posto = irandom_range(tempo_min_seg * 60, tempo_max_seg * 60);