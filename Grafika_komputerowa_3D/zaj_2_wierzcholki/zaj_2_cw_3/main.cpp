#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "GL\glew.h"
#include "GL\freeglut.h"

char * shaderLoadSource(const char *filePath);


// Program bazuje na tutorialu ze strony: http://www.opengl-tutorial.org/beginners-tutorials/tutorial-2-the-first-triangle/



//Wymiary okna
int screen_width = 640;
int screen_height = 480;

float vertices[] = {
	-0.5f, -0.5f, 0.0f,
	0.5f, -0.5f, 0.0f,
	0.5f,  0.5f, 0.0f,
	-0.5f, 0.5f, 0.0f	// DOPISALEM CZWARTY BOK I ZMIENILEM WARTOSCI POPRZEDNICH ABY WYSWIETLAL PROSTOKAT

};


bool VBO = false;

/*###############################################################*/

int main(int argc, char **argv)
{

	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(screen_width, screen_height);
	glutInitWindowPosition(0, 0);
	glutCreateWindow("Pierwszy prog");

	glewInit(); //init rozszerzesze� OpenGL z biblioteki GLEW
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	//glutDisplayFunc(rysuj);			// def. funkcji rysuj�cej
	//glutIdleFunc(idle);			// def. funkcji rysuj�cej w czasie wolnym procesoora (w efekcie: ci�gle wykonywanej)
	//glutReshapeFunc(rozmiar);		// def. obs-ugi zdarzenia resize (GLUT)

	//glutKeyboardFunc(klawisz);		// def. obs�ugi klawiatury
	//glutMouseFunc(mysz); 		// def. obs�ugi zdarzenia przycisku myszy (GLUT)
	//glutMotionFunc(mysz_ruch); // def. obs�ugi zdarzenia ruchu myszy (GLUT)

	
	unsigned int vertexShader;
	vertexShader = glCreateShader(GL_VERTEX_SHADER);

	char *vertexShaderSource = shaderLoadSource("vertex_shader.glsl");
	if (!vertexShaderSource)
		return 0;
	glShaderSource(vertexShader, 1, (const char **)&vertexShaderSource, NULL);
	glCompileShader(vertexShader);


	//sprawdzenie b��d�w kompilacji....
	int  success;
	char infoLog[512];
	glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);

	if (!success)
	{
		glGetShaderInfoLog(vertexShader, 512, NULL, infoLog);
		printf("ERROR::SHADER::VERTEX::COMPILATION_FAILED\n");
	}
	
	unsigned int fragmentShader;
	fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);


    // wczytanie kodu shadera
	char *fragmentShaderSource = shaderLoadSource("fragment_shader.glsl");
	if (!fragmentShaderSource)
		return 0;

	glShaderSource(fragmentShader, 1, (const char **)&fragmentShaderSource, NULL);
	glCompileShader(fragmentShader);
	glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);

	if (!success)
	{
		glGetShaderInfoLog(fragmentShader, 512, NULL, infoLog);
		printf("ERROR::SHADER::VERTEX::COMPILATION_FAILED\n");
	}
	unsigned int shaderProgram;
	shaderProgram = glCreateProgram();

	glAttachShader(shaderProgram, vertexShader);
	glAttachShader(shaderProgram, fragmentShader);
	glLinkProgram(shaderProgram);

	glUseProgram(shaderProgram);
	


	//tworzenie bufora wierzcholk�w
	unsigned int VBO;
	glGenBuffers(1, &VBO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
	glEnableVertexAttribArray(0);
	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);


	glDrawArrays(GL_QUADS, 0, 4); // UZYLEM FUNKCJI GL_QUADS, ABY RYSOWAC CZWOROKAT, NA KONCU DALEM 4, ABY BYLY 4 BOKI
	

	glutSwapBuffers();

	glutMainLoop();					// start

	glDeleteShader(vertexShader);
	glDeleteShader(fragmentShader);


	return(0);
}


/*
* Returns a string containing the text in
* a vertex/fragment shader source file.
*/
char *shaderLoadSource(const char *filePath)
{
	const size_t blockSize = 512;
	FILE *fp;
	char buf[512];
	char *source = NULL;
	size_t tmp, sourceLength = 0;

	/* open file */
	fopen_s(&fp, filePath, "r");
	if (!fp) {
		fprintf(stderr, "shaderLoadSource(): Unable to open %s for reading\n", filePath);
		return NULL;
	}

	/* read the entire file into a string */
	while ((tmp = fread(buf, 1, blockSize, fp)) > 0) {
		char *newSource = (char*)malloc(sourceLength + tmp + 1);
		if (!newSource) {
			fprintf(stderr, "shaderLoadSource(): malloc failed\n");
			if (source)
				free(source);
			return NULL;
		}

		if (source) {
			memcpy(newSource, source, sourceLength);
			free(source);
		}
		memcpy(newSource + sourceLength, buf, tmp);

		source = newSource;
		sourceLength += tmp;
	}

	/* close the file and null terminate the string */
	fclose(fp);
	if (source)
		source[sourceLength] = '\0';

	return source;
}

