#version 330 core

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 vColor;               // DODANIE LOKACJI KOLORU
out vec3 color; // Going to (and defined in) your fragment shader.              
                // OUTUJE COLOR, INUJE W FRAGMENT_SHADER
void main()
{
    gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);
    color = vColor;                                 // COLOR BEDZIE POTRZEBNY WE FRAGMENT_SHADER
}