// Evento Create do obj_comprador
depth = -10;

// Aumenta a escala do comprador
image_xscale = 1.2 
image_yscale = 1.2;


// Create Event - obj_comprador
estado_comprador = "esperando";
tempo_espera = irandom_range(300, 600); // ou seu valor atual
direcao_saida = 0;
velocidade_saida_local = 2; // quantos px por step ele anda pra fora
saida_pendente = false;
min_mover_threshold = 0.1; // limiar para considerar que o fundo "realmente" começou a andar
sair_timer = 0;
