package com.example.polymorphism;

import javafx.application.*;
import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.layout.*;
import javafx.scene.control.*;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import java.util.*;

import javafx.scene.paint.Color;


class Shape {
    public void draw(GraphicsContext gc) {}
    public void count(GraphicsContext gc) {}
}

class Circle extends Shape {
    int x=110;
    int y=60;
    double r=30;
    double area=0;
    public void draw(GraphicsContext gc) {
        gc.setFill(Color.RED);
        gc.fillOval(x, y, r, r);
    }
    public void count(GraphicsContext gc) {
        area = 3.14*r*r;
        System.out.println("Circle area: " + area);
    }
}

class Square extends Shape {
    int x=240;
    int y=120;
    double r=30;
    double area=0;
    public void draw(GraphicsContext gc) {
        gc.setFill(Color.GREEN);
        gc.fillRect(x, y, r, r);

    }
    public void count(GraphicsContext gc) {
        area = r*r;
        System.out.println("Square area: " + area);
    }
}

class Rect extends Shape {
    int x=500;
    int y=200;
    double w=30;
    double h =60;
    double area=0;
    public void draw(GraphicsContext gc) {
        gc.setFill(Color.BLUE);
        gc.fillRect(x, y, w, h);

    }
    public void count(GraphicsContext gc) {
        area = w*h;
        System.out.println("Rectangle area: " + area);
    }
}

public class JavaFXApp extends Application
{
    private static final int FRAME_WIDTH  = 960;
    private static final int FRAME_HEIGHT = 600;
    Stage stage;
    GraphicsContext gc;
    Canvas canvas;
    Shape sh[];
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        primaryStage.setTitle("JavaFX App");

        stage = primaryStage;

        Menu menu1 = new Menu("File");
        MenuItem menuItem1 = new MenuItem("Item 1");
        MenuItem menuItem2 = new MenuItem("Exit");
        menuItem2.setOnAction(e -> {
            System.out.println("Exit Selected");
            exit_dialog();
        });
        menu1.getItems().add(menuItem1);
        menu1.getItems().add(menuItem2);
        MenuBar menuBar = new MenuBar();
        menuBar.getMenus().add(menu1);
        VBox vBox = new VBox(menuBar);

        Canvas canvas = new Canvas(FRAME_WIDTH,FRAME_HEIGHT);

        gc = canvas.getGraphicsContext2D();
        vBox.getChildren().add(canvas);

        Scene scene = new Scene(vBox, 960, 600);
        primaryStage.setScene(scene);
        primaryStage.setOnCloseRequest(e -> {
            e.consume();
            exit_dialog();
        });
        Group VBox = new Group();


        sh = new Shape[10];
        sh[0] = (Circle) new Circle();
        sh[1] = (Square) new Square();
        sh[2] = (Rect) new Rect();
        for (int i = 0; i<=2; i++) {
            sh[i].draw(gc);
            sh[i].count(gc);
        }



        primaryStage.show();

    }




    public void item_1()
    {
        System.out.println("item 1");
    }

    public void exit_dialog()
    {
        System.out.println("exit dialog");


        Alert alert = new Alert(AlertType.CONFIRMATION,
                "Do you really want to exit the program?.",
                ButtonType.YES, ButtonType.NO);

        alert.setResizable(true);
        alert.onShownProperty().addListener(e -> {
            Platform.runLater(() -> alert.setResizable(false));
        });

        Optional<ButtonType> result = alert.showAndWait();
        if (result.get() == ButtonType.YES)
        {
            Platform.exit();
        }
        else
        {
        }

    }
}

