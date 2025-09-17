// Evento Create do obj_player
depth = -y;

escala = 1; 
// Aplica a escala logo no início do jogo
image_xscale = escala; 
image_yscale = escala;


// Enum para os estados do jogo
enum estado {
    movendo,
    negociando,
    resultado_negociacao,
    abastecendo,
    comprando_butijao,
    game_over,
    
}

// Variável para o estado atual
estado_jogo = estado.movendo;

// Carteira do jogador
global.carteira = 0;


// Define a velocidade vertical do jogador
velocidade_jogador = 4; // Ajuste conforme necessário

// Limites de movimento vertical (para não sair da tela)
limite_cima = 50; // Ajuste para a altura mínima que o player pode ir
limite_baixo = room_height - 50; // Ajuste para a altura máxima

// Cria os pneus como instâncias separadas (apenas para ter os IDs)
// Eles serão desenhados e posicionados em outro lugar

// Pneu dianteiro (será posicionado em relação à moto)
pneu_dianteiro = instance_create_depth(x, y, depth , obj_pneu);

// Pneu traseiro (será posicionado em relação à moto)
pneu_traseiro = instance_create_depth(x, y, depth , obj_pneu);

// Defina a velocidade de rotação dos pneus
pneu_angle = 0; // Esta é a linha que faltava!
velocidade_rotacao_pneu = 10; // Ajuste o quão rápido o pneu gira
direcao_rotacao_pneu = 1; // Definida como persistente

// Variáveis de aceleração e velocidade
aceleracao = 0.1; // O quanto a velocidade aumenta a cada passo
velocidade_maxima = 10; // A velocidade máxima para frente
velocidade_minima = -10; // A velocidade máxima para trás


velocidade_atual = 0; // A velocidade atual do player

// Variáveis do tanque de combustível
tanque_combustivel = 100; // Começa com 100 de combustível
consumo_combustivel = 0.03; // O quanto de combustível é gasto por passo (ajuste para a sua preferência)

pronto_para_negociar = false; // Começa como falso
raio_colisao = 550; // Ajuste este valor. É a distância que o player precisa estar do cliente.
texto_resultado = ""; // Variável para armazenar a mensagem do resultado
timer_resultado = 0;  // Timer para controlar a exibição da mensagem

taxa_abastecimento = 1; // Quantidade de gasolina adicionada por passo
custo_abastecimento = 0.5; // Custo por passo
custo_abastecimento = 10;
preco_por_litro = 0.2; // O preço de cada "litro" de gasolina

tem_butijao = true;
sprite_index = spr_butijao_1;
custo_butijao = 10;

// No Evento Create do obj_player

