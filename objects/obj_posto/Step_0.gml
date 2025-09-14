// Evento Step do obj_fundo_posto
// Faça este pedaço de fundo se mover com a velocidade global
x -= global.velocidade_fundo;

// Destrói este objeto quando ele sair da tela para não gastar memória
if (x < -sprite_width) {
    instance_destroy();
}