// Move o posto junto com o fundo
x -= global.velocidade_fundo;

// Destrói o objeto quando ele sai da tela
if (x < -sprite_width) {
    instance_destroy();
}