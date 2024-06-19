#version 400


in vec3 color; // from the vertex shader.  
out vec4 FragColor;
        
void main()
{
    FragColor = vec4(0.0f, 0.0f, 1.0f, 1.0f);           //NIEBIESKI KOLOR 001 RGB
    //FragColor =vec4(color.x,color.y,color.z, 1.0f); 
} 
