#version 400

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 vColor;        // Coming in from your OpenGL program
layout (location = 2) in float offset;

out vec3 color;        // Going to (and defined in) your fragment shader.

void main()
{
    float radius = 0.8;  // Promieñ okrêgu

    // Oblicz wspó³rzêdne pozycji na okrêgu
    float offset_rad = offset * 3.14159 * 2.0;  // Przeksztalcony offset na kat w radianach
    float pozycjax = sin(offset_rad) * radius + aPos.x;
    float pozycjay = cos(offset_rad) * radius + aPos.y;

    gl_Position = vec4(pozycjax, pozycjay, aPos.z, 1.0);
    color = vColor;
}