#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include "GL\glew.h"
#include "GL\freeglut.h"

#include "shaderLoader.h" //narzŕdzie do │adowania i kompilowania shaderˇw z pliku


//Wymiary okna
int screen_width = 640;
int screen_height = 640;

float vertices[] = {
	-0.2f, 0.2f, 0.0f,
	-0.2f, -0.2f, 0.0f,
	0.2f, -0.2f, 0.0f,
	0.2f, 0.2f, 0.0f			//KWADRAT
};


//shaders
GLuint programID = 0;

unsigned int VBO;
/*###############################################################*/
bool s = TRUE;
void klawisz(GLubyte key, int x, int y)
{
	switch (key) {

	case 27:    /* Esc - koniec */
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
	glLineWidth(5);
	GLfloat color[] = { 0.0f, 1.0f, 0.0f, 1.0f };
	glClearBufferfv(GL_COLOR, 0, color);
	glClear(GL_COLOR_BUFFER_BIT);

	glUseProgram(programID); //u┐yj programu, czyli naszego shadera	

	//glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	glDrawArrays(GL_QUADS, 0, 4); // Zaczynamy od 0 i rysujemy wszystkie wierzcho│ki		//GL_QUADS - KWADRAT

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
	if (ad > 0.8 || ad < -0.8)								//TU STERUJE SIE WARTOSCIAMI OFFSET
	k=-k;

	GLfloat attrib[] = { ad, 0.0f,0.0f };
	// Aktualizacja wartości atrybutu wejściowego 1.
	glVertexAttrib3fv(2, attrib);
	//glVertexAttrib3f(1, ad, 0.5,0.0);

	glutTimerFunc(10, timer, 0);
}
/*###############################################################*/
int main(int argc, char **argv)
{

	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE|GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(screen_width, screen_height);
	glutInitWindowPosition(0, 0);
	glutCreateWindow("zajecia 4 cwiczenie 2");

	glewInit(); //init rozszerzeszeń OpenGL z biblioteki GLEW

	glutDisplayFunc(rysuj);			// def. funkcji rysuj¦cej
    glutIdleFunc(idle);			// def. funkcji rysuj¦cej w czasie wolnym procesoora (w efekcie: ci¦gle wykonywanej)
	glutTimerFunc(20, timer, 0);
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

