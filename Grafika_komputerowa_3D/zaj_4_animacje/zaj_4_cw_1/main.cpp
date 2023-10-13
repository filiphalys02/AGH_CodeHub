#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include "GL\glew.h"
#include "GL\freeglut.h"

#include "shaderLoader.h" //narzedzie do ladowania i kompilowania shaderow z pliku


//Wymiary okna
int screen_width = 640;
int screen_height = 480;

float vertices[] = {
	-0.2f, -0.2f, 0.0f,
	0.2f, -0.2f, 0.0f,
	0.0f,  0.2f, 0.0f			//POMNIEJSZYLEM TROJKAT
};


//shaders
GLuint programID = 0;

unsigned int VBO;

bool s = TRUE;
void klawisz(GLubyte key, int x, int y)
{
	switch (key) {

	case 27:    // Esc - koniec
		exit(1);
		break;
	case 's':
		if (s)
			s = false;
		else
			s = true;
		break;

	}

}

/*###############################################################*/
void rysuj(void)
{
	glLineWidth(5);											// ZMIENILEM GRUBOSC LINII
	GLfloat color[] = { 0.0f, 1.0f, 0.0f, 1.0f };   // KOLOR TŁA
	glClearBufferfv(GL_COLOR, 0, color);
	glClear(GL_COLOR_BUFFER_BIT);

	glUseProgram(programID); //uzyj programu, czyli naszego shadera	


	glDrawArrays(GL_LINE_LOOP, 0, 3); // Zaczynamy od 0 i rysujemy wszystkie wierzcholki	//GL_LINE_LOOP RYSUJE KONTURY

	//glFlush();
	glutSwapBuffers();

}
/*###############################################################*/
void rozmiar(int width, int height)
{
	screen_width = width;
	screen_height = height;

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glViewport(0, 0, screen_width, screen_height);

	glutPostRedisplay(); // Przerysowanie sceny
}

/*###############################################################*/
void idle()
{

	glutPostRedisplay();
}

/*###############################################################*/
GLfloat k = 0.025;
GLfloat ad = 0.0;

void timer(int value) {

	if (s) ad+= k;
	if (ad > 1.5 || ad < -1.5)  // 
	k=-k;

	GLfloat attrib[] = { ad, 0.0f,0.0f };
	// Aktualizacja wartości atrybutu wejściowego 1.
	glVertexAttrib3fv(2, attrib);
	//glVertexAttrib3f(1, ad, 0.5,0.0);

	glutTimerFunc(50, timer, 0);				// PIERWSZA ZMIENNA INT SLUZY DO ZMIANY SZYBKOSCI 
}
/*###############################################################*/
int main(int argc, char **argv)
{

	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE|GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(screen_width, screen_height);
	glutInitWindowPosition(0, 0);
	glutCreateWindow("Ćwiczenia 4 zadanie 1");

	glewInit(); //init rozszerzeszeń OpenGL z biblioteki GLEW

	glutDisplayFunc(rysuj);			// def. funkcji rysuj¦cej
    glutIdleFunc(idle);			// def. funkcji rysujacej w czasie wolnym procesoora (w efekcie: ciagle wykonywanej)
	glutTimerFunc(5, timer, 0);
	glutReshapeFunc(rozmiar); // def. obs-ugi zdarzenia resize (GLUT)
									
	glutKeyboardFunc(klawisz);		// def. obsługi klawiatury
	//glutMouseFunc(mysz); 		// def. obsługi zdarzenia przycisku myszy (GLUT)
	//glutMotionFunc(mysz_ruch); // def. obsługi zdarzenia ruchu myszy (GLUT)

	
	/* úadowanie shadera, tworzenie programu *************************/
	/* i linkowanie go oraz sprawdzanie b│ŕdˇw! **********************/
	programID = loadShaders("vertex_shader.glsl", "fragment_shader.glsl");

	//tworzenie bufora wierzcholków
	glGenBuffers(1, &VBO);
	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	glEnableVertexAttribArray(0); // pierwszy buform atrybuˇw: wierzcho│ki
	glVertexAttribPointer(
		0,                  // atrybut 0. musi odpowiadaŠ atrybutowi w programie shader
		3,                  // wielkoťŠ (x,y,z)
		GL_FLOAT,           // typ
		GL_FALSE,           // czy znormalizowany [0-1]?
		0,                  // stride
		(void*)0            // array buffer offset
	);

	glutMainLoop();					// start
	
	glDeleteBuffers(1,&VBO);

	return(0);
}

