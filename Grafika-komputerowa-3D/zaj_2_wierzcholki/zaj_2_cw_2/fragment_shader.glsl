#version 330 core 

out vec4 FragColor;
in vec3 color;			// INUJE COLOR Z VERTEX_SHADER
void main()
{
    FragColor = vec4(color.x, color.y, color.z, 1.0f);			// POBIERAM COLOR DLA KAZDEJ WSPOLRZEDNEJ
} 
