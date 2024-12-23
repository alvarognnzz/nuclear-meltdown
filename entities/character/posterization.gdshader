shader_type spatial;
render_mode unshaded;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform vec4 level1 : source_color = vec4(0,0,0,1);
uniform vec4 level2 : source_color = vec4(0.5,0.5,0.5,1);
uniform vec4 level3 : source_color = vec4(1,1,1,1);
uniform vec4 level4 : source_color = vec4(1,1,1,1);

uniform float threshold1 	: hint_range(0.0,1.0) = .1;
uniform float threshold2 	: hint_range(0.0,1.0) = .4;
uniform float threshold3	: hint_range(0.0,1.0) = .6;


void fragment(){
	ALBEDO = texture(screen_texture, SCREEN_UV).rgb;
	float rgb_avg = (ALBEDO.r + ALBEDO.g + ALBEDO.b)/3.0;
	if(rgb_avg < threshold1){
		ALBEDO = level1.rgb;
	}else if(rgb_avg < threshold2){
		ALBEDO = level2.rgb;
	}else if(rgb_avg < threshold3){
		ALBEDO = level3.rgb;
	}else{
		ALBEDO = level4.rgb;
	}
}