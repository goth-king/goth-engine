shader_type spatial;

uniform sampler2D albedo_texture : source_color,filter_linear_mipmap,repeat_enable;
uniform sampler2D normal_map : source_color,filter_linear_mipmap,repeat_enable;

void fragment() {
	// Place fragment code here.
	
	ALBEDO = texture(albedo_texture, UV).rgb;
}
