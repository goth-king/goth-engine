// NOTE: Shader automatically converted from Godot Engine 4.0.2.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;

uniform vec4 albedo_color : source_color;
uniform sampler2D texture_albedo_floor : source_color,filter_linear_mipmap,repeat_enable;
uniform sampler2D texture_normal_floor : source_color,filter_linear_mipmap,repeat_enable;
uniform sampler2D texture_albedo_wall  : source_color,filter_linear_mipmap,repeat_enable;
uniform sampler2D texture_normal_wall  : source_color,filter_linear_mipmap,repeat_enable;
uniform sampler2D texture_albedo_sand  : source_color,filter_linear_mipmap,repeat_enable;

uniform sampler2D texture_albedo_variation : source_color,filter_linear_mipmap,repeat_enable;
uniform sampler2D texture_albedo_variation_normal : source_color,filter_linear_mipmap,repeat_enable;

uniform float floor_max_slope : hint_range(0,1);
uniform float slope_blend : hint_range(0,.5);
uniform float point_size : hint_range(0,128);
uniform float roughness : hint_range(0,1);
uniform sampler2D texture_metallic : hint_default_white,filter_linear_mipmap,repeat_enable;
uniform vec4 metallic_texture_channel;
uniform sampler2D texture_roughness : hint_roughness_r,filter_linear_mipmap,repeat_enable;
uniform float specular;
uniform float metallic;
uniform vec2 uv1_scale;
uniform vec2 uv1_offset;
uniform vec2 uv2_scale;
uniform vec2 uv2_offset;

varying float normal_y;


void vertex() {
	normal_y = NORMAL.y;
}


void fragment() {
	vec2 uv1_tiled = UV * uv1_scale;
	float floor_blend = clamp(normal_y - floor_max_slope + slope_blend/2.0,0,slope_blend) / slope_blend;
	float wall_blend = clamp(floor_max_slope - normal_y + slope_blend/2.0,0,slope_blend) / slope_blend;
	
	vec4 albedo_tex_floor = albedo_color * texture(texture_albedo_floor,uv1_scale * uv1_tiled) * floor_blend;
	vec4 albedo_tex_wall = albedo_color * texture(texture_albedo_wall,uv1_scale * uv1_tiled) * wall_blend;
		
	vec4 albedo_tex_sand = texture(texture_albedo_sand,uv1_scale * uv1_tiled + vec2(0.1 * TIME,0)) * 0.0;
	vec4 albedo_tex_variation = texture(texture_albedo_variation, UV);
	
	ALBEDO = + 0.95 * (albedo_tex_floor.rgb + albedo_tex_wall.rgb) + (0.05 * albedo_tex_variation.rgb) + (albedo_tex_sand.rgb);
	
	vec4 normal_tex_floor = texture(texture_normal_floor,uv1_scale * uv1_tiled);
	vec4 normal_tex_wall = texture(texture_normal_wall,uv1_scale * uv1_tiled);
	vec4 albedo_tex_variation_normal = texture(texture_albedo_variation_normal, UV);
	
	NORMAL_MAP = (0.5 * albedo_tex_variation_normal.xyz) + 0.5 * (floor_blend * normal_tex_floor.xyz + wall_blend * normal_tex_wall.xyz);
	NORMAL_MAP_DEPTH = 0.5;

	
//	float metallic_tex = dot(texture(texture_metallic,base_uv),metallic_texture_channel);
//	METALLIC = metallic_tex * metallic;
//	vec4 roughness_texture_channel = vec4(1.0,0.0,0.0,0.0);
//	float roughness_tex = dot(texture(texture_roughness,base_uv),roughness_texture_channel);
//	ROUGHNESS = roughness_tex * roughness;
//	SPECULAR = specular;
}
