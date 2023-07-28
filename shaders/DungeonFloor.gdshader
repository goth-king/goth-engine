shader_type spatial;

uniform sampler2D texture_albedo : source_color,filter_linear_mipmap,repeat_enable;

varying vec3 vert;
varying vec3 norm;

void vertex() {
	vert = VERTEX;
	norm = NORMAL;
}

void fragment() {
	vec4 albedo = abs(norm.y) * texture(texture_albedo,vert.xz);// abs(norm.z) * texture(texture_albedo_floor,vert.xy) + abs(norm.x) * texture(texture_albedo_floor,vert.yz);
	ALBEDO = albedo.rgb;
}
