// Evento Create do obj_controlador_fundo

// Define a chance para o posto de gasolina aparecer (0.2 = 20% de chance)
chance_posto = 0.2; 

// Tempo mínimo e máximo para uma nova secao de fundo aparecer (em segundos)
var tempo_min_seg = 1;
var tempo_max_seg = 3;

// Converte os segundos para passos (assumindo 60 FPS)
timer_fundo = irandom_range(tempo_min_seg * 60, tempo_max_seg * 60);