// Evento Draw do obj_player

// === Posições dos Pneus (o código que você já tinha) ===
var pneu_dianteiro_offset_x = -85; 
var pneu_dianteiro_offset_y = 85;  

var pneu_traseiro_offset_x = 75; 
var pneu_traseiro_offset_y = 85; 

// --- Desenhe os objetos na ordem correta ---

// Desenhe o pneu traseiro (para que fique atrás da moto)
draw_sprite_ext(spr_pneu, 0, x + pneu_traseiro_offset_x, y + pneu_traseiro_offset_y,
                image_xscale, image_yscale, pneu_angle, image_blend, image_alpha);


// Desenhe o pneu dianteiro (para que fique na frente da moto)
draw_sprite_ext(spr_pneu, 0, x + pneu_dianteiro_offset_x, y + pneu_dianteiro_offset_y,
                image_xscale, image_yscale, pneu_angle, image_blend, image_alpha);
// Desenhe a moto
draw_self();
