﻿#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include "GL\glew.h"
#include "GL\freeglut.h"

#include "shaderLoader.h" //narzŕdzie do │adowania i kompilowania shaderˇw z pliku


//funkcje algebry liniowej
#include "glm/vec3.hpp" // glm::vec3
#include "glm/vec4.hpp" // glm::vec4
#include "glm/mat4x4.hpp" // glm::mat4
#include "glm/gtc/matrix_transform.hpp" // glm::translate, glm::rotate, glm::scale, glm::perspective


//Wymiary okna
int screen_width = 640;
int screen_height = 480;


int pozycjaMyszyX; // na ekranie
int pozycjaMyszyY;
int mbutton; // wcisiety klawisz myszy

double kameraX= 60.0;
double kameraZ = 30.0;
double kameraD = -3.0;
double kameraPredkosc;
double kameraKat = 20;
double kameraPredkoscObrotu;
double poprzednie_kameraX;
double poprzednie_kameraZ;
double poprzednie_kameraD;

double rotation = 0;


//macierze
glm::mat4 MV; //modelview - macierz modelu i świata
glm::mat4 P;  //projection - macierz projekcji, czyli naszej perspektywy


float vertices[] = {			//ZMIENIAM WSPOLRZEDNE
	0, -0.525731, 0.850651,
	0.850651, 0, 0.525731,
	0.850651, 0, -0.525731,
	-0.850651, 0, -0.525731,
	-0.850651, 0, 0.525731,
	-0.525731, 0.850651, 0,
	0.525731, 0.850651, 0,
	0.525731, -0.850651, 0,
	-0.525731, -0.850651, 0,
	0, -0.525731, -0.850651,
	0, 0.525731, -0.850651,
	0, 0.525731, 0.850651
};

float vertices2[] = {
	-0.7, -0.7, -0.7,
	0.7, -0.7, -0.7,
	0.7, 0.7, -0.7,
	-0.7, 0.7, -0.7,
	-0.7, -0.7, 0.7,
	0.7, -0.7, 0.7,
	0.7, 0.7, 0.7,
	-0.7, 0.7, 0.7
};

GLuint elements[] = {		//ELEMENT_FACE
	6, 2, 1,
	2, 7, 1,
	5, 4, 3,
	8, 3, 4,
	11, 5, 6,
	10, 6, 5,
	2, 10, 9,
	3, 9, 10,
	9, 8, 7,
	0, 7, 8,
	1, 0, 11,
	4, 11, 0,
	10, 2, 6,
	11, 6, 1,
	10, 5, 3,
	11, 4, 5,
	9, 7, 2,
	0, 1, 7,
	8, 9, 3,
	0, 8, 4 
};
GLuint elements2[] = { 
	0, 1, 2, 3,
	5, 4, 7, 6,
	6, 2, 1, 5,
	3, 7, 4, 0,
	7, 3, 2, 6,
	5, 1, 0, 4, 
};
GLuint programID = 0;

unsigned int VBO,VBO2;
unsigned int ebo, ebo2;
unsigned int VAO[2];


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
	case '1':

		break;
	case '2':

		break;
	}
	
	
}
/*###############################################################*/
void rysuj(void)
{

	//GLfloat color[] = { 1.0f, 0.0f, 0.0f, 1.0f };
	//glClearBufferfv(GL_COLOR, 0, color);

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); // Kasowanie ekranu

	glUseProgram(programID); //u┐yj programu, czyli naszego shadera	

	MV = glm::mat4(1.0f);  //macierz jednostkowa
	MV = glm::translate(MV, glm::vec3(-2, 0, kameraD - 2)); 
	MV = glm::rotate(MV, (float)glm::radians(kameraZ -30), glm::vec3(1, 0, 0)); 
	MV = glm::rotate(MV, (float)glm::radians(kameraX -60), glm::vec3(0, 1, 0));		//ZMIANA POZYCJI KAMERY

	glm::mat4 MVP = P * MV;

	GLuint MVP_id = glGetUniformLocation(programID, "MVP"); // pobierz lokalizację zmiennej 'uniform' "MV" w programie
	glUniformMatrix4fv(MVP_id, 1, GL_FALSE, &(MVP[0][0]));	   // wyślij tablicę mv do lokalizacji "MV", która jest typu mat4	
	
	// RYSUJEMY 1 OBIEKT

	glLineWidth(5);									//POSZERZAMY GRUBOSC LINII
	GLfloat attrib[] = { 1.0f, 0.0f,0.0f };			//KOLOR CZERWONY FIGURY 1
	glVertexAttrib3fv(1, attrib);
	glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);		//RYSUJEMY LINIE GL_LINE
	glBindVertexArray(VAO[0]);
	glDrawElements(GL_TRIANGLES, 36, GL_UNSIGNED_INT, 0);			//36 TO ILOSC WIERZCHOLKOW

	//glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	//attrib[0] = 0.0f;attrib[1] = 0.0f;attrib[2] = 1.0f;
	//glVertexAttrib3fv(1, attrib);
	//glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
	

	MV = glm::translate(MV, glm::vec3(3, 0.0, 0.0));				//PRZESUWAMY I ROBIMY MIEJSCE DLA OBIEKTU 2
	MVP = P * MV;
	glUniformMatrix4fv(MVP_id, 1, GL_FALSE, &(MVP[0][0]));
	
	// RYSUJEMY 2 OBIEKT

	glBindVertexArray(VAO[1]);
	attrib[0] = 0.0f;attrib[1] = 1.0f;attrib[2] = 0.0f;				//ZMIANA KOLORU NA ZIELONY
	glVertexAttrib3fv(1, attrib);
	glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);						// RYSUJEMY LINIE GL_LINE
	glDrawElements(GL_QUADS, 24, GL_UNSIGNED_INT, 0);				// 24 WIERZCHOLKI

	//attrib[0] = 0.0f;attrib[1] = 1.0f;attrib[2] = 0.0f;
	//glVertexAttrib3fv(1, attrib);
	//glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	//glDrawElements(GL_QUADS, 8, GL_UNSIGNED_INT, 0);


	glFlush();
	glutSwapBuffers();

}
/*###############################################################*/
void rozmiar(int width, int height)
{
	screen_width = width;
	screen_height = height;

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
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
GLfloat k = 0.05;
GLfloat ad = 0.0;

void timer(int value) {

	//ad+= k;
	
	//if(ad>1 || ad<0)
	//k=-k;

	//GLfloat attrib[] = { ad, 0.0f,0.0f };
	// Aktualizacja wartości atrybutu wejściowego 1.
	//glVertexAttrib3fv(1, attrib);

	/*
	
	//W vertex_shader np:
	//layout (location = 1) in vec3 incolor;
	
	*/
	glutTimerFunc(20, timer, 0);
}
/*###############################################################*/
int main(int argc, char **argv)
{

	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE|GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(screen_width, screen_height);
	glutInitWindowPosition(0, 0);
	glutCreateWindow("Przyklad 5");

	glewInit(); //init rozszerzeszeń OpenGL z biblioteki GLEW

	glutDisplayFunc(rysuj);			// def. funkcji rysuj¦cej
    glutIdleFunc(idle);			// def. funkcji rysuj¦cej w czasie wolnym procesoora (w efekcie: ci¦gle wykonywanej)
	glutTimerFunc(20, timer, 0);
	glutReshapeFunc(rozmiar); // def. obs-ugi zdarzenia resize (GLUT)
									
	glutKeyboardFunc(klawisz);		// def. obsługi klawiatury
	glutMouseFunc(mysz); 		// def. obsługi zdarzenia przycisku myszy (GLUT)
	glutMotionFunc(mysz_ruch); // def. obsługi zdarzenia ruchu myszy (GLUT)


	glEnable(GL_DEPTH_TEST);

	glGenVertexArrays(2, VAO);

	glGenBuffers(1, &VBO);
	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
	glGenBuffers(1, &VBO2);
	glBindBuffer(GL_ARRAY_BUFFER, VBO2);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices2), vertices2, GL_STATIC_DRAW);
	glGenBuffers(1, &ebo);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(elements), elements, GL_STATIC_DRAW);
	glGenBuffers(1, &ebo2);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo2);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(elements2), elements2, GL_STATIC_DRAW);


	glBindVertexArray(VAO[0]);
	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, (void*)0);
	glBindVertexArray(VAO[1]);
	glBindBuffer(GL_ARRAY_BUFFER, VBO2);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo2);
	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, (void*)0);


	programID = loadShaders("vertex_shader.glsl", "fragment_shader.glsl");


	glutMainLoop();					
	
	glDeleteBuffers(1,&VBO);
	glDeleteBuffers(1, &VBO2);
	glDeleteBuffers(1, &ebo);
	glDeleteBuffers(1, &ebo2);
	glDeleteBuffers(2, VAO);
	return(0);
}

