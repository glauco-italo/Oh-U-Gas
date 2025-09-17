

// Define a fonte e a cor para o texto
draw_set_font(fnt_cofre); // Use a sua fonte padrão
draw_set_color(c_lime);

// Define o alinhamento do texto
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Exibe o dinheiro na tela
draw_text(670, 200, "Dinheiro no Cofre: R$" + string(global.dinheiro_no_cofre));

// Define a fonte e a cor para o texto
draw_set_font(fnt_cofre); // Use a sua fonte padrão
draw_set_color(c_white);

// Define o alinhamento do texto
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Exibe o dinheiro na tela
draw_text(670, 250, "Aperte G para voltar aos UPGRADES");