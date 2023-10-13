#version 330

// Odpowiada za oswietlenie kratki


out vec4 FragColor;
in vec2 texcoord0;
in vec4 outcol;
in vec3 Normal;
in vec3 FragPos;
uniform sampler2D tex0;

uniform vec3 lightPos;
uniform vec3 lightColor;
uniform vec3 objectColor;
uniform vec3 viewPos;

void main()
{
	// ambient
	float ambientStrength = 0.3;
	vec3 ambient = ambientStrength * lightColor;

	// diffuse
	vec3 norm = normalize(Normal);
	vec3 lightDir = normalize(lightPos - FragPos);
	float diff = max(dot(norm, lightDir), 0.5);
	vec3 diffuse = diff * lightColor;

	// specular
	float specularStrength = 1.0;
	vec3 viewDir = normalize(viewPos - FragPos);
	vec3 reflectDir = reflect(-lightDir, norm);
	float spec = pow(max(dot(viewDir, reflectDir), 0.0), 2);
	vec3 specular = specularStrength * spec * lightColor;


	vec3 result = (ambient + diffuse + specular) * objectColor;
	FragColor = vec4(result, 1.0);
    FragColor = texture(tex0, texcoord0) * FragColor;
} 


