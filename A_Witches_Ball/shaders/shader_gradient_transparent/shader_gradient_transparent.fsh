//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_uv;
uniform float fade_end;
uniform float fade_start;

void main()
{	
	//float fade_start = 0.2;
	float starting_ratio = ((v_vTexcoord.y - u_uv[0]) / (u_uv[1] - u_uv[0]));
	float pos_ratio = 1.0 - starting_ratio;
	pos_ratio = clamp((pos_ratio - fade_end)/fade_start,0.0,1.0);
	vec3 final_rgb = texture2D( gm_BaseTexture, v_vTexcoord).rgb;
	float final_alpha = texture2D( gm_BaseTexture, v_vTexcoord).a * pos_ratio;
	vec4 final_color = vec4(final_rgb, final_alpha);
	gl_FragColor = final_color;
}
