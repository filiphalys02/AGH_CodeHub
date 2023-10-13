#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#include "GL\glew.h"
#include "GL\freeglut.h"

#include "shaderLoader.h" //narzŕdzie do │adowania i kompilowania shaderˇw z pliku
#include "tekstura.h"

//funkcje algebry liniowej
#include "glm/vec3.hpp" // glm::vec3
#include "glm/vec4.hpp" // glm::vec4
#include "glm/mat4x4.hpp" // glm::mat4
#include "glm/gtc/matrix_transform.hpp" // glm::translate, glm::rotate, glm::scale, glm::perspective

// Program bazuje na tutorialu ze strony: https://learnopengl.com/


//Wymiary okna
int screen_width = 640;
int screen_height = 480;

GLint uniformTex0, uniformTex1;		//ZMIENNE TEKSTURY
int pozycjaMyszyX; // na ekranie
int pozycjaMyszyY;
int mbutton; // wcisiety klawisz myszy

double kameraX=0.0;
double kameraZ = 0.0;
double kameraD = -5;
double kameraPredkosc;
double kameraKat = -20;
double kameraPredkoscObrotu;
double poprzednie_kameraX;
double poprzednie_kameraZ;
double poprzednie_kameraD;

double rotation = 0;
double blend = 0.5;
double blend2 = 0;

//macierze

glm::mat4 MV; //modelview - macierz modelu i świata
glm::mat4 P;  //projection - macierz projekcji, czyli naszej perspektywy
glm::vec3 lightPos(0.0f, 4.0f, -1.5f);
GLuint objectColor_id = 0;
GLuint lightColor_id = 0;
GLuint lightPos_id = 0;
GLuint viewPos_id = 0;

float vertices[] = {			//PODLOGA
	-5,1,4, 0.0f,  0.0f, 1.0f,
	5,1,4,  0.0f,  0.0f, 1.0f,
	5,1,-8, 0.0f,  0.0f, 1.0f,
	-5,1,-8, 0.0f,  0.0f, 1.0f,
};

float vertices2[] = {
	-0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,
	0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,
	0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,
	0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,
	-0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,
	-0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,

	-0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,
	0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,
	0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,
	0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,
	-0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,
	-0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,

	-0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,
	-0.5f,  0.5f, -0.5f, -1.0f,  0.0f,  0.0f,
	-0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,
	-0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,
	-0.5f, -0.5f,  0.5f, -1.0f,  0.0f,  0.0f,
	-0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,

	0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,
	0.5f,  0.5f, -0.5f,  1.0f,  0.0f,  0.0f,
	0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,
	0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,
	0.5f, -0.5f,  0.5f,  1.0f,  0.0f,  0.0f,
	0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,

	-0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,
	0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,
	0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,
	0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,
	-0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,
	-0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,

	-0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,
	0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,
	0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,
	0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,
	-0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,
	-0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f
};

GLuint elements2[] = {
	3,2,1,0
};
float textureCoords[] = {
	0,0,
	5,0,
	5,5,
	0,5, };


//shaders
GLuint programID = 0;
GLuint lamp_ID = 0;


unsigned int VBO, VBO2, ebo, vtex;
unsigned int lightVAO;
GLuint  tex_id0;
unsigned int VAO[3];

double dx = -5;
double alpha = 1.0;
/*###############################################################*/
void mysz(int button, int state, int x, int y)
{
	mbutton = button;
	switch (state)
	{
	case GLUT_UP:
		break;
	case GLUT_DOWN:
		pozycjaMyszyX = x;
		pozycjaMyszyY = y;
		poprzednie_kameraX = kameraX;
		poprzednie_kameraZ = kameraZ;
		poprzednie_kameraD = kameraD;
		break;

	}
}
/*******************************************/
void mysz_ruch(int x, int y)
{
	if (mbutton == GLUT_LEFT_BUTTON)
	{
		kameraX = poprzednie_kameraX - (pozycjaMyszyX - x) * 0.1;
		kameraZ = poprzednie_kameraZ - (pozycjaMyszyY - y) * 0.1;
	}
	if (mbutton == GLUT_RIGHT_BUTTON)
	{
		kameraD = poprzednie_kameraD + (pozycjaMyszyY - y) * 0.1;
	}

}
/******************************************/


void klawisz(GLubyte key, int x, int y)
{
	switch (key) {

	case 27:    /* Esc - koniec */
		exit(1);
		break;

	case 'x':

		break;
	case 'c':

		break;


	case '1':

		break;
	case '2':

		break;
	}
	
	
}
/*###############################################################*/
void rysuj(void)
{


	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glUseProgram(programID);	
	GLuint MVP_id = glGetUniformLocation(programID, "MVP"); // pobierz lokalizację zmiennej 'uniform' "MV" w programie


	MV = glm::mat4(1.0f);  //macierz jednostkowa
	MV = glm::translate(MV, glm::vec3(1, -1, kameraD+dx ));

	MV = glm::rotate(MV, (float)glm::radians(kameraZ ), glm::vec3(1, 0, 0));
	MV = glm::rotate(MV, (float)glm::radians(kameraX ), glm::vec3(0, 1, 0));

	glm::mat4 MVP = P * MV;
	glUniformMatrix4fv(MVP_id, 1, GL_FALSE, &(MVP[0][0]));

	////////////////////////////////////////////////////


	glUniform3f(objectColor_id, 1.0f, 0.5f, 0.3f);
	glUniform3f(lightColor_id, 1.0f, 1.0f, 1.0f);
	glUniform3f(lightPos_id,lightPos[0], lightPos[1], lightPos[2]);

	/////////////////////////////////////////////////
	
	glBindVertexArray(VAO[0]);
	glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	glActiveTexture(GL_TEXTURE0);
	glBindTexture(GL_TEXTURE_2D, tex_id0);
	//glUniform1i ( uniformTex1 , 0 );
	glDrawElements(GL_QUADS, 4, GL_UNSIGNED_INT, 0);

	glUseProgram(lamp_ID);
	GLuint MVPlamp_id = glGetUniformLocation(lamp_ID, "MVP");
	MV = glm::translate(MV, lightPos);
	MV = glm::scale(MV, glm::vec3(0.6f, 0.6f, 0.6f));
	MV = glm::rotate(MV, (float)glm::radians(-30.0), glm::vec3(0, 1, 0));
	MVP = P * MV;
	glUniformMatrix4fv(MVPlamp_id, 1, GL_FALSE, &(MVP[0][0]));
	glBindVertexArray(lightVAO);
	glDrawArrays(GL_TRIANGLES, 0, 36);

	glFlush();
	glutSwapBuffers();

}
/*###############################################################*/
void rozmiar(int width, int height)
{
	screen_width = width;
	screen_height = height;

	//glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glViewport(0, 0, screen_width, screen_height);

	P = glm::perspective(glm::radians(60.0f), (GLfloat)screen_width / (GLfloat)screen_height, 1.0f, 1000.0f);

	glutPostRedisplay(); // Przerysowanie sceny
}

/*###############################################################*/
void idle()
{

	glutPostRedisplay();
}

/*###############################################################*/

GLfloat ad = 0.0;

void timer(int value) {

	
	glutTimerFunc(20, timer, 0);
}
/*###############################################################*/
int main(int argc, char **argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(screen_width, screen_height);
	glutInitWindowPosition(0, 0);
	glutCreateWindow("zajecia 9 cwiczenie 2");

	glewInit(); //init rozszerzeszeń OpenGL z biblioteki GLEW

	glutDisplayFunc(rysuj);			// def. funkcji rysuj¦cej
	glutIdleFunc(idle);			// def. funkcji rysuj¦cej w czasie wolnym procesoora (w efekcie: ci¦gle wykonywanej)
	glutTimerFunc(20, timer, 0);
	glutReshapeFunc(rozmiar); // def. obs-ugi zdarzenia resize (GLUT)

	glutKeyboardFunc(klawisz);		// def. obsługi klawiatury
	glutMouseFunc(mysz); 		// def. obsługi zdarzenia przycisku myszy (GLUT)
	glutMotionFunc(mysz_ruch); // def. obsługi zdarzenia ruchu myszy (GLUT)


	glEnable(GL_DEPTH_TEST);

	//podloga
	glGenBuffers(1, &VBO);
	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	glGenBuffers(1, &ebo);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(elements2), elements2, GL_STATIC_DRAW);

	glGenBuffers(1, &vtex);
	glBindBuffer(GL_ARRAY_BUFFER, vtex);
	glBufferData(GL_ARRAY_BUFFER, sizeof(textureCoords), textureCoords, GL_STATIC_DRAW);

	//swiatlo
	glGenBuffers(1, &VBO2);
	glBindBuffer(GL_ARRAY_BUFFER, VBO2);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices2), vertices2, GL_STATIC_DRAW);

	programID = loadShaders("vertex_shader.glsl", "fragment_shader.glsl");
 
	glUseProgram(programID);

	objectColor_id = glGetUniformLocation(programID, "objectColor");
	lightColor_id = glGetUniformLocation(programID, "lightColor");
    lightPos_id = glGetUniformLocation(programID, "lightPos");

	tex_id0 = WczytajTeksture("stone.bmp");
	if (tex_id0 == -1)
	{
		MessageBox(NULL, "Nie znaleziono pliku z teksturą", "Problem", MB_OK | MB_ICONERROR);
		exit(0);
	}

	glGenVertexArrays(3, VAO);

	glBindVertexArray(VAO[0]);
	glBindBuffer(GL_ARRAY_BUFFER, vtex);
	glEnableVertexAttribArray(1);
	glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, 0);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)0);

	// normal attribute
	glVertexAttribPointer(3, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)(3 * sizeof(float)));
	glEnableVertexAttribArray(1);


	// second, configure the light's VAO (VBO stays the same; the vertices are the same for the light object which is also a 3D cube)
	lamp_ID = loadShaders("lamp_vshader.glsl", "lamp_fshader.glsl");
	glGenVertexArrays(1, &lightVAO);
	glBindVertexArray(lightVAO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	// note that we update the lamp's position attribute's stride to reflect the updated buffer data
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)0);
	glEnableVertexAttribArray(0);

	glutMainLoop();					// start

	glDeleteBuffers(1, &VBO);
	glDeleteBuffers(1, &VBO2);
	glDeleteBuffers(1, &ebo);
	glDeleteBuffers(1, &vtex);
	glDeleteVertexArrays(1, &lightVAO);
	glDeleteBuffers(3, VAO);

	return(0);

}

