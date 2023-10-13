#version 330

// Odpowiada za pionki

out vec4 FragColor;
in vec4 outcol;

void main()
{

	gl_FragColor  = vec4(outcol.x, outcol.y,outcol.z, outcol.w);

} 