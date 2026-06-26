shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float progress = -0.6;
uniform float noiseForce = 1.6;
uniform sampler2D noiseTexture;
uniform vec4 burnColor : source_color;
uniform float borderWidth;
uniform float direction = 90.0;

vec2 degreesToPerpendicular() {
    return vec2(
        cos(radians(direction)),
        -sin(radians(direction))
    );
}

void fragment() {
	vec2 uv = UV;

    float burn =
        dot(uv, degreesToPerpendicular()) +
        texture(noiseTexture, SCREEN_UV).r * noiseForce;

    vec4 base = texture(SCREEN_TEXTURE, SCREEN_UV);

    float border = smoothstep(
        progress,
        progress + borderWidth,
        burn
    );

    vec3 finalColor = mix(
        burnColor.rgb,
        base.rgb,
        border
    );

    float alpha = step(progress, burn) * base.a;

    COLOR = vec4(finalColor, alpha);
}