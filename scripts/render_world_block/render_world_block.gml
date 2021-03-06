/// render_world_block(vbuffer, resource, [rotate, size])
/// @arg vbuffer
/// @arg resource
/// @arg [rotate
/// @arg size]

var vbuffer, res, rotate, size;
vbuffer = argument[0]
res = argument[1]

if (argument_count > 2)
{
	rotate = argument[2]
	size = argument[3]
}
else
	rotate = false

if (vbuffer = null)
	return 0
	
if (!res.ready)
	res = mc_res

var tex, texani;
tex = res.block_sheet_texture
if (res.block_sheet_ani_texture != null)
	texani = res.block_sheet_ani_texture[block_texture_get_frame()]
else
	texani = mc_res.block_sheet_ani_texture[block_texture_get_frame()]

var blend = shader_blend_color;
render_set_texture(tex)

// Rotate by 90 degrees for legacy support
if (rotate && dev_mode_rotate_blocks)
	matrix_world_multiply_pre(matrix_create(point3D(0, size[Y] * block_size, 0), vec3(0, 0, 90), vec3(1)))

// DEPTH 0

if (!vbuffer_is_empty(vbuffer[e_block_depth.DEPTH0, e_block_vbuffer.NORMAL]))
	vbuffer_render(vbuffer[e_block_depth.DEPTH0, e_block_vbuffer.NORMAL])

if (!vbuffer_is_empty(vbuffer[e_block_depth.DEPTH0, e_block_vbuffer.ANIMATED]))
{
	render_set_texture(texani)
	vbuffer_render(vbuffer[e_block_depth.DEPTH0, e_block_vbuffer.ANIMATED])
	render_set_texture(tex)
}

if (!vbuffer_is_empty(vbuffer[e_block_depth.DEPTH0, e_block_vbuffer.GRASS]))
{
	render_set_uniform_color("uBlendColor", color_multiply(blend, res.color_grass), shader_blend_alpha)
	vbuffer_render(vbuffer[e_block_depth.DEPTH0, e_block_vbuffer.GRASS])
	render_set_uniform_color("uBlendColor", blend, shader_blend_alpha)
}

// DEPTH 1

if (!vbuffer_is_empty(vbuffer[e_block_depth.DEPTH1, e_block_vbuffer.NORMAL]))
	vbuffer_render(vbuffer[e_block_depth.DEPTH1, e_block_vbuffer.NORMAL])

if (!vbuffer_is_empty(vbuffer[e_block_depth.DEPTH1, e_block_vbuffer.ANIMATED]))
{
	render_set_texture(texani)
	vbuffer_render(vbuffer[e_block_depth.DEPTH1, e_block_vbuffer.ANIMATED])
	render_set_texture(tex)
}

if (!vbuffer_is_empty(vbuffer[e_block_depth.DEPTH1, e_block_vbuffer.GRASS]))
{
	render_set_uniform_color("uBlendColor", color_multiply(blend, res.color_grass), shader_blend_alpha)
	vbuffer_render(vbuffer[e_block_depth.DEPTH1, e_block_vbuffer.GRASS])
	render_set_uniform_color("uBlendColor", blend, shader_blend_alpha)
}

if (!vbuffer_is_empty(vbuffer[e_block_depth.DEPTH1, e_block_vbuffer.LEAVES]))
{
	render_set_uniform_color("uBlendColor", color_multiply(blend, res.color_foliage), shader_blend_alpha)
	vbuffer_render(vbuffer[e_block_depth.DEPTH1, e_block_vbuffer.LEAVES])
	render_set_uniform_color("uBlendColor", blend, shader_blend_alpha)
}

// DEPTH 2

if (!vbuffer_is_empty(vbuffer[e_block_depth.DEPTH2, e_block_vbuffer.NORMAL]))
	vbuffer_render(vbuffer[e_block_depth.DEPTH2, e_block_vbuffer.NORMAL])


if (!vbuffer_is_empty(vbuffer[e_block_depth.DEPTH2, e_block_vbuffer.ANIMATED]))
{
	render_set_texture(texani)
	vbuffer_render(vbuffer[e_block_depth.DEPTH2, e_block_vbuffer.ANIMATED])
}


if (!vbuffer_is_empty(vbuffer[e_block_depth.DEPTH2, e_block_vbuffer.WATER]))
{
	if (render_mode != e_render_mode.HIGH_LIGHT_SUN_DEPTH &&
	 render_mode != e_render_mode.HIGH_LIGHT_SPOT_DEPTH &&
	 render_mode != e_render_mode.HIGH_LIGHT_POINT_DEPTH)
	{
		render_set_texture(texani)
		render_set_uniform_color("uBlendColor", color_multiply(blend, res.color_water), shader_blend_alpha)
		vbuffer_render(vbuffer[e_block_depth.DEPTH2, e_block_vbuffer.WATER])
		render_set_uniform_color("uBlendColor", blend, shader_blend_alpha)
	}
}
