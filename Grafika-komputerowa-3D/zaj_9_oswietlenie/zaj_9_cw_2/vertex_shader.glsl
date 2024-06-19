#version 330 

layout (location = 0) in vec3 bPos;
layout (location = 1) in vec2 vtexcoord0;
layout (location = 2) in vec4 incol;
layout (location = 3) in vec3 aNormal;

uniform mat4 MVP;
out vec2 texcoord0;
out vec4 outcol;
out vec3 Normal;
out vec3 FragPos;

void main()
{
    gl_Position = MVP*vec4(bPos.x, bPos.y, bPos.z, 1.0);
	FragPos = bPos;
	texcoord0=vtexcoord0;
	outcol=incol;
	Normal =  aNormal;
}