// Evento Draw do obj_player

// === Posições dos Pneus ===
var pneu_dianteiro_offset_x = 200; 
var pneu_dianteiro_offset_y = 200; 

var pneu_traseiro_offset_x = 91; 
var pneu_traseiro_offset_y = 82; 

// --- Desenhe os objetos na ordem correta ---

// Define o fator de escala para os pneus
var pneu_scale_factor = 1.2;

// Calcula as escalas dos pneus
var pneu_xscale = image_xscale * pneu_scale_factor;
var pneu_yscale = image_yscale * pneu_scale_factor;

// Desenhe o pneu traseiro
draw_sprite_ext(spr_pneu, 0, 146,154,
                pneu_xscale, pneu_yscale, pneu_angle, image_blend, image_alpha);


// Desenhe o pneu dianteiro
draw_sprite_ext(spr_pneu, 0, 207,154,
                pneu_xscale, pneu_yscale, pneu_angle, image_blend, image_alpha);

// Desenhe a moto
draw_self();