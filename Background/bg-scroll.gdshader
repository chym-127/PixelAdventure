shader_type canvas_item;
render_mode unshaded;
uniform float speed_x = 0.0;
uniform float speed_y = -0.5;

void vertex(){
    UV += TIME * vec2(speed_x,speed_y);
}