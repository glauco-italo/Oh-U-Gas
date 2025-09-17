// A velocidade relativa determina a rapidez com que a camada se move.
// Ajuste este valor para cada camada.
// Ex: 0.1 para a camada mais distante, 0.5 para a intermediária, 0.9 para a mais próxima.
velocidade_paralaxe_relativa = 0.5;

// Cria a segunda instância para o loop
if (instance_number(object_index) < 2) {
    instance_create_layer(x + sprite_width, y, layer, object_index);
}