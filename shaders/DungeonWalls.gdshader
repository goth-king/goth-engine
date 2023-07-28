shader_type spatial;

uniform sampler2D texture_albedo : source_color,filter_linear_mipmap,repeat_enable;

varying vec3 vert;
varying vec3 norm;

void vertex() {
	vert = VERTEX;
	norm = vec3(abs(NORMAL.x),abs(NORMAL.y),abs(NORMAL.z));
}

void fragment() {
	vec4 albedo = norm.z * texture(texture_albedo,vert.xy) + norm.x * texture(texture_albedo,vert.yz); //norm.y * texture(texture_albedo_floor,vert.xz) +
	ALBEDO = albedo.rgb;
}
