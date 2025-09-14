// Evento Create do obj_controlador_compradores

// Tempo mínimo e máximo para um novo comprador aparecer (em segundos)
var tempo_min_seg = 5;
var tempo_max_seg = 15;

// Converte os segundos para passos (assumindo 60 FPS)
tempo_min_passos = tempo_min_seg * 60;
tempo_max_passos = tempo_max_seg * 60;

// O timer inicial é aleatório dentro do período
timer_comprador = irandom_range(tempo_min_passos, tempo_max_passos);