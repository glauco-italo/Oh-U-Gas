// Evento Draw GUI do obj_comprador
x -= global.velocidade_fundo;
// Desenha a mensagem de negociação ou resultado se a flag estiver ativada
if (obj_player.pronto_para_negociar) {
    // --- NOVO: Desenha a caixa de fundo da mensagem ---
    var bg_x1 = (room_width / 2) - 250;
    var bg_y1 = (room_height / 2) - 80;
    var bg_x2 = (room_width / 2) + 250;
    var bg_y2 = (room_height / 2) + 80;
    
    // Cor preta semi-transparente
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(bg_x1, bg_y1, bg_x2, bg_y2, false);
    
    // Volta para a opacidade total e cor branca para o texto
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_preco);
    
    // Mostra a mensagem de espera
    if (obj_player.estado_jogo == estado.movendo) {
        draw_text(room_width / 2, room_height / 2 - 50, "Cliente encontrado!");
        draw_text(room_width / 2, room_height / 2, "Aperte ESPACO para negociar.");
    }
    
    // Mostra as opções de negociação quando o estado muda
    else if (obj_player.estado_jogo == estado.negociando) {
        draw_text(room_width / 2, room_height / 2 - 50, "Voce achou um cliente!");
        draw_text(room_width / 2, room_height / 2, "Aperte D para pedir muito (R$ 50)");
        draw_text(room_width / 2, room_height / 2 + 30, "Aperte A para pedir pouco (R$ 20)");
    }
    
    // Mostra o resultado da negociação
    else if (obj_player.estado_jogo == estado.resultado_negociacao) {
        draw_text(room_width / 2, room_height / 2, obj_player.texto_resultado);
    }
}