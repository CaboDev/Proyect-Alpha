
shader_type canvas_item;
uniform float pixelSize = 400.0; 
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest_mipmap;


void fragment() {
    vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 uv = FRAGCOORD.xy / iResolution.xy;

    uv = floor(uv * pixelSize) / pixelSize + 0.5 / pixelSize;

    float r = texture(screen_texture, uv).r;
    float g = texture(screen_texture, uv).g;
    float b = texture(screen_texture, uv).b;

    vec4 tex = vec4(r, g, b, 1.0);
    COLOR = tex;
}
