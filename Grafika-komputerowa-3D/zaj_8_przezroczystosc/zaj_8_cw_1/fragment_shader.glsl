#version 330

out vec4 FragColor;
in vec2 texcoord0;
in vec4 outcol;
uniform sampler2D tex0;



void main()
{
	vec4 color = texture(tex0, texcoord0); 
	gl_FragColor = color;

} 

