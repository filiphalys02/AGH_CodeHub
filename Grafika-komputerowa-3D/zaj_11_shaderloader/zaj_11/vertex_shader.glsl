#version 330 

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 vColor; 

uniform mat4 MVP;

out vec3 color;

void main()
{

 
    gl_Position = MVP*vec4(aPos.x, aPos.y, aPos.z, 1.0);
    color = vColor;
}