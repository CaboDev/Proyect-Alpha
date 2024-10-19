shader_type canvas_item;

uniform float wave_speed = 3.0; //wave loop speed
uniform float wave_freq = 10.0; //wave vertical freq
uniform float wave_width = 1; //wave width 

uniform vec4 water_tint : source_color = vec4(0.2, 0.6, 1.0, 0.1);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable,filter_nearest;

void fragment(){
	vec2 scale_UV = SCREEN_UV;
	vec2 wave_uv_offset;
	wave_uv_offset.x = cos((TIME*wave_speed)+UV.x+UV.y*wave_freq*2.0)*wave_width*0.01;
	//COLOR = vec4(wave_uv_offset,0.0,1.0);
	vec4 color = vec4(1.0);
	color = texture(SCREEN_TEXTURE,scale_UV+wave_uv_offset);
	COLOR.rgba = water_tint.rgba * color.rgba;
}