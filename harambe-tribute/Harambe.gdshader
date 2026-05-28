shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(0.8, 0.9, 1.0, 1.0); // soft holy blue
uniform float glow_strength = 0.15;
uniform float glow_size = 6.0;
uniform float pulse_speed = 1.5;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


void fragment() {
	// Base sprite
	vec4 tex = texture(TEXTURE, UV);
	COLOR = tex;
	COLOR.a *= fade;

	// Pulse effect
	float pulse = (sin(TIME * pulse_speed) + 1.0) * 0.5;

	// Sample surrounding pixels for glow
	vec2 pixel = TEXTURE_PIXEL_SIZE * glow_size;

	float glow =
		texture(TEXTURE, UV + vec2(pixel.x, 0)).a +
		texture(TEXTURE, UV - vec2(pixel.x, 0)).a +
		texture(TEXTURE, UV + vec2(0, pixel.y)).a +
		texture(TEXTURE, UV - vec2(0, pixel.y)).a;

	glow *= 0.25;

	// Combine glow + sprite
	vec4 final_glow = glow_color * glow * glow_strength * pulse;

	COLOR = tex + final_glow;

	// Preserve alpha properly
	COLOR.a = tex.a;
}