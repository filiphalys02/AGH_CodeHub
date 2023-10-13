#version 330

out vec4 FragColor;
in vec2 texcoord0;		//INUJE textcoord0 z vertex_shader
in vec3 outcol;			//INUJE outcol z vertex_shader

uniform sampler2D tex0;

void main()
{
	gl_FragColor  = vec4(outcol.x, outcol.y,outcol.z, 1.0f); //ZMIENIAM KOLOR W ZALERZNOSCI OD outcol
	gl_FragColor  = texture( tex0, texcoord0 )*gl_FragColor;
} 
