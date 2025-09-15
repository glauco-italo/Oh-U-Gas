// Se o jogador vender o botijão, essa instância é destruída em outro lugar (normal)
// Mas se o tempo acabar e ele não foi atendido, ele vai embora sozinho
if (tempo_espera > 0) {
    tempo_espera--;
} else {
    instance_destroy(); // O comprador some
}
