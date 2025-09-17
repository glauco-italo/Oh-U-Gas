// Direção do movimento
var direcao_movimento = sign(global.velocidade_fundo);

// Move o fundo
x -= global.velocidade_fundo * velocidade_paralaxe_relativa;

// Reposicionamento contínuo
if (direcao_movimento > 0) { // indo pra esquerda
    if (x <= -sprite_width) {
        x += sprite_width * 2;
    }
} else if (direcao_movimento < 0) { // indo pra direita
    if (x >= sprite_width) {
        x -= sprite_width * 2;
    }
}
